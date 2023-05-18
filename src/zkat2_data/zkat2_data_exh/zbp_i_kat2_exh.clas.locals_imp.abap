CLASS lhc_Exhibition DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF exh_status,
        open     TYPE c LENGTH 1 VALUE 'O', " Open
        accepted TYPE c LENGTH 1 VALUE 'A', " Accepted
        closed   TYPE c LENGTH 1 VALUE 'C', " Closed
      END OF exh_status.


    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Exhibition RESULT result.

    METHODS acceptExh FOR MODIFY
      IMPORTING keys FOR ACTION Exhibition~acceptExh RESULT result.

    METHODS recalcTotalFee FOR MODIFY
      IMPORTING keys FOR ACTION Exhibition~recalcTotalFee.

*    METHODS rejectExh FOR MODIFY
*      IMPORTING keys FOR ACTION Exhibition~rejectExh RESULT result.

    METHODS closeExh FOR MODIFY
      IMPORTING keys FOR ACTION Exhibition~closeExh RESULT result.

    METHODS setInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Exhibition~setInitialStatus.

    METHODS calculateTotalFee FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Exhibition~calculateTotalFee.

    METHODS calculateExhId FOR DETERMINE ON SAVE
      IMPORTING keys FOR Exhibition~calculateExhId.

    METHODS validateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR Exhibition~validateDates.

    METHODS validateText FOR VALIDATE ON SAVE
      IMPORTING keys FOR Exhibition~validateText.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Exhibition RESULT result.

    METHODS is_update_granted IMPORTING has_before_image      TYPE abap_bool
                                        exh_status            TYPE zkat2_estatus
                              RETURNING VALUE(update_granted) TYPE abap_bool.

    METHODS is_delete_granted IMPORTING has_before_image      TYPE abap_bool
                                        exh_status            TYPE zkat2_estatus
                              RETURNING VALUE(delete_granted) TYPE abap_bool.

    METHODS is_create_granted RETURNING VALUE(create_granted) TYPE abap_bool.

ENDCLASS.

CLASS lhc_Exhibition IMPLEMENTATION.

  METHOD get_instance_features.

    " Read the exhibition status of the existing exhibitions
    READ ENTITIES OF zi_kat2_exh IN LOCAL MODE
      ENTITY Exhibition
        FIELDS ( ExhStatus ) WITH CORRESPONDING #( keys )
      RESULT DATA(exhibitions)
      FAILED failed.

    result =
      VALUE #(
        FOR exhibition IN exhibitions
          LET is_accepted =   COND #(
          WHEN exhibition-ExhStatus = exh_status-open
*          AND exhibition-ExhStartDate GT cl_abap_context_info=>get_system_date( )
                                       THEN if_abap_behv=>fc-o-enabled
          WHEN  exhibition-ExhStartDate LE cl_abap_context_info=>get_system_date( )
                                       THEN if_abap_behv=>fc-o-disabled
                                      WHEN exhibition-ExhStatus = exh_status-closed
                                      THEN if_abap_behv=>fc-o-disabled
*                                      WHEN exhibition-ExhStatus IS INITIAL

                                      ELSE if_abap_behv=>fc-o-enabled  )
              is_closed =   COND #( WHEN exhibition-ExhStatus = exh_status-closed

*              or exhibition-ExhStartDate LE cl_abap_context_info=>get_system_date( )
                                      THEN if_abap_behv=>fc-o-disabled
                                      ELSE if_abap_behv=>fc-o-enabled )
          IN
            ( %tky                 = exhibition-%tky
              %action-acceptExh = is_accepted
              %action-closeExh = is_closed
             ) ).
*exhibition-ExhStatus = exh_status-accepted

  ENDMETHOD.

  METHOD acceptExh.

    " Set the new overall status
    MODIFY ENTITIES OF zi_kat2_exh IN LOCAL MODE
      ENTITY Exhibition
         UPDATE
           FIELDS ( ExhStatus )
           WITH VALUE #( FOR key IN keys
                           ( %tky         = key-%tky
                             ExhStatus = exh_status-accepted ) )
      FAILED failed
      REPORTED reported.

    " Fill the response table
    READ ENTITIES OF zi_kat2_exh IN LOCAL MODE
      ENTITY Exhibition
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(exhibitions).

    result = VALUE #( FOR exhibition IN exhibitions
                        ( %tky   = exhibition-%tky
                          %param = exhibition ) ).
  ENDMETHOD.

  METHOD recalcTotalFee.

    TYPES: BEGIN OF ty_amount_per_currencycode,
             amount        TYPE zkat2_exh_fee,
             currency_code TYPE zkat2_exh_curr, "/dmo/currency_code,
           END OF ty_amount_per_currencycode.

    DATA: amount_per_currencycode TYPE STANDARD TABLE OF ty_amount_per_currencycode.

    " Read all relevant exh instances.
    READ ENTITIES OF zi_kat2_exh IN LOCAL MODE
          ENTITY Exhibition
             FIELDS ( ExhFee CurrencyCode )
             WITH CORRESPONDING #( keys )
          RESULT DATA(exhibitions).

    DELETE exhibitions WHERE CurrencyCode IS INITIAL.

    LOOP AT exhibitions ASSIGNING FIELD-SYMBOL(<exhibition>).
      " Set the start for the calculation by adding the exh fee.
      amount_per_currencycode = VALUE #( ( amount        = <exhibition>-ExhFee
                                           currency_code = <exhibition>-CurrencyCode ) ).
      " Read all associated parts and add them to the total price.
      READ ENTITIES OF ZI_kat2_exh IN LOCAL MODE
         ENTITY Exhibition BY \_Participation
            FIELDS ( ExhFee CurrencyCode )
          WITH VALUE #( ( %tky = <exhibition>-%tky ) )
          RESULT DATA(participations).
      LOOP AT participations INTO DATA(participation) WHERE CurrencyCode IS NOT INITIAL.
        COLLECT VALUE ty_amount_per_currencycode( amount        = participation-ExhFee
                                                  currency_code = participation-CurrencyCode ) INTO amount_per_currencycode.
      ENDLOOP.

      CLEAR <exhibition>-TotalFee.
      LOOP AT amount_per_currencycode INTO DATA(single_amount_per_currencycode).
        " If needed do a Currency Conversion
        IF single_amount_per_currencycode-currency_code = <exhibition>-CurrencyCode.
          <exhibition>-TotalFee += single_amount_per_currencycode-amount.
        ELSE.
          /dmo/cl_flight_amdp=>convert_currency(
             EXPORTING
               iv_amount                   =  single_amount_per_currencycode-amount
               iv_currency_code_source     =  single_amount_per_currencycode-currency_code
               iv_currency_code_target     =  <exhibition>-CurrencyCode
               iv_exchange_rate_date       =  cl_abap_context_info=>get_system_date( )
             IMPORTING
               ev_amount                   = DATA(total_part_fee_per_curr)
            ).
          <exhibition>-TotalFee += total_part_fee_per_curr.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

    " write back the modified total_price of travels
    MODIFY ENTITIES OF zi_kat2_exh IN LOCAL MODE
      ENTITY Exhibition
        UPDATE FIELDS ( TotalFee )
        WITH CORRESPONDING #( exhibitions ).

  ENDMETHOD.

*  METHOD rejectExh.
*  ENDMETHOD.
  METHOD closeExh.

    " Set the new overall status
    MODIFY ENTITIES OF zi_kat2_exh IN LOCAL MODE
      ENTITY Exhibition
         UPDATE
           FIELDS ( ExhStatus )
           WITH VALUE #( FOR key IN keys
                           ( %tky         = key-%tky
                             ExhStatus = exh_status-closed ) )
      FAILED failed
      REPORTED reported.

    " Fill the response table
    READ ENTITIES OF zi_kat2_exh IN LOCAL MODE
      ENTITY Exhibition
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(exhibitions).

    result = VALUE #( FOR exhibition IN exhibitions
                        ( %tky   = exhibition-%tky
                          %param = exhibition ) ).

  ENDMETHOD.


  METHOD setInitialStatus.

    " Read relevant exh instance data
    READ ENTITIES OF zi_kat2_exh IN LOCAL MODE
      ENTITY Exhibition
        FIELDS ( ExhStatus ) WITH CORRESPONDING #( keys )
      RESULT DATA(exhibitions).

    " Remove all exhibition instance data with defined status
    DELETE exhibitions WHERE ExhStatus IS NOT INITIAL.
    CHECK exhibitions IS NOT INITIAL.

    " Set default exhibition status
    MODIFY ENTITIES OF zi_kat2_exh IN LOCAL MODE
    ENTITY Exhibition
      UPDATE
        FIELDS ( ExhStatus )
        WITH VALUE #( FOR exhibition IN exhibitions
                      ( %tky         = exhibition-%tky
                        ExhStatus = exh_status-open ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).

  ENDMETHOD.

  METHOD calculateTotalFee.


*    MODIFY ENTITIES OF zi_kat2_exh IN LOCAL MODE
*          ENTITY Exhibition
*            EXECUTE recalcTotalFee
*            FROM CORRESPONDING #( keys )
*          REPORTED DATA(execute_reported).
*
*    reported = CORRESPONDING #( DEEP execute_reported ).


    DATA lv_update TYPE TABLE FOR UPDATE ZI_kat2_exh\\Exhibition.
    DATA lv_sum TYPE zkat2_exh_fee.


    READ ENTITIES OF ZI_KAT2_exh IN LOCAL MODE
      ENTITY Exhibition  BY \_Participation
        FIELDS ( PartId ) WITH CORRESPONDING #( keys )
*         WITH VALUE #( ( %tky = exhibition-%tky ) )
      RESULT DATA(parts).

    " remove lines where
    DELETE parts WHERE ExhFee IS INITIAL.

    " anything left ?
    CHECK parts IS NOT INITIAL.

    LOOP AT parts INTO DATA(part).
      DATA(lv_fee) = part-ExhFee.

      lv_sum += lv_fee.
      APPEND VALUE #( %tky      = part-%tky
                      TotalFee = lv_sum
                    ) TO lv_update.
    ENDLOOP.


    MODIFY ENTITIES OF ZI_kat2_exh IN LOCAL MODE
        ENTITY Exhibition
          UPDATE FIELDS ( TotalFee ) WITH lv_update
        REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).





  ENDMETHOD.

  METHOD calculateExhId.

    " Please note that this is just an example for calculating a field during _onSave_.
    " This approach does NOT ensure for gap free or unique Exh IDs! It just helps to provide a readable ID.
    " The key of this business object is a UUID, calculated by the framework.

    " check if ExhID is already filled
    READ ENTITIES OF zi_kat2_exh IN LOCAL MODE
      ENTITY Exhibition
        FIELDS ( ExhId ) WITH CORRESPONDING #( keys )
      RESULT DATA(exhibitions).

    " remove lines where ExhID is already filled.
    DELETE exhibitions WHERE ExhId IS NOT INITIAL.

    " anything left ?
    CHECK exhibitions IS NOT INITIAL.

    " Select max exhibition ID
    SELECT SINGLE
        FROM  zkat2_aexh
        FIELDS MAX( exh_id ) AS exhID
        INTO @DATA(max_exhid).

    " Set the exhibition ID
    MODIFY ENTITIES OF zi_kat2_exh IN LOCAL MODE
    ENTITY Exhibition
      UPDATE
        FROM VALUE #( FOR exhibition IN exhibitions INDEX INTO i (
          %tky              = exhibition-%tky
          ExhId          = max_exhid + i
          %control-ExhId = if_abap_behv=>mk-on ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).

  ENDMETHOD.

  METHOD validateDates.

    " Read relevant travel instance data
    READ ENTITIES OF zi_kat2_exh IN LOCAL MODE
      ENTITY Exhibition
        FIELDS ( ExhID ExhStartDate ExhEndDate ) WITH CORRESPONDING #( keys )
      RESULT DATA(exhibitions).

    LOOP AT exhibitions INTO DATA(exhibition).
      " Clear state messages that might exist
      APPEND VALUE #(  %tky        = exhibition-%tky
                       %state_area = 'VALIDATE_DATES' )
        TO reported-exhibition.

      IF exhibition-ExhEndDate < exhibition-ExhStartDate.
        APPEND VALUE #( %tky = exhibition-%tky ) TO failed-exhibition.
        APPEND VALUE #( %tky               = exhibition-%tky
                        %state_area        = 'VALIDATE_DATES'
                        %msg               = NEW zcm_kat2_rap(
                                                 severity  = if_abap_behv_message=>severity-error
                                                 textid    = zcm_kat2_rap=>date_interval
                                                 exhstartdate = exhibition-ExhStartDate
                                                 exhenddate   = exhibition-ExhEndDate
                                                 exhid  = exhibition-ExhID )
                        %element-ExhStartDate = if_abap_behv=>mk-on
                        %element-ExhEndDate   = if_abap_behv=>mk-on ) TO reported-exhibition.

      ELSEIF exhibition-ExhStartDate < cl_abap_context_info=>get_system_date( ).
        APPEND VALUE #( %tky               = exhibition-%tky ) TO failed-exhibition.
        APPEND VALUE #( %tky               = exhibition-%tky
                        %state_area        = 'VALIDATE_DATES'
                        %msg               = NEW zcm_kat2_rap(
                                                 severity  = if_abap_behv_message=>severity-error
                                                 textid    = zcm_kat2_rap=>begin_date_before_system_date
                                                 exhstartdate = exhibition-ExhStartDate )
                        %element-ExhStartDate = if_abap_behv=>mk-on ) TO reported-exhibition.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD validateText.

  ENDMETHOD.

  METHOD get_instance_authorizations.

    DATA: has_before_image    TYPE abap_bool,
          is_update_requested TYPE abap_bool,
          is_delete_requested TYPE abap_bool,
          update_granted      TYPE abap_bool,
          delete_granted      TYPE abap_bool.

    DATA: failed_exhibition LIKE LINE OF failed-exhibition.

    " Read the existing exhibitions
    READ ENTITIES OF zi_kat2_exh IN LOCAL MODE
      ENTITY Exhibition
        FIELDS ( ExhStatus ) WITH CORRESPONDING #( keys )
      RESULT DATA(exhibitions)
      FAILED failed.

    CHECK exhibitions IS NOT INITIAL.

*   In this example the authorization is defined based on the Activity + Exhibition Status
*   For the Exhibition Status we need the before-image from the database. We perform this for active (is_draft=00) as well as for drafts (is_draft=01) as we can't distinguish between edit or new drafts
    SELECT FROM zkat2_aexh
      FIELDS exh_uuid,
      exh_id,
      exh_status
      FOR ALL ENTRIES IN @exhibitions
      WHERE exh_uuid EQ @exhibitions-ExhUuid
      ORDER BY PRIMARY KEY
      INTO TABLE @DATA(exhibitions_before_image).

    is_update_requested = COND #( WHEN requested_authorizations-%update              = if_abap_behv=>mk-on OR
                                       requested_authorizations-%action-acceptExh = if_abap_behv=>mk-on OR
                                       requested_authorizations-%action-closeExh = if_abap_behv=>mk-on OR
                                      requested_authorizations-%action-Prepare      = if_abap_behv=>mk-on OR
                                      requested_authorizations-%action-Edit         = if_abap_behv=>mk-on OR
                                       requested_authorizations-%assoc-_Participation      = if_abap_behv=>mk-on
                                  THEN abap_true ELSE abap_false ).

    is_delete_requested = COND #( WHEN requested_authorizations-%delete = if_abap_behv=>mk-on
                                    THEN abap_true ELSE abap_false ).

    LOOP AT exhibitions INTO DATA(exhibition).
      update_granted = delete_granted = abap_false.

      READ TABLE exhibitions_before_image INTO DATA(exhibition_before_image)
           WITH KEY exh_uuid = exhibition-ExhUuid BINARY SEARCH.
      has_before_image = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).

      IF is_update_requested = abap_true.
        " Edit of an existing record -> check update authorization
        IF has_before_image = abap_true.
          update_granted = is_update_granted( has_before_image = has_before_image  exh_status = exhibition_before_image-exh_status ).
          IF update_granted = abap_false.
            APPEND VALUE #( %tky        = exhibition-%tky
                            %msg        = NEW zcm_kat2_rap( severity = if_abap_behv_message=>severity-error
                                                            textid   = zcm_kat2_rap=>unauthorized )
                          ) TO reported-exhibition.
          ENDIF.
          " Creation of a new record -> check create authorization
        ELSE.
          update_granted = is_create_granted( ).
          IF update_granted = abap_false.
            APPEND VALUE #( %tky        = exhibition-%tky
                            %msg        = NEW zcm_kat2_rap( severity = if_abap_behv_message=>severity-error
                                                            textid   = zcm_kat2_rap=>unauthorized )
                          ) TO reported-exhibition.
          ENDIF.
        ENDIF.
      ENDIF.

      IF is_delete_requested = abap_true.
        delete_granted = is_delete_granted( has_before_image = has_before_image  exh_status = exhibition_before_image-exh_status ).
        IF delete_granted = abap_false.
          APPEND VALUE #( %tky        = exhibition-%tky
                          %msg        = NEW zcm_kat2_rap( severity = if_abap_behv_message=>severity-error
                                                          textid   = zcm_kat2_rap=>unauthorized )
                        ) TO reported-exhibition.
        ENDIF.
      ENDIF.

      APPEND VALUE #( %tky = exhibition-%tky

                      %update              = COND #( WHEN update_granted = abap_true THEN if_abap_behv=>auth-allowed ELSE if_abap_behv=>auth-unauthorized )
                      %action-acceptExh = COND #( WHEN update_granted = abap_true THEN if_abap_behv=>auth-allowed ELSE if_abap_behv=>auth-unauthorized )
                      %action-closeExh = COND #( WHEN update_granted = abap_true THEN if_abap_behv=>auth-allowed ELSE if_abap_behv=>auth-unauthorized )
                     %action-Prepare      = COND #( WHEN update_granted = abap_true THEN if_abap_behv=>auth-allowed ELSE if_abap_behv=>auth-unauthorized )
                     %action-Edit         = COND #( WHEN update_granted = abap_true THEN if_abap_behv=>auth-allowed ELSE if_abap_behv=>auth-unauthorized )
                      %assoc-_Participation      = COND #( WHEN update_granted = abap_true THEN if_abap_behv=>auth-allowed ELSE if_abap_behv=>auth-unauthorized )

                      %delete              = COND #( WHEN delete_granted = abap_true THEN if_abap_behv=>auth-allowed ELSE if_abap_behv=>auth-unauthorized )
                    )
        TO result.
    ENDLOOP.


  ENDMETHOD.

  METHOD is_create_granted.

    AUTHORITY-CHECK OBJECT 'ZKAT2OSTAT'
    ID 'ZKAT2OSTAT' DUMMY
    ID 'ACTVT' FIELD '01'.
    create_granted = COND #(  WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).
    " Simulate full access - for testing purposes only! Needs to be removed for a productive implementation.
    create_granted = abap_true.

  ENDMETHOD.

  METHOD is_delete_granted.

    IF has_before_image = abap_true.
      AUTHORITY-CHECK OBJECT 'ZKAT2OSTAT'
      ID 'ZKAT2OSTAT' FIELD exh_status
      ID 'ACTVT' FIELD '06'.
    ELSE.
      AUTHORITY-CHECK OBJECT 'ZKAT2OSTAT'
      ID 'ZKAT2OSTAT' DUMMY
      ID 'ACTVT' FIELD '06'.
    ENDIF.
    delete_granted = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).

    " Simulate full access - for testing purposes only! Needs to be removed for a productive implementation.
    delete_granted = abap_true.

  ENDMETHOD.

  METHOD is_update_granted.

    IF has_before_image = abap_true.
      AUTHORITY-CHECK OBJECT 'ZKAT2OSTAT'
      ID 'ZKAT2OSTAT' FIELD exh_status
      ID 'ACTVT' FIELD '02'.
    ELSE.
      AUTHORITY-CHECK OBJECT 'ZKAT2OSTAT'
      ID 'ZKAT2OSTAT' DUMMY
      ID 'ACTVT' FIELD '02'.
    ENDIF.
    update_granted = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).

    " Simulate full access - for testing purposes only! Needs to be removed for a productive implementation.
    update_granted = abap_true.

  ENDMETHOD.

ENDCLASS.

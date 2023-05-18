CLASS lhc_Awork DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

       METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Awork RESULT result.

    METHODS checkStatus FOR MODIFY
      IMPORTING keys FOR ACTION Awork~checkStatus RESULT result.

    METHODS recheckStatus FOR MODIFY
      IMPORTING keys FOR ACTION Awork~recheckStatus.

    METHODS setInitialStatus FOR DETERMINE ON SAVE
      IMPORTING keys FOR Awork~setInitialStatus.

    METHODS calculateAworkId FOR DETERMINE ON SAVE
      IMPORTING keys FOR Awork~calculateAworkId.

    METHODS validateAuthor FOR VALIDATE ON SAVE
      IMPORTING keys FOR Awork~validateAuthor.

    METHODS validateStatusOnC FOR VALIDATE ON SAVE
      IMPORTING keys FOR Awork~validateStatusOnC.

    METHODS validateStatusOnD FOR VALIDATE ON SAVE
      IMPORTING keys FOR Awork~validateStatusOnD.

    METHODS validateStatusOnU FOR VALIDATE ON SAVE
      IMPORTING keys FOR Awork~validateStatusOnU.

    METHODS validateYear FOR VALIDATE ON SAVE
      IMPORTING keys FOR Awork~validateYear.


ENDCLASS.

CLASS lhc_Awork IMPLEMENTATION.

  METHOD get_instance_features.

  ENDMETHOD.

  METHOD checkStatus.

  ENDMETHOD.

  METHOD recheckStatus.

  ENDMETHOD.

  METHOD setInitialStatus.
    " Read relevant exh instance data
    READ ENTITIES OF zi_kat2_awork_fill IN LOCAL MODE
      ENTITY Awork
        FIELDS ( AwStatus
*        Language
        ) WITH CORRESPONDING #( keys )
      RESULT DATA(aworks).

    " Remove all exhibition instance data with defined status
    DELETE aworks WHERE AwStatus IS NOT INITIAL.
    CHECK aworks IS NOT INITIAL.

    " Set default exhibition status
    MODIFY ENTITIES OF zi_kat2_awork_fill IN LOCAL MODE
    ENTITY Awork
      UPDATE
        FIELDS ( AwStatus
*        Language
         )
        WITH VALUE #( FOR awork IN aworks
                      ( %tky         = awork-%tky
                        AwStatus = 2
*                        Language = cl_abap_context_info=>get_user_language_abap_format( )
                        ) )
    FAILED DATA(failed)
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).



  ENDMETHOD.

  METHOD calculateAworkId.

    " Please note that this is just an example for calculating a field during _onSave_.
    " This approach does NOT ensure for gap free or unique Exh IDs! It just helps to provide a readable ID.
    " The key of this business object is a UUID, calculated by the framework.

    " check if ID is already filled
    READ ENTITIES OF ZI_KAT2_AWORK_fill IN LOCAL MODE
      ENTITY Awork
        FIELDS ( AworkId ) WITH CORRESPONDING #( keys )
      RESULT DATA(aworks).

    " remove lines where ExhID is already filled.
    DELETE aworks WHERE AworkId IS NOT INITIAL.

    " anything left ?
    CHECK aworks IS NOT INITIAL.

    " Select max awork ID
    SELECT SINGLE
        FROM  zkat2_awork
        FIELDS MAX( awork_id ) AS AworkID
        INTO @DATA(max_aworkid).

    " Set the awork ID
    MODIFY ENTITIES OF ZI_KAT2_AWORK_fill IN LOCAL MODE
    ENTITY Awork
      UPDATE
        FROM VALUE #( FOR awork IN aworks INDEX INTO i (
          %tky              = awork-%tky
          AworkId          = max_aworkid + i
          %control-AworkId = if_abap_behv=>mk-on ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).

  ENDMETHOD.

  METHOD validateAuthor.

    " Read data
    READ ENTITIES OF zi_kat2_awork_fill IN LOCAL MODE
    ENTITY Awork
    FIELDS (  AuthorId ) WITH CORRESPONDING #(  keys )
    RESULT DATA(aworks).

    DATA authors TYPE SORTED TABLE OF zkat2_author WITH UNIQUE KEY author_id.

    " Optimization of DB select
    authors = CORRESPONDING #(  aworks DISCARDING DUPLICATES MAPPING author_id = AuthorId EXCEPT * ).
    DELETE authors WHERE author_id IS INITIAL.

    IF authors IS NOT INITIAL.
      " Check if ID  exist
      SELECT FROM zkat2_author FIELDS author_id
      FOR ALL ENTRIES IN @authors
      WHERE author_id = @authors-author_id
      INTO TABLE @DATA(authors_db).
    ENDIF.

    " Raise msg for non existing and initial authorID
    LOOP AT aworks INTO DATA(awork).
      " Clear state messages that might exist
      APPEND VALUE #(  %tky               = awork-%tky
                       %state_area        = 'VALIDATE_AUTHOR' )
        TO reported-awork.

      IF awork-AuthorId IS INITIAL OR NOT line_exists( authors_db[ author_id = awork-AuthorId ] ).
        APPEND VALUE #( %tky = awork-%tky ) TO failed-awork.

        APPEND VALUE #( %tky        = awork-%tky
                        %state_area = 'VALIDATE_AUTHOR'
                        %msg        = NEW zcm_kat2_rap(
                                          severity = if_abap_behv_message=>severity-error
                                          textid   = zcm_kat2_rap=>author_unknown
                                          authorid = awork-AuthorId )
                        %element-AuthorId = if_abap_behv=>mk-on )
          TO reported-awork.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.

  METHOD validateStatusOnC.

  ENDMETHOD.

  METHOD validateStatusOnD.

  ENDMETHOD.

  METHOD validateStatusOnU.

  ENDMETHOD.

  METHOD validateYear.

    " Read data
    READ ENTITIES OF zi_kat2_awork_fill IN LOCAL MODE
    ENTITY Awork
    FIELDS (  CreatYear ) WITH CORRESPONDING #(  keys )
    RESULT DATA(aworks).

    " Raise msg for non existing and initial authorID
    LOOP AT aworks INTO DATA(awork).
      " Clear state messages that might exist
      APPEND VALUE #(  %tky               = awork-%tky
                       %state_area        = 'VALIDATE_YEAR' )
        TO reported-awork.

      IF awork-CreatYear IS INITIAL
*      OR NOT line_exists( authors_db[ author_id = awork-AuthorId ] )
.
        APPEND VALUE #( %tky = awork-%tky ) TO failed-awork.

        APPEND VALUE #( %tky        = awork-%tky
                        %state_area = 'VALIDATE_YEAR'
                        %msg        = NEW zcm_kat2_rap(
                                          severity = if_abap_behv_message=>severity-error
                                          textid   = zcm_kat2_rap=>empty_field
*                                          authorid = awork-AuthorId
                                          )
                        %element-CreatYear = if_abap_behv=>mk-on )
          TO reported-awork.
        DATA lv_year TYPE sy-datum.
       lv_year = sy-datum.
*       cl_abap_context_info=>get_system_date( ).

      ELSEIF awork-CreatYear GT sy-datum+0(4).
        APPEND VALUE #( %tky = awork-%tky ) TO failed-awork.
        APPEND VALUE #( %tky               = awork-%tky
                        %state_area = 'VALIDATE_YEAR'
                        %msg               = NEW zcm_kat2_rap(
                                                 severity  = if_abap_behv_message=>severity-error
                                                 textid    = zcm_kat2_rap=>future_year
                                                 creatyear = awork-CreatYear )
                        %element-CreatYear = if_abap_behv=>mk-on ) TO reported-awork.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.



ENDCLASS.

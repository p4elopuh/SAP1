CLASS lhc_Participation DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS calculatePartId FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Participation~calculatePartId.

    METHODS setExhId FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Participation~setExhId.
    METHODS setFee FOR DETERMINE ON SAVE
      IMPORTING keys FOR Participation~setFee.

ENDCLASS.

CLASS lhc_Participation IMPLEMENTATION.

  METHOD calculatePartId.


    " check if ID is already filled
    READ ENTITIES OF ZI_KAT2_exh IN LOCAL MODE
      ENTITY Participation
*      BY \_Exhibition
        FIELDS ( PartId ) WITH CORRESPONDING #( keys )
      RESULT DATA(parts).

    " remove lines where ExhID is already filled.
*    DELETE exhs WHERE ExhId IS NOT INITIAL.

    " anything left ?
    CHECK parts IS NOT INITIAL.

    " Select max awork ID
    SELECT SINGLE
        FROM  zkat2_apart
        FIELDS MAX( part_id ) AS PartID
*        INTO @update.
        INTO @DATA(max_partid).

    " Set the awork ID
    MODIFY ENTITIES OF ZI_kat2_exh IN LOCAL MODE
    ENTITY Participation
      UPDATE
       FROM VALUE #( FOR part IN parts INDEX INTO i (
          %tky              = part-%tky
          PartId          = max_partid + i
          %control-PartId = if_abap_behv=>mk-on ) )

*      FIELDS ( PartId ) WITH max_partid
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).




  ENDMETHOD.


  METHOD setExhId.


    DATA update TYPE TABLE FOR UPDATE ZI_kat2_exh\\Participation.

    " Read relevant part instance data
    READ ENTITIES OF zi_kat2_exh IN LOCAL MODE
      ENTITY Participation
        FIELDS ( ExhId ExhUUID ) WITH CORRESPONDING #( keys )
      RESULT DATA(parts).

    " Remove all  instance data with defined ID
    DELETE parts WHERE ExhId IS NOT INITIAL.
    CHECK parts IS NOT INITIAL.

    LOOP AT parts INTO DATA(part).
      SELECT SINGLE FROM zkat2_aexh
      FIELDS exh_id
      WHERE exh_uuid = @part-ExhUUID
      INTO @part-ExhId.

      APPEND VALUE #( %tky      = part-%tky
                      ExhId = part-ExhId
                    ) TO update.
    ENDLOOP.

    " Update the participation with ExhID


    MODIFY ENTITIES OF ZI_kat2_exh IN LOCAL MODE
    ENTITY Participation
      UPDATE FIELDS ( ExhId ) WITH update
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).

  ENDMETHOD.

  METHOD setFee.

    DATA update TYPE TABLE FOR UPDATE ZI_kat2_exh\\Participation.

    " Read relevant part instance data
    READ ENTITIES OF zi_kat2_exh IN LOCAL MODE
      ENTITY Participation
        FIELDS ( ExhFee ExhUUID ) WITH CORRESPONDING #( keys )
      RESULT DATA(parts).

    " Remove all  instance data with defined ID
    DELETE parts WHERE ExhFee IS NOT INITIAL.
    CHECK parts IS NOT INITIAL.


    DATA lv_fee TYPE zkat2_exh_fee.
    LOOP AT parts INTO DATA(lv_part).
      lv_fee = lv_part-ExhFee.

    ENDLOOP.

    IF lv_fee NE 0.
      LOOP AT parts INTO DATA(part).
        SELECT SINGLE FROM zkat2_aexh
        FIELDS exh_fee
        WHERE exh_uuid = @part-ExhUUID
        INTO @part-ExhFee.



        APPEND VALUE #( %tky      = part-%tky
                        ExhFee = part-ExhFee
                      ) TO update.


      ENDLOOP.


      MODIFY ENTITIES OF ZI_kat2_exh IN LOCAL MODE
      ENTITY Participation
        UPDATE FIELDS ( ExhFee ) WITH update
      REPORTED DATA(update_reported).

      reported = CORRESPONDING #( DEEP update_reported ).

    ENDIF.
    " Update the participation with ExhID



  ENDMETHOD.

ENDCLASS.

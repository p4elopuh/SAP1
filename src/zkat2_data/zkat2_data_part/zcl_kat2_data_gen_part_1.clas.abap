CLASS zcl_kat2_data_gen_part_1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS:
      fill_part.


ENDCLASS.



CLASS ZCL_KAT2_DATA_GEN_PART_1 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    me->fill_part(  ).
    out->write('Participation Data inserted').
  ENDMETHOD.


  METHOD fill_part.

    DATA: lt_part TYPE TABLE OF zkat2_apart.
    DATA: lv_created_at TYPE timestampl.
    DATA: lv_created_by TYPE syuname.
    DATA: lv_aw_uuid TYPE sysuuid_x16.
    DATA: lv_exh_uuid TYPE sysuuid_x16.


    lt_part = VALUE #(
    ( client = '100' part_id = '300001' awork_id = '100027' exh_id = '200011' part_status = 'R'  )
    ( client = '100' part_id = '300002' awork_id = '100022' exh_id = '200016' part_status = 'O'  )
    ( client = '100' part_id = '300004' awork_id = '100002' exh_id = '200011' part_status = 'F'  )
    ( client = '100' part_id = '300005' awork_id = '100018' exh_id = '200014' part_status = 'A'  )
    ( client = '100' part_id = '300006' awork_id = '100020' exh_id = '200015' part_status = 'S'  )
    ( client = '100' part_id = '300007' awork_id = '100023' exh_id = '200016' part_status = 'F'  )
    ( client = '100' part_id = '300008' AwORK_ID = '100024' exh_id = '200016' part_status = 'F'  )
    ( client = '100' part_id = '300009' awork_id = '100004' exh_id = '200013' part_status = 'F'  )
    ( client = '100' part_id = '300010' awork_id = '100007' exh_id = '200013' part_status = 'F'  )
    ( client = '100' part_id = '300011' awork_id = '100013' exh_id = '200017' part_status = 'O'  )
    ( client = '100' part_id = '300012' awork_id = '100014' exh_id = '200017' part_status = 'O'  )
    ( client = '100' part_id = '300013' awork_id = '100024' exh_id = '200015' part_status = 'S'  )
    ( client = '100' part_id = '300014' awork_id = '100033' exh_id = '200012' part_status = 'R'  )
    ( client = '100' part_id = '300015' awork_id = '100027' exh_id = '200015' part_status = 'S'  )
    ( client = '100' part_id = '300016' awork_id = '100002' exh_id = '200017' part_status = 'R'  )
    ( client = '100' part_id = '300017' awork_id = '100007' exh_id = '200017' part_status = 'O'  )
    ( client = '100' part_id = '300018' awork_id = '100005' exh_id = '200015' part_status = 'O'  )
    ( client = '100' part_id = '300019' awork_id = '100018' exh_id = '200015' part_status = 'O'  )
    ( client = '100' part_id = '300020' awork_id = '100012' exh_id = '200015' part_status = 'A'  )
    ( client = '100' part_id = '300021' awork_id = '100002' exh_id = '200017' part_status = 'A'  )
    ( client = '100' part_id = '300022' awork_id = '100015' exh_id = '200017' part_status = 'A'  )
    ( client = '100' part_id = '300023' awork_id = '100001' exh_id = '200017' part_status = 'A'  )
    ( client = '100' part_id = '300024' awork_id = '100026' exh_id = '200017' part_status = 'A'  )
    ( client = '100' part_id = '300025' awork_id = '100002' exh_id = '200017' part_status = 'R'  )
    ( client = '100' part_id = '300026' awork_id = '100013' exh_id = '200017' part_status = 'C'  )
    ( client = '100' part_id = '300027' awork_id = '100017' exh_id = '200015' part_status = 'C'  )
    ).


    LOOP AT lt_part ASSIGNING FIELD-SYMBOL(<fs_part>).
      TRY.

          <fs_part>-part_uuid =
          cl_system_uuid=>create_uuid_x16_static( ).
        CATCH cx_uuid_error.
      ENDTRY.

      SELECT SINGLE
      FROM zkat2_awork
      FIELDS awork_uuid
      WHERE awork_id = @<fs_part>-awork_id
      INTO @lv_aw_uuid .

      SELECT SINGLE
      FROM zkat2_aexh
      FIELDS exh_uuid
      WHERE exh_id = @<fs_part>-exh_id
      INTO @lv_exh_uuid .

      <fs_part>-awork_uuid = lv_aw_uuid.
      <fs_part>-exh_uuid = lv_exh_uuid.
      <fs_part>-created_by = cl_abap_context_info=>get_user_alias( ).
      GET TIME STAMP FIELD lv_created_at.
      <fs_part>-created_at = lv_created_at.
      WAIT UP TO 1 SECONDS.

    ENDLOOP.

    DELETE FROM zkat2_apart.
    INSERT zkat2_apart FROM TABLE @lt_part.

    COMMIT WORK.



  ENDMETHOD.
ENDCLASS.

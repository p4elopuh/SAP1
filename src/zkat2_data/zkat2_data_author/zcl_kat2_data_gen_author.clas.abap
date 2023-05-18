CLASS zcl_kat2_data_gen_author DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS:
      fill_author.


ENDCLASS.



CLASS ZCL_KAT2_DATA_GEN_AUTHOR IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    me->fill_author(  ).
  ENDMETHOD.


  METHOD fill_author.

    DATA: lt_author TYPE TABLE OF zkat2_aauthor.
    DATA: lv_created_at TYPE timestampl.
    DATA: lv_created_by TYPE syuname.

    lt_author = VALUE #(
    ( client = '100' author_id = '000001' author_first_name = 'Tatsiana' author_last_name = 'Kavalchuk' birth_year = '1985' phone_number = '+375222222222'  )
    ( client = '100' author_id = '000002' author_first_name = 'Mikhail' author_last_name = 'Miadzvedzeu' birth_year = '2010' phone_number = '+375444444444'  )
    ( client = '100' author_id = '000003' author_first_name = 'Halina' author_last_name = 'Kavalchuk' birth_year = '1963' phone_number = '+375333333333'  )
    ( client = '100' author_id = '000004' author_first_name = 'Uladzimir' author_last_name = 'Miadzvedzeu' birth_year = '2017' )
     ).


    LOOP AT lt_author ASSIGNING FIELD-SYMBOL(<fs_author>).
      TRY.
          <fs_author>-author_uuid =
          cl_system_uuid=>create_uuid_x16_static( ).
        CATCH cx_uuid_error.
      ENDTRY.
      <fs_author>-created_by = cl_abap_context_info=>get_user_alias( ).
      GET TIME STAMP FIELD lv_created_at.
      <fs_author>-created_at = lv_created_at.
      WAIT UP TO 1 SECONDS.

    ENDLOOP.

    DELETE FROM zkat2_aauthor.
    INSERT zkat2_aauthor FROM TABLE @lt_author.

  ENDMETHOD.
ENDCLASS.

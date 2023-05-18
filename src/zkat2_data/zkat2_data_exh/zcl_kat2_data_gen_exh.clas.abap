CLASS zcl_kat2_data_gen_exh DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS:
      fill_exh.


ENDCLASS.



CLASS ZCL_KAT2_DATA_GEN_EXH IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    me->fill_exh(  ).
  ENDMETHOD.


  METHOD fill_exh.

    DATA: lt_exh TYPE TABLE OF zkat2_aexh.
    DATA: lv_created_at TYPE timestampl.
    DATA: lv_created_by TYPE syuname.


    lt_exh = VALUE #(
    ( client = '100' exh_id = '200011' exh_title = 'Silver Petal'
        exh_place = 'Art Gallery "University of culture", Minsk'
        country = 'BY' exh_start_date = '20210503' exh_end_date = '20210519' )
    ( client = '100' exh_id = '200012' exh_title = 'Colors of Autumn'
        exh_place = 'Central Botanical Garden of National Academy of Sciences of Belarus, Minsk'
        country = 'BY' exh_start_date = '20201008' exh_end_date = '20201111' )
    ( client = '100' exh_id = '200016' exh_title = 'Jesien'
        exh_place = 'Wroclaw'
        country = 'PL' exh_start_date = '20220823' exh_end_date = '20220831' )
    ( client = '100' exh_id = '200014' exh_title = 'Belarus Traditional Toys in Modern Life'
        exh_place = 'Regional Center of Crafts, Grodno'
        country = 'BY' exh_start_date = '20220729' exh_end_date = '20220911' )
    ( client = '100' exh_id = '200015' exh_title = 'Seven Autumn Herbs'
        exh_place = 'Art Gallery "University of Culture", Minsk'
        country = 'BY' exh_start_date = '20221020' exh_end_date = '20221107' exh_fee = '10.00 '  currency = 'BYN' )
    ( client = '100' exh_id = '200013' exh_title = 'The Garden of Graceful Aromas'
        exh_place = 'Central Botanical Garden of National Academy of Sciences of Belarus, Minsk'
        country = 'BY' exh_start_date = '20200616' exh_end_date = '20200714' exh_fee = '5.00 '  currency = 'BYN' )
    ( client = '100' exh_id = '200017' exh_title = 'The Colors of Chrysantemums'
        exh_place = 'Botanical Garden, Minsk'
        country = 'BY' exh_start_date = '20221108' exh_end_date = '20221121'  )
    ).


    LOOP AT lt_exh ASSIGNING FIELD-SYMBOL(<fs_exh>).
      TRY.
          <fs_exh>-exh_uuid =
          cl_system_uuid=>create_uuid_x16_static( ).
        CATCH cx_uuid_error.
      ENDTRY.
      <fs_exh>-created_by = cl_abap_context_info=>get_user_alias( ).
      GET TIME STAMP FIELD lv_created_at.
      <fs_exh>-created_at = lv_created_at.
      WAIT UP TO 1 SECONDS.

    ENDLOOP.

    DELETE FROM zkat2_aexh.
    INSERT zkat2_aexh FROM TABLE @lt_exh.

  ENDMETHOD.
ENDCLASS.

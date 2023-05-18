CLASS zcl_kat2_data_gen_awork_1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS:
      fill_awork.


ENDCLASS.



CLASS ZCL_KAT2_DATA_GEN_AWORK_1 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    me->fill_awork(  ).
  ENDMETHOD.


  METHOD fill_awork.

    DATA: lt_awork TYPE TABLE OF zkat2_awork.
    DATA: lt_awork_t TYPE TABLE OF zkat2_awork_t.
    DATA: lv_created_at TYPE timestampl.
    DATA: lv_created_by TYPE syuname.
    DATA: lv_author_uuid TYPE sysuuid_x16.
    DATA: lv_exh_uuid TYPE sysuuid_x16.

    lt_awork = VALUE #(


    ( client = '100' awork_id = '100001' author_id = '000004' aw_status = '2' creat_year = '2020'   aw_title = 'The Bear in the forest' aw_description = 'A4, paper, felt-tip pen')
    ( client = '100' awork_id = '100002' author_id = '000001' aw_status = '9' creat_year = '2021'   aw_title = 'Bird on plum tree' aw_description = 'craftpaper, watercolor, ink')
    ( client = '100' awork_id = '100003' author_id = '000001' aw_status = '2' creat_year = '2019'  aw_title = 'Landscape' aw_description = 'rice paper, ink, watercolor')
    ( client = '100' awork_id = '100004' author_id = '000001' aw_status = '2' creat_year = '2019'   aw_title = 'Peony' aw_description = 'rice paper, ink, watercolor')
    ( client = '100' awork_id = '100005' author_id = '000001' aw_status = '9' creat_year = '2019'   aw_title = 'Peony' aw_description = 'rice paper, ink, watercolor')
    ( client = '100' awork_id = '100006' author_id = '000002' aw_status = '2' creat_year = '2017'   aw_title = 'Chump' aw_description = 'Wood, metal'  )
    ( client = '100' awork_id = '100007' author_id = '000001' aw_status = '6' creat_year = '2017'   aw_title = 'Peony' aw_description = 'rice paper, ink, watercolor')
    ( client = '100' awork_id = '100008' author_id = '000001' aw_status = '1' creat_year = '2021'   aw_title = 'Lotus' aw_description = 'A4, paper, ink, watercolor' )
    ( client = '100' awork_id = '100009' author_id = '000001' aw_status = '1' creat_year = '2021'  aw_title = 'Lotus' aw_description = 'A3, paper, ink, watercolor' )
    ( client = '100' awork_id = '100010' author_id = '000003' aw_status = '3' creat_year = '2022'   aw_title = 'Motanka' aw_description = 'fabric, bands, bottle')
    ( client = '100' awork_id = '100011' author_id = '000001' aw_status = '2' creat_year = '2021'   aw_title = 'White peony' aw_description = 'craftpaper, ink, watercolor')
    ( client = '100' awork_id = '100012' author_id = '000004' aw_status = '9' creat_year = '2019'    aw_title = 'Mouse "Mytcka"' aw_description = 'A4, paper, ball-pen')
    ( client = '100' awork_id = '100013' author_id = '000002' aw_status = '9' creat_year = '2022' aw_title = 'Poppy' aw_description = 'rice paper, ink, watercolor'  )
    ( client = '100' awork_id = '100014' author_id = '000001' aw_status = '4' creat_year = '2020'   aw_title = 'Poppy' aw_description = 'rice paper, ink, watercolor' )
    ( client = '100' awork_id = '100015' author_id = '000001' aw_status = '2' creat_year = '2019'   aw_title = 'Pumpkins' aw_description = 'rice paper, ink, watercolor' )
    ( client = '100' awork_id = '100016' author_id = '000001' aw_status = '2' creat_year = '2020'  aw_title = 'Raven' aw_description = 'rice paper, ink' )
    ( client = '100' awork_id = '100017' author_id = '000001' aw_status = '2' creat_year = '2020'   aw_title = 'Squirrel' aw_description = 'rice paper, ink, watercolor')
    ( client = '100' awork_id = '100018' author_id = '000001' aw_status = '9' creat_year = '2021'   aw_title = 'Cat_and_red_leaves' aw_description = 'paper, ink, watercolor')
    ( client = '100' awork_id = '100019' author_id = '000001' aw_status = '1' creat_year = '2020'   aw_title = 'Peacock' aw_description = 'paper, ink')
    ( client = '100' awork_id = '100020' author_id = '000001' aw_status = '3' creat_year = '2020'   aw_title = 'Panda_under_snow' aw_description = 'rice paper, ink, watercolor' )
    ( client = '100' awork_id = '100021' author_id = '000001' aw_status = '2' creat_year = '2019'   aw_title = 'Plum_under_snow' aw_description = 'rice paper, ink, watercolor')
    ( client = '100' awork_id = '100022' author_id = '000001' aw_status = '5' creat_year = '2021'   aw_title = 'Chrysantemum black-white' aw_description = 'Rice paper, ink' )
    ( client = '100' awork_id = '100023' author_id = '000001' aw_status = '2' creat_year = '2020'   aw_title = 'Chrysantemum_red_yellow' aw_description = 'rice paper, ink, watercolor')
    ( client = '100' awork_id = '100024' author_id = '000001' aw_status = '3' creat_year = '2020'  aw_title = 'Chrysantemum_red' aw_description = 'rice paper, ink, watercolor' )
    ( client = '100' awork_id = '100025' author_id = '000001' aw_status = '2' creat_year = '2019'  aw_title = 'Sakura' aw_description = 'rice paper, ink, watercolor')
    ( client = '100' awork_id = '100026' author_id = '000001' aw_status = '9' creat_year = '2020'   aw_title = 'Sakura' aw_description = 'rice paper, ink, watercolor')
    ( client = '100' awork_id = '100027' author_id = '000001' aw_status = '3' creat_year = '2021'  aw_title = 'Bamboo in the wind' aw_description = 'rice paper, ink, watercolor' )
    ( client = '100' awork_id = '100028' author_id = '000002' aw_status = '2' creat_year = '2021'  aw_title = 'Birds' aw_description = 'rice paper, ink, watercolor' )
    ( client = '100' awork_id = '100029' author_id = '000002' aw_status = '9' creat_year = '2022'   aw_title = 'Tulips' aw_description = 'rice paper, ink, watercolor')
    ( client = '100' awork_id = '100030' author_id = '000001' aw_status = '1' creat_year = '2022'   aw_title = 'Autumn grasses' aw_description = 'rice paper, ink, watercolor')
    ( client = '100' awork_id = '100031' author_id = '000004' aw_status = '9' creat_year = '2021'   aw_title = 'Kitty' aw_description = 'Clay')
    ( client = '100' awork_id = '100032' author_id = '000002' aw_status = '5' creat_year = '2016'  aw_title = 'Snowman' aw_description = 'Clay')
    ( client = '100' awork_id = '100033' author_id = '000001' aw_status = '2' creat_year = '2020'   aw_title = 'Purple Crysantemum' aw_description = 'Paper, ink')
    ( client = '100' awork_id = '100034' author_id = '000002' aw_status = '9' creat_year = '2020'  aw_title = 'Autumn colors' aw_description = 'Paper, ink' )
    ( client = '100' awork_id = '100035' author_id = '000001' aw_status = '2' creat_year = '2021'  aw_title = 'Japan carps' aw_description = 'Paper, ink' )
    ( client = '100' awork_id = '100037' author_id = '000001' aw_status = '9' creat_year = '2020'   aw_title = 'Magnolia' aw_description = 'Paper, ink')
    ( client = '100' awork_id = '100038' author_id = '000001' aw_status = '9' creat_year = '2021'  aw_title = 'The Bear' aw_description = 'A4, paper, felt-tip pen')
    ( client = '100' awork_id = '100039' author_id = '000001' aw_status = '2' creat_year = '2022'  aw_title = 'The Bear' aw_description = 'A4, paper, felt-tip pen')
    ( client = '100' awork_id = '100040' author_id = '000001' aw_status = '9' creat_year = '2019'   aw_title = 'Bamboo' aw_description = 'rice paper, ink, watercolor' )

    ).


    LOOP AT lt_awork ASSIGNING FIELD-SYMBOL(<fs_awork>).
      TRY.
          <fs_awork>-awork_uuid =
          cl_system_uuid=>create_uuid_x16_static( ).
        CATCH cx_uuid_error.
      ENDTRY.


      SELECT SINGLE
      FROM zkat2_author
      FIELDS author_uuid
      WHERE author_id = @<fs_awork>-author_id
      INTO @lv_author_uuid .

*      SELECT SINGLE
*      FROM zkat2_aexh
*      FIELDS exh_uuid
*      WHERE exh_id = @<fs_part>-exh_id
*      INTO @lv_exh_uuid .


*      <fs_part>-exh_uuid = lv_exh_uuid.
*      <fs_part>-created_by = cl_abap_context_info=>get_user_alias( ).
*      GET TIME STAMP FIELD lv_created_at.
*      <fs_part>-created_at = lv_created_at.
*      WAIT UP TO 1 SECONDS.

      <fs_awork>-author_uuid = lv_author_uuid.
      <fs_awork>-created_by = cl_abap_context_info=>get_user_alias( ).
      GET TIME STAMP FIELD lv_created_at.
      <fs_awork>-created_at = lv_created_at.
      WAIT UP TO 1 SECONDS.

    ENDLOOP.

    DELETE FROM zkat2_awork.
    INSERT zkat2_awork FROM TABLE @lt_awork.

    COMMIT WORK.


  ENDMETHOD.
ENDCLASS.

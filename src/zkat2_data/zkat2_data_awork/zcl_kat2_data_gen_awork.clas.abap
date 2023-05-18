CLASS zcl_kat2_data_gen_awork DEFINITION
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



CLASS ZCL_KAT2_DATA_GEN_AWORK IMPLEMENTATION.


  METHOD fill_awork.

    DATA: lt_awork TYPE TABLE OF zkat2_aawork.
    DATA: lt_awork_t TYPE TABLE OF zkat2_aawork_t.
    DATA: lv_created_at TYPE timestampl.
    DATA: lv_created_by TYPE syuname.


    lt_awork = VALUE #(


    ( client = '100' awork_id = '100001' author_id = '000004' aw_status = '2' creat_year = '2020'  )
    ( client = '100' awork_id = '100002' author_id = '000001' aw_status = '9' creat_year = '2021'  )
    ( client = '100' awork_id = '100003' author_id = '000001' aw_status = '2' creat_year = '2019'  )
    ( client = '100' awork_id = '100004' author_id = '000001' aw_status = '2' creat_year = '2019'  )
    ( client = '100' awork_id = '100005' author_id = '000001' aw_status = '9' creat_year = '2019'  )
    ( client = '100' awork_id = '100006' author_id = '000002' aw_status = '2' creat_year = '2017'  )
    ( client = '100' awork_id = '100007' author_id = '000001' aw_status = '6' creat_year = '2017'  )
    ( client = '100' awork_id = '100008' author_id = '000001' aw_status = '1' creat_year = '2021'  )
    ( client = '100' awork_id = '100009' author_id = '000001' aw_status = '1' creat_year = '2021'  )
    ( client = '100' awork_id = '100010' author_id = '000003' aw_status = '3' creat_year = '2022'  )
    ( client = '100' awork_id = '100011' author_id = '000001' aw_status = '2' creat_year = '2021'  )
    ( client = '100' awork_id = '100012' author_id = '000004' aw_status = '9' creat_year = '2019'  )
    ( client = '100' awork_id = '100013' author_id = '000002' aw_status = '9' creat_year = '2022'  )
    ( client = '100' awork_id = '100014' author_id = '000001' aw_status = '4' creat_year = '2020'  )
    ( client = '100' awork_id = '100015' author_id = '000001' aw_status = '2' creat_year = '2019'  )
    ( client = '100' awork_id = '100016' author_id = '000001' aw_status = '2' creat_year = '2020'  )
    ( client = '100' awork_id = '100017' author_id = '000001' aw_status = '2' creat_year = '2020'  )
    ( client = '100' awork_id = '100018' author_id = '000001' aw_status = '9' creat_year = '2021'  )
    ( client = '100' awork_id = '100019' author_id = '000001' aw_status = '1' creat_year = '2020'  )
    ( client = '100' awork_id = '100020' author_id = '000001' aw_status = '3' creat_year = '2020'  )
    ( client = '100' awork_id = '100021' author_id = '000001' aw_status = '2' creat_year = '2019'  )
    ( client = '100' awork_id = '100022' author_id = '000001' aw_status = '5' creat_year = '2021'  )
    ( client = '100' awork_id = '100023' author_id = '000001' aw_status = '2' creat_year = '2020'  )
    ( client = '100' awork_id = '100024' author_id = '000001' aw_status = '3' creat_year = '2020'  )
    ( client = '100' awork_id = '100025' author_id = '000001' aw_status = '2' creat_year = '2019'  )
    ( client = '100' awork_id = '100026' author_id = '000001' aw_status = '9' creat_year = '2020'  )
    ( client = '100' awork_id = '100027' author_id = '000001' aw_status = '3' creat_year = '2021'  )
    ( client = '100' awork_id = '100028' author_id = '000002' aw_status = '2' creat_year = '2021'  )
    ( client = '100' awork_id = '100029' author_id = '000002' aw_status = '9' creat_year = '2022'  )
    ( client = '100' awork_id = '100030' author_id = '000001' aw_status = '1' creat_year = '2022'  )
    ( client = '100' awork_id = '100031' author_id = '000004' aw_status = '9' creat_year = '2021'  )
    ( client = '100' awork_id = '100032' author_id = '000002' aw_status = '5' creat_year = '2016'  )
    ( client = '100' awork_id = '100033' author_id = '000001' aw_status = '2' creat_year = '2020'  )
    ( client = '100' awork_id = '100034' author_id = '000002' aw_status = '9' creat_year = '2020'  )
    ( client = '100' awork_id = '100035' author_id = '000001' aw_status = '2' creat_year = '2021'  )
    ( client = '100' awork_id = '100037' author_id = '000001' aw_status = '9' creat_year = '2020'  )
    ( client = '100' awork_id = '100038' author_id = '000001' aw_status = '9' creat_year = '2021'  )
    ( client = '100' awork_id = '100039' author_id = '000001' aw_status = '2' creat_year = '2022'  )
    ( client = '100' awork_id = '100040' author_id = '000001' aw_status = '9' creat_year = '2019'  )

    ).


    LOOP AT lt_awork ASSIGNING FIELD-SYMBOL(<fs_awork>).
      TRY.
          <fs_awork>-awork_uuid =
          cl_system_uuid=>create_uuid_x16_static( ).
        CATCH cx_uuid_error.
      ENDTRY.
      <fs_awork>-created_by = cl_abap_context_info=>get_user_alias( ).
      GET TIME STAMP FIELD lv_created_at.
      <fs_awork>-created_at = lv_created_at.
      WAIT UP TO 1 SECONDS.

    ENDLOOP.

    DELETE FROM zkat2_aawork.
    INSERT zkat2_aawork FROM TABLE @lt_awork.


    lt_awork_t = VALUE #(
    ( client = '100' spras = 'E' awork_id = '100001' aw_title = 'The Bear in the forest' aw_description = 'A4, paper, felt-tip pen'  )
    ( client = '100' spras = 'R' awork_id = '100001' aw_title = 'Медведь в лесу' aw_description = 'А4, бумага, фломастеры'  )
    ( client = '100' spras = 'L' awork_id = '100001' aw_title = 'Mis u lesie' aw_description = 'A4, papier, flomki'  )

    ( client = '100' spras = 'E' awork_id = '100002' aw_title = 'Bird on plum tree' aw_description = 'craftpaper, watercolor, ink'  )
    ( client = '100' spras = 'R' awork_id = '100002' aw_title = 'Птица на сливовой ветке' aw_description = 'рисовая тонированная бумага, пигментные краски, тушь'  )
    ( client = '100' spras = 'R' awork_id = '100003' aw_title = 'Горный пейзаж' aw_description = 'рисовая бумага, тушь, акварель'  )
    ( client = '100' spras = 'E' awork_id = '100003' aw_title = 'Landscape' aw_description = 'rice paper, ink, watercolor'  )
    ( client = '100' spras = 'E' awork_id = '100004' aw_title = 'Peony' aw_description = 'rice paper, ink, watercolor'  )
    ( client = '100' spras = 'R' awork_id = '100004' aw_title = 'Пион' aw_description = 'рисовая бумага, тушь, акварель'  )
    ( client = '100' spras = 'E' awork_id = '100005' aw_title = 'Peony' aw_description = 'rice paper, ink, watercolor'  )
    ( client = '100' spras = 'R' awork_id = '100005' aw_title = 'Пион' aw_description = 'рисовая бумага, тушь, акварель'  )
    ( client = '100' spras = 'E' awork_id = '100006' aw_title = 'Chump' aw_description = 'Wood, metal'  )
    ( client = '100' spras = 'R' awork_id = '100006' aw_title = 'Пень' aw_description = 'дерево, метал'  )
    ( client = '100' spras = 'E' awork_id = '100007' aw_title = 'Peony' aw_description = 'rice paper, ink, watercolor'  )
    ( client = '100' spras = 'R' awork_id = '100007' aw_title = 'Пион' aw_description = 'рисовая бумага, тушь, акварель'  )
    ( client = '100' spras = 'E' awork_id = '100008' aw_title = 'Lotus' aw_description = 'A4, paper, ink, watercolor'  )
    ( client = '100' spras = 'R' awork_id = '100008' aw_title = 'Лотус' aw_description = 'A4, бумага, тушь, акварель'  )
    ( client = '100' spras = 'E' awork_id = '100009' aw_title = 'Lotus' aw_description = 'A3, paper, ink, watercolor'  )
    ( client = '100' spras = 'R' awork_id = '100009' aw_title = 'Лотус' aw_description = 'A3, бумага, тушь, акварель'  )
    ( client = '100' spras = 'R' awork_id = '100010' aw_title = 'Мотанка' aw_description = 'ткань, ленты, бутылка'  )
    ( client = '100' spras = 'E' awork_id = '100010' aw_title = 'Motanka' aw_description = 'fabric, bands, bottle'  )
    ( client = '100' spras = 'E' awork_id = '100011' aw_title = 'White peony' aw_description = 'craftpaper, ink, watercolor'  )
    ( client = '100' spras = 'R' awork_id = '100011' aw_title = 'Белый пион' aw_description = 'рисовая бумага, пигментная краска, тушь'  )

    ( client = '100' spras = 'E' awork_id = '100012' aw_title = 'Mouse "Mytcka"' aw_description = 'A4, paper, ball-pen'  )
    ( client = '100' spras = 'R' awork_id = '100012' aw_title = 'Мышка "Мыцка"' aw_description = 'A4, бумага, шариковая ручка'  )


    ( client = '100' spras = 'E' awork_id = '100013' aw_title = 'Poppy' aw_description = 'rice paper, ink, watercolor'  )
    ( client = '100' spras = 'R' awork_id = '100013' aw_title = 'Мак' aw_description = 'рисовая бумага, тушь, акварель'  )
    ( client = '100' spras = 'E' awork_id = '100014' aw_title = 'Poppy' aw_description = 'rice paper, ink, watercolor'  )
    ( client = '100' spras = 'R' awork_id = '100014' aw_title = 'Мак' aw_description = 'рисовая бумага, тушь, акварель'  )
( client = '100' spras = 'R' awork_id = '100015' aw_title = 'Тыквы' aw_description = 'рисовая бумага, тушь, пигментные краски'  )
( client = '100' spras = 'E' awork_id = '100015' aw_title = 'Pumpkins' aw_description = 'rice paper, ink, watercolor'  )
( client = '100' spras = 'E' awork_id = '100016' aw_title = 'Raven' aw_description = 'rice paper, ink'  )
( client = '100' spras = 'R' awork_id = '100016' aw_title = 'Ворон' aw_description = 'рисовая бумага, тушь'  )
( client = '100' spras = 'E' awork_id = '100017' aw_title = 'Squirrel' aw_description = 'rice paper, ink, watercolor'  )
( client = '100' spras = 'R' awork_id = '100017' aw_title = 'Белка' aw_description = 'рисовая бумага, тушь, пигментные краски'  )
( client = '100' spras = 'E' awork_id = '100018' aw_title = 'Cat_and_red_leaves' aw_description = 'paper, ink, watercolor'  )
( client = '100' spras = 'R' awork_id = '100018' aw_title = 'Кошка и красные листья' aw_description = 'бумага, тушь, пигментные краски'  )
( client = '100' spras = 'E' awork_id = '100019' aw_title = 'Peacock' aw_description = 'paper, ink'  )
( client = '100' spras = 'R' awork_id = '100019' aw_title = 'Павлин' aw_description = 'бумага, тушь'  )
( client = '100' spras = 'E' awork_id = '100020' aw_title = 'Panda_under_snow' aw_description = 'rice paper, ink, watercolor'  )
( client = '100' spras = 'R' awork_id = '100020' aw_title = 'Панда под снегом' aw_description = 'рисовая бумага, тушь, пигментные краски'  )
( client = '100' spras = 'E' awork_id = '100021' aw_title = 'Plum_under_snow' aw_description = 'rice paper, ink, watercolor'  )
( client = '100' spras = 'R' awork_id = '100021' aw_title = 'Слива под снегом' aw_description = 'рисовая бумага, тушь, пигментные краски'  )
( client = '100' spras = 'E' awork_id = '100022' aw_title = 'Chrysantemum black-white' aw_description = 'Rice paper, ink'  )
( client = '100' spras = 'R' awork_id = '100022' aw_title = 'Хризантема черно-белая' aw_description = 'рисовая бумага, тушь, пигментные краски'  )
( client = '100' spras = 'E' awork_id = '100023' aw_title = 'Chrysantemum_red_yellow' aw_description = 'rice paper, ink, watercolor'  )
( client = '100' spras = 'R' awork_id = '100023' aw_title = 'Хризантема красно-желтая' aw_description = 'рисовая бумага, тушь, пигментные краски'  )
( client = '100' spras = 'E' awork_id = '100024' aw_title = 'Chrysantemum_red' aw_description = 'rice paper, ink, watercolor'  )
( client = '100' spras = 'R' awork_id = '100024' aw_title = 'Хризантема красная' aw_description = 'рисовая бумага, тушь, пигментные краски'  )
( client = '100' spras = 'E' awork_id = '100025' aw_title = 'Sakura' aw_description = 'rice paper, ink, watercolor'  )
( client = '100' spras = 'R' awork_id = '100025' aw_title = 'Сакура' aw_description = 'рисовая бумага, тушь, пигментные краски'  )
( client = '100' spras = 'R' awork_id = '100026' aw_title = 'Сакура' aw_description = 'рисовая бумага, тушь, пигментные краски'  )
( client = '100' spras = 'E' awork_id = '100026' aw_title = 'Sakura' aw_description = 'rice paper, ink, watercolor'  )
( client = '100' spras = 'R' awork_id = '100027' aw_title = 'Бамбук на ветру' aw_description = 'рисовая бумага, тушь, пигментные краски'  )
( client = '100' spras = 'E' awork_id = '100027' aw_title = 'Bamboo in the wind' aw_description = 'rice paper, ink, watercolor'  )
( client = '100' spras = 'E' awork_id = '100028' aw_title = 'Birds' aw_description = 'rice paper, ink, watercolor'  )

( client = '100' spras = 'E' awork_id = '100029' aw_title = 'Tulips' aw_description = 'rice paper, ink, watercolor'  )
( client = '100' spras = 'E' awork_id = '100030' aw_title = 'Autumn grasses' aw_description = 'rice paper, ink, watercolor'  )
( client = '100' spras = 'E' awork_id = '100031' aw_title = 'Котик' aw_description = 'Глина'  )
( client = '100' spras = 'E' awork_id = '100032' aw_title = 'Snowman' aw_description = 'Clay'  )
( client = '100' spras = 'E' awork_id = '100033' aw_title = 'Purple Crysantemum' aw_description = 'Paper, ink'  )
( client = '100' spras = 'E' awork_id = '100034' aw_title = 'Autumn colors' aw_description = 'Paper, ink'  )
( client = '100' spras = 'E' awork_id = '100035' aw_title = 'Japan carps' aw_description = 'Paper, ink'  )
( client = '100' spras = 'E' awork_id = '100037' aw_title = 'Magnolia' aw_description = 'Paper, ink'  )
( client = '100' spras = 'E' awork_id = '100038' aw_title = 'The Bear' aw_description = 'A4, paper, felt-tip pen'  )
( client = '100' spras = 'E' awork_id = '100039' aw_title = 'The Bear' aw_description = 'A4, paper, felt-tip pen'  )

( client = '100' spras = 'E' awork_id = '100040' aw_title = 'Bamboo' aw_description = 'rice paper, ink, watercolor'  )

     ).

    DELETE FROM zkat2_aawork_t.
    INSERT zkat2_aawork_t FROM TABLE @lt_awork_t.

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
    me->fill_awork(  ).
  ENDMETHOD.
ENDCLASS.

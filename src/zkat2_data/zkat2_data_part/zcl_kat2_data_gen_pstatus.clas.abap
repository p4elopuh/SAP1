CLASS zcl_kat2_data_gen_pstatus DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.

  METHODS:
      fill_pstatus.

ENDCLASS.



CLASS ZCL_KAT2_DATA_GEN_PSTATUS IMPLEMENTATION.


  METHOD fill_pstatus.

    DATA: lt_pstatus TYPE TABLE OF zkat2_pstatus.


    lt_pstatus = VALUE #(
    ( client = '100' part_status = 'A' part_status_text = 'Accepted'  )
    ( client = '100' part_status = 'R' part_status_text = 'Rejected'  )
    ( client = '100' part_status = 'C' part_status_text = 'Cancelation'  )
    ( client = '100' part_status = 'F' part_status_text = 'Finished'  )
    ( client = '100' part_status = 'S' part_status_text = 'Started'  )
    ( client = '100' part_status = 'O' part_status_text = 'Offered'  )

    ).


    DELETE FROM zkat2_pstatus.
    INSERT zkat2_pstatus FROM TABLE @lt_pstatus.

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
  me->fill_pstatus(  ).
  ENDMETHOD.
ENDCLASS.

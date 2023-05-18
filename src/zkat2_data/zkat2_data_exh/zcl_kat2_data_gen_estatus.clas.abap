CLASS zcl_kat2_data_gen_estatus DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.

  METHODS:
      fill_estatus.

ENDCLASS.



CLASS ZCL_KAT2_DATA_GEN_ESTATUS IMPLEMENTATION.


  METHOD fill_estatus.

    DATA: lt_estatus TYPE TABLE OF zkat2_e_status.


    lt_estatus = VALUE #(
    ( client = '100' exh_status = 'A' exh_status_text = 'Accepted'  )
    ( client = '100' exh_status = 'R' exh_status_text = 'Rejected'  )
    ( client = '100' exh_status = 'C' exh_status_text = 'Closed'  )
*    ( client = '100' exh_status = 'F' exh_status_text = 'Finished'  )
*    ( client = '100' exh_status = 'S' exh_status_text = 'Started'  )
    ( client = '100' exh_status = 'O' exh_status_text = 'Open'  )

    ).


    DELETE FROM zkat2_e_status.
    INSERT zkat2_e_status FROM TABLE @lt_estatus.

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
  me->fill_estatus(  ).
  ENDMETHOD.
ENDCLASS.

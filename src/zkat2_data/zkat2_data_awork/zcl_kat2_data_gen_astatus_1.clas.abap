CLASS zcl_kat2_data_gen_astatus_1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
METHODS:
      fill_astatus.


ENDCLASS.



CLASS ZCL_KAT2_DATA_GEN_ASTATUS_1 IMPLEMENTATION.


  METHOD fill_astatus.

    DATA: lt_astatus TYPE TABLE OF zkat2_astatus.


    lt_astatus = VALUE #(
    ( client = '100' aw_status = '1' aw_status_text = 'Draft'  )
    ( client = '100' aw_status = '2' aw_status_text = 'Ready'  )
    ( client = '100' aw_status = '3' aw_status_text = 'Exhibited'  )
    ( client = '100' aw_status = '4' aw_status_text = 'Damaged'  )
    ( client = '100' aw_status = '5' aw_status_text = 'Gift'  )
    ( client = '100' aw_status = '6' aw_status_text = 'Sold'  )
    ( client = '100' aw_status = '7' aw_status_text = 'Order'  )
    ( client = '100' aw_status = '8' aw_status_text = 'Lost'  )
    ( client = '100' aw_status = '9' aw_status_text = 'Proposed'  )
    ).


    DELETE FROM zkat2_astatus.
    INSERT zkat2_astatus FROM TABLE @lt_astatus.
COMMIT WORK.
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
    me->fill_astatus(  ).
  ENDMETHOD.
ENDCLASS.

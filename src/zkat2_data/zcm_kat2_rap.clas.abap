CLASS zcm_kat2_rap DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_abap_behv_message .
    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    CONSTANTS:
      BEGIN OF date_interval,
        msgid TYPE symsgid VALUE 'ZKAT2_MSG',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'EXHSTARTDATE',
        attr2 TYPE scx_attrname VALUE 'EXHENDDATE',
        attr3 TYPE scx_attrname VALUE 'EXHID',
        attr4 TYPE scx_attrname VALUE '',
      END OF date_interval .
    CONSTANTS:
      BEGIN OF begin_date_before_system_date,
        msgid TYPE symsgid VALUE 'ZKAT2_MSG',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'EXHSTARTDATE',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF begin_date_before_system_date .
    CONSTANTS:
      BEGIN OF awork_unknown,
        msgid TYPE symsgid VALUE 'ZKAT2_MSG',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'AWORKID',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF awork_unknown .
    CONSTANTS:
      BEGIN OF exh_unknown,
        msgid TYPE symsgid VALUE 'ZKAT2_MSG',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE 'EXHID',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF exh_unknown .
    CONSTANTS:
      BEGIN OF unauthorized,
        msgid TYPE symsgid VALUE 'ZKAT2_MSG',
        msgno TYPE symsgno VALUE '005',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF unauthorized .
    CONSTANTS:
      BEGIN OF author_unknown,
        msgid TYPE symsgid VALUE 'ZKAT2_MSG',
        msgno TYPE symsgno VALUE '006',
        attr1 TYPE scx_attrname VALUE 'AUTHORID',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF author_unknown .
    CONSTANTS:
      BEGIN OF empty_field,
        msgid TYPE symsgid VALUE 'ZKAT2_MSG',
        msgno TYPE symsgno VALUE '007',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF empty_field .
      CONSTANTS:
      BEGIN OF future_year,
        msgid TYPE symsgid VALUE 'ZKAT2_MSG',
        msgno TYPE symsgno VALUE '008',
        attr1 TYPE scx_attrname VALUE 'CREATYEAR',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF future_year .



*    METHODS constructor
*      IMPORTING
*        !textid   LIKE if_t100_message=>t100key OPTIONAL
*        !previous LIKE previous OPTIONAL .

    METHODS constructor
      IMPORTING
        severity     TYPE if_abap_behv_message=>t_severity DEFAULT if_abap_behv_message=>severity-error
        textid       LIKE if_t100_message=>t100key OPTIONAL
        previous     TYPE REF TO cx_root OPTIONAL
        exhstartdate TYPE zkat2_exh_start_date OPTIONAL
        exhenddate   TYPE zkat2_exh_end_date OPTIONAL
        exhid        TYPE zkat2_exh_id OPTIONAL
        aworkid      TYPE zkat2_awork_id OPTIONAL
        authorid     TYPE zkat2_auth_id  OPTIONAL
        creatyear    TYPE zkat2_creat_year OPTIONAL
      .

    DATA exhstartdate TYPE zkat2_exh_start_date READ-ONLY.
    DATA exhenddate    TYPE zkat2_exh_end_date READ-ONLY.
    DATA exhid TYPE string READ-ONLY.
    DATA aworkid TYPE string READ-ONLY.
    DATA authorid TYPE string READ-ONLY.
    DATA creatyear TYPE zkat2_creat_year READ-ONLY.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCM_KAT2_RAP IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

    me->if_abap_behv_message~m_severity = severity.
    me->exhstartdate = exhstartdate.
    me->exhenddate = exhenddate.
    me->exhid = |{ exhid ALPHA = OUT }|.
    me->aworkid = |{ aworkid ALPHA = OUT }|.
    me->authorid = |{ authorid ALPHA = OUT }|.
    me->creatyear = |{ creatyear ALPHA = OUT }|.
  ENDMETHOD.
ENDCLASS.

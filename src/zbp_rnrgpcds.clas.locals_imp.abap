CLASS lhc_buffer DEFINITION.
* 1) define the data buffer
  PUBLIC SECTION.

    TYPES: BEGIN OF ty_buffer.
             INCLUDE TYPE   zrnrgpheader AS data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_buffer.

    TYPES tdata TYPE TABLE OF ty_buffer .

    CLASS-DATA mt_data TYPE tdata.

    TYPES: BEGIN OF ty_buffer1.
             INCLUDE TYPE   zrnrgpitem AS data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_buffer1.

    TYPES tdata1 TYPE TABLE OF ty_buffer1 .

    CLASS-DATA mt_data1 TYPE tdata1.
ENDCLASS.
CLASS lhc_zrnrgpcds DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING gdata FOR CREATE zrnrgpcds.

    METHODS update FOR MODIFY
      IMPORTING tdata FOR UPDATE zrnrgpcds.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zrnrgpcds.

    METHODS read FOR READ
      IMPORTING keys FOR READ zrnrgpcds RESULT result.

    METHODS rba_item FOR READ
      IMPORTING keys_rba FOR READ zrnrgpcds\item FULL result_requested RESULT result LINK association_links.

    METHODS cba_item FOR MODIFY
      IMPORTING tgen FOR CREATE zrnrgpcds\item.

ENDCLASS.

CLASS lhc_zrnrgpcds IMPLEMENTATION.

  METHOD create.
    DATA: number TYPE cl_numberrange_runtime=>nr_number,
          mapgen LIKE LINE OF mapped-zrnrgpcds..
    DATA tgdt LIKE LINE OF lhc_buffer=>mt_data.
    LOOP AT gdata INTO DATA(dt) ."GROUP BY ( key1 = dt-plant key2 = dt-invoiceno key3 = dt-podocno key4 = dt-supplier  ).

      TRY.
          cl_numberrange_runtime=>number_get(  EXPORTING nr_range_nr = '01' object = 'ZGATEPASS' IMPORTING number = number ).
*          SELECT SINGLE * FROM zgenpoheader  WHERE plant = @dt-plant
*          AND supplier = @dt-supplier AND podocno = @dt-podocno and invoiceno = @dt-invoiceno and iscancelled ne 'X' INTO @DATA(wg).
*          IF sy-subrc NE 0.
*            LOOP AT GROUP dt INTO DATA(dt1).
          IF dt-gatepassnumber IS INITIAL.
            dt-gatepassnumber = number+10(10).
          else.
          dt-changedon =   |{ sy-datum+6(2) }.{ sy-datum+4(2) }.{ sy-datum+0(4) }|.
          dt-changetime = |{ sy-uzeit+0(2) }:{ sy-uzeit+2(2) }:{ sy-uzeit+4(2) }|.
          ENDIF.
          dt-gatepassyear = sy-datum+0(4).
          IF dt-createdon IS INITIAL.
            dt-createdon = |{ sy-datum+6(2) }.{ sy-datum+4(2) }.{ sy-datum+0(4) }|.
          ENDIF.
          IF dt-createdat IS INITIAL.
            dt-createdat = |{ sy-uzeit+0(2) }:{ sy-uzeit+2(2) }:{ sy-uzeit+4(2) }|.
          ENDIF.

          MOVE-CORRESPONDING dt TO tgdt.
          tgdt-flag = 'C'.

*  clear tgdt.
          APPEND tgdt TO lhc_buffer=>mt_data.
*              append tgdt to mapped-zgenpurchasecds.
          IF dt-%cid IS NOT INITIAL.
            MOVE-CORRESPONDING dt TO mapgen.
            APPEND mapgen TO mapped-zrnrgpcds.
*              insert VALUE #(  %cid = dt-%cid gateentryno = dt-gateentryno gateentrydate = dt-gateentrydate ) into TABLE mapped-zgenpurchasecds.
          ENDIF.
*            ENDLOOP.
*          ELSE.
*            MOVE-CORRESPONDING wg TO tgdt.
*            APPEND tgdt TO lhc_buffer=>mt_data.
*
**            EXIT.
**             LOOP AT GROUP dt INTO dt1.
***              dt-gateentryno = number+10(10).
***              dt-gateentrydate = sy-datum.
**              MOVE-CORRESPONDING dt TO tgdt.
***  clear tgdt.
**              APPEND tgdt TO lhc_buffer=>mt_data.
**            ENDLOOP.
**            MOVE-CORRESPONDING
*          ENDIF.
        CATCH cx_number_ranges.
          "handle exception
      ENDTRY.


    ENDLOOP.
  ENDMETHOD.

  METHOD update.
    LOOP AT tdata INTO DATA(td).
*  td-
    ENDLOOP.
  ENDMETHOD.

  METHOD delete.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<ks>).
      DELETE FROM zrnrgpheader WHERE  gatepassnumber = @<ks>-gatepassnumber.
    ENDLOOP.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_item.
  ENDMETHOD.

  METHOD cba_item.
    DATA:mdata1 LIKE LINE OF lhc_buffer=>mt_data1,
         mgen1  LIKE LINE OF mapped-zrnrgpitemcds.
*
    LOOP AT tgen INTO DATA(wgen).
*  wgen-%target
*      READ TABLE lhc_buffer=>mt_data INTO DATA(lcb) INDEX 1.
*      MOVE-CORRESPONDING lcb TO mdata1.
*      MOVE-CORRESPONDING lcb TO mgen1.
*      APPEND mdata1 TO lhc_buffer=>mt_data1.
*      APPEND mgen1 TO mapped-zgenpurchasecds1.
      LOOP AT wgen-%target INTO DATA(wgen1).
        READ TABLE lhc_buffer=>mt_data INTO DATA(lcb) INDEX 1.
        MOVE-CORRESPONDING wgen1 TO mdata1.
        MOVE-CORRESPONDING wgen1 TO mgen1.
        mdata1-gatepassnumber = lcb-gatepassnumber.
        mdata1-gatepassyear = sy-datum+0(4).

            "and remqty <> @wgen1-remQty.

        mgen1-gatepassnumber = lcb-gatepassnumber.
        mgen1-gatepassyear = sy-datum+0(4).
        APPEND mdata1 TO lhc_buffer=>mt_data1.
        APPEND mgen1 TO mapped-zrnrgpitemcds.
      ENDLOOP.

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_zrnrgpitemcds DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING tgen FOR CREATE zrnrgpitemcds.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zrnrgpitemcds.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zrnrgpitemcds.

    METHODS read FOR READ
      IMPORTING keys FOR READ zrnrgpitemcds RESULT result.

ENDCLASS.

CLASS lhc_zrnrgpitemcds IMPLEMENTATION.

  METHOD create.
    DATA:mdata1 LIKE LINE OF lhc_buffer=>mt_data1,
         mgen1  LIKE LINE OF mapped-zrnrgpitemcds.

    LOOP AT tgen INTO DATA(wgen).
*  wgen-
      READ TABLE lhc_buffer=>mt_data INTO DATA(lcb) INDEX 1.
      MOVE-CORRESPONDING wgen TO mdata1.
      MOVE-CORRESPONDING wgen TO mgen1.
      mdata1-gatepassnumber = lcb-gatepassnumber.
      mdata1-gatepassyear = sy-datum+0(4).
*

      mgen1-gatepassnumber = lcb-gatepassnumber.
      mgen1-gatepassyear = sy-datum+0(4).
      APPEND mdata1 TO lhc_buffer=>mt_data1.
      APPEND mgen1 TO mapped-zrnrgpitemcds.
    ENDLOOP.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zrnrgpcds DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zrnrgpcds IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    DATA lt_data TYPE STANDARD TABLE OF zrnrgpheader.
    DATA: tdata1 TYPE STANDARD TABLE OF zrnrgpitem.
    MOVE-CORRESPONDING lhc_buffer=>mt_data TO lt_data.
*    IF lt_data IS NOT INITIAL.
*    inSERT zrnrgpheader
*     FROM TABLE @lt_data.
*    IF sy-subrc NE 0.
    MODIFY zrnrgpheader FROM TABLE @lt_data.
*    ENDIF.

    MOVE-CORRESPONDING lhc_buffer=>mt_data1 TO tdata1.
    loop at tdata1 into data(td).

       update zrnrgpitem set hide = 'X' where gatepassnumber = @td-Gatepassnumber
        and gatepasstype = @td-Gatepasstype and gatepassyear = @td-Gatepassyear and lineitem = @td-Lineitem .
    endloop.
    MODIFY zrnrgpitem FROM TABLE @tdata1.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

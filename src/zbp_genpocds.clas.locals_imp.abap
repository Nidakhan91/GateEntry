CLASS lhc_buffer DEFINITION.
* 1) define the data buffer
  PUBLIC SECTION.

    TYPES: BEGIN OF ty_buffer.
             INCLUDE TYPE   zgenpocds AS data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_buffer.

    TYPES tdata TYPE TABLE OF ty_buffer .

    CLASS-DATA mt_data TYPE tdata.

    TYPES: BEGIN OF ty_buffer1.
             INCLUDE TYPE   zgenpurchasecds1 AS data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_buffer1.

    TYPES tdata1 TYPE TABLE OF ty_buffer1 .

    CLASS-DATA mt_data1 TYPE tdata1.
ENDCLASS.
CLASS lhc_zgenpurchasecds1 DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING tgen FOR CREATE zgenpurchasecds1.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zgenpurchasecds1.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zgenpurchasecds1.

    METHODS read FOR READ
      IMPORTING keys FOR READ zgenpurchasecds1 RESULT result.

ENDCLASS.

CLASS lhc_zgenpurchasecds1 IMPLEMENTATION.

  METHOD create.

    DATA:mdata1 LIKE LINE OF lhc_buffer=>mt_data1,
         mgen1  LIKE LINE OF mapped-zgenpurchasecds1.

    LOOP AT tgen INTO DATA(wgen).
*  wgen-
      READ TABLE lhc_buffer=>mt_data INTO DATA(lcb) INDEX 1.
      MOVE-CORRESPONDING wgen TO mdata1.
      MOVE-CORRESPONDING wgen TO mgen1.
      mdata1-gateentryno = lcb-gateentryno.
      mdata1-gateentrydate = lcb-gateentrydate.

      mgen1-gateentryno = lcb-gateentryno.
      mgen1-gateentrydate = lcb-gateentrydate.
      APPEND mdata1 TO lhc_buffer=>mt_data1.
      APPEND mgen1 TO mapped-zgenpurchasecds1.
    ENDLOOP.

  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_zgenpocds DEFINITION FINAL INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
*    methods modify for behaviour
    METHODS create FOR MODIFY
      IMPORTING gdata FOR CREATE zgenpocds.

    METHODS update FOR MODIFY
      IMPORTING udata FOR UPDATE zgenpocds.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zgenpocds.

    METHODS read FOR READ
      IMPORTING keys FOR READ zgenpocds RESULT result.

    METHODS rba_genitem FOR READ
      IMPORTING keys_rba FOR READ zgenpocds\_genitem FULL result_requested RESULT result LINK association_links.

    METHODS cba_genitem FOR MODIFY
      IMPORTING tgen FOR CREATE zgenpocds\_genitem.

ENDCLASS.

CLASS lhc_zgenpocds IMPLEMENTATION.

  METHOD create.
    DATA: number TYPE cl_numberrange_runtime=>nr_number,
          mapgen LIKE LINE OF mapped-zgenpocds..
    DATA tgdt LIKE LINE OF lhc_buffer=>mt_data.
    LOOP AT gdata INTO DATA(dt) ."GROUP BY ( key1 = dt-plant key2 = dt-invoiceno key3 = dt-podocno key4 = dt-supplier  ).

      TRY.
          cl_numberrange_runtime=>number_get(  EXPORTING nr_range_nr = '01' object = 'ZGENPO' IMPORTING number = number ).
          SELECT SINGLE * FROM zgenpoheader  WHERE plant = @dt-plant
          AND supplier = @dt-supplier AND podocno = @dt-podocno and invoiceno = @dt-invoiceno and iscancelled ne 'X' INTO @DATA(wg).
          IF sy-subrc NE 0.
*            LOOP AT GROUP dt INTO DATA(dt1).
            dt-gateentryno = number+10(10).
            if dt-Gateentrydate is INITIAL.
            dt-gateentrydate = |{ sy-datum+6(2) }.{ sy-datum+4(2) }.{ sy-datum+0(4) }|.
            endif.
            if dt-creationtime is INITIAL.
             dt-creationtime = |{ sy-uzeit+0(2) }:{ sy-uzeit+2(2) }:{ sy-uzeit+4(2) }|.
            endif.

            MOVE-CORRESPONDING dt TO tgdt.
            tgdt-flag = 'C'.

*  clear tgdt.
            APPEND tgdt TO lhc_buffer=>mt_data.
*              append tgdt to mapped-zgenpurchasecds.
            IF dt-%cid IS NOT INITIAL.
              MOVE-CORRESPONDING dt TO mapgen.
              APPEND mapgen TO mapped-zgenpocds.
*              insert VALUE #(  %cid = dt-%cid gateentryno = dt-gateentryno gateentrydate = dt-gateentrydate ) into TABLE mapped-zgenpurchasecds.
            ENDIF.
*            ENDLOOP.
          ELSE.
            MOVE-CORRESPONDING wg TO tgdt.
            APPEND tgdt TO lhc_buffer=>mt_data.

*            EXIT.
*             LOOP AT GROUP dt INTO dt1.
**              dt-gateentryno = number+10(10).
**              dt-gateentrydate = sy-datum.
*              MOVE-CORRESPONDING dt TO tgdt.
**  clear tgdt.
*              APPEND tgdt TO lhc_buffer=>mt_data.
*            ENDLOOP.
*            MOVE-CORRESPONDING
          ENDIF.
        CATCH cx_number_ranges.
          "handle exception
      ENDTRY.


    ENDLOOP.
*  loop
  ENDMETHOD.

  METHOD update.
  move-CORRESPONDING udata to lhc_buffer=>mt_data.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_genitem.
  ENDMETHOD.

  METHOD cba_genitem.
    DATA:mdata1 LIKE LINE OF lhc_buffer=>mt_data1,
         mgen1  LIKE LINE OF mapped-zgenpurchasecds1.
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
        mdata1-gateentryno = lcb-gateentryno.
        mdata1-gateentrydate = lcb-gateentrydate.

        mgen1-gateentryno = lcb-gateentryno.
        mgen1-gateentrydate = lcb-gateentrydate.
        APPEND mdata1 TO lhc_buffer=>mt_data1.
        APPEND mgen1 TO mapped-zgenpurchasecds1.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zgenpocds DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zgenpocds IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    DATA lt_data TYPE STANDARD TABLE OF zgenpoheader.
    DATA: tdata1 TYPE STANDARD TABLE OF zgenpurchase.
    MOVE-CORRESPONDING lhc_buffer=>mt_data TO lt_data.
*    IF lt_data IS NOT INITIAL.
*    INSERT zgenpoheader
*     FROM TABLE @lt_data.
*     if sy-subrc ne 0.
     MODIFY zgenpoheader from table @lt_Data.
*     endif.

    MOVE-CORRESPONDING lhc_buffer=>mt_data1 TO tdata1.
*    INSERT zgenpurchase FROM TABLE @tdata1.
    modify zgenpurchase FROM TABLE @tdata1.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

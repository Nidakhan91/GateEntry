CLASS lhc_buffer DEFINITION.
* 1) define the data buffer
  PUBLIC SECTION.

    TYPES: BEGIN OF ty_buffer.
             INCLUDE TYPE   zchallanheadcds AS data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_buffer.

    TYPES tdata TYPE TABLE OF ty_buffer .

    CLASS-DATA mt_data TYPE tdata.

    TYPES: BEGIN OF ty_buffer1.
             INCLUDE TYPE   zchallanitemcds AS data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_buffer1.

    TYPES tdata1 TYPE TABLE OF ty_buffer1 .

    CLASS-DATA mt_data1 TYPE tdata1.
ENDCLASS.
CLASS lhc_zchallanheadcds DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zchallanheadcds RESULT result.

    METHODS create FOR MODIFY
      IMPORTING gdata FOR CREATE zchallanheadcds.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zchallanheadcds.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zchallanheadcds.

    METHODS read FOR READ
      IMPORTING keys FOR READ zchallanheadcds RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zchallanheadcds.

    METHODS rba_item FOR READ
      IMPORTING keys_rba FOR READ zchallanheadcds\item FULL result_requested RESULT result LINK association_links.

    METHODS cba_item FOR MODIFY
      IMPORTING tgen FOR CREATE zchallanheadcds\item.

ENDCLASS.

CLASS lhc_zchallanheadcds IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
    DATA: number TYPE cl_numberrange_runtime=>nr_number,
          mapgen LIKE LINE OF mapped-zchallanheadcds..
    DATA tgdt LIKE LINE OF lhc_buffer=>mt_data.
    LOOP AT gdata INTO DATA(dt) ."GROUP BY ( key1 = dt-plant key2 = dt-invoiceno key3 = dt-podocno key4 = dt-supplier  ).


      SELECT SINGLE * FROM zchallanheader  WHERE "plant = @dt-plant
      supplier = @dt-supplier AND materialdocument = @dt-materialdocument AND materialdocumentyear = @dt-materialdocumentyear" and iscancelled ne 'X'
      INTO @DATA(wg).
      IF sy-subrc NE 0.
*            LOOP AT GROUP dt INTO DATA(dt1).
        TRY.
            IF dt-gateentrynumber IS INITIAL.

              cl_numberrange_runtime=>number_get(  EXPORTING nr_range_nr = '01' object = 'ZGATEOUT' IMPORTING number = number ).
              dt-gateentrynumber = number+10(10).
            ENDIF.
          CATCH cx_number_ranges.
            "handle exception
        ENDTRY.

        dt-gateentrydate = |{ sy-datum+6(2) }.{ sy-datum+4(2) }.{ sy-datum+0(4) }|..


        IF dt-isclosed = 'X'.


          dt-closedate = |{ sy-datum+6(2) }.{ sy-datum+4(2) }.{ sy-datum+0(4) }|.
          dt-closetime = |{ sy-timlo+0(2) }:{ sy-timlo+2(2) }:{ sy-timlo+4(2) }|..
        ENDIF.
        MOVE-CORRESPONDING dt TO tgdt.
        tgdt-flag = 'C'.

*  clear tgdt.
        APPEND tgdt TO lhc_buffer=>mt_data.
*              append tgdt to mapped-zgenpurchasecds.
        IF dt-%cid IS NOT INITIAL.
          MOVE-CORRESPONDING dt TO mapgen.
          APPEND mapgen TO mapped-zchallanheadcds.
*              insert VALUE #(  %cid = dt-%cid gateentryno = dt-gateentryno gateentrydate = dt-gateentrydate ) into TABLE mapped-zgenpurchasecds.
        ENDIF.
*            ENDLOOP.
      ELSE.
        MOVE-CORRESPONDING wg TO tgdt.
        APPEND tgdt TO lhc_buffer=>mt_data.

      ENDIF.



    ENDLOOP.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_item.
  ENDMETHOD.

  METHOD cba_item.
    DATA:mdata1 LIKE LINE OF lhc_buffer=>mt_data1,
         mgen1  LIKE LINE OF mapped-zchallanitemcds.
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
        mdata1-gateentrynumber = lcb-gateentrynumber.
        mdata1-gateentrydate = lcb-gateentrydate.

        mgen1-gateentrynumber = lcb-gateentrynumber.
        mgen1-gateentrydate = lcb-gateentrydate.
        APPEND mdata1 TO lhc_buffer=>mt_data1.
        APPEND mgen1 TO mapped-zchallanitemcds.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_zchallanitemcds DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zchallanitemcds.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zchallanitemcds.

    METHODS read FOR READ
      IMPORTING keys FOR READ zchallanitemcds RESULT result.

*    METHODS rba_head FOR READ
*      IMPORTING keys_rba FOR READ zchallanitemcds\head FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_zchallanitemcds IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

*  METHOD rba_head.
*  ENDMETHOD.

ENDCLASS.

CLASS lsc_zchallanheadcds DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zchallanheadcds IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    DATA lt_data TYPE STANDARD TABLE OF zchallanheader.
    DATA: tdata1 TYPE STANDARD TABLE OF zchallanitem.
    MOVE-CORRESPONDING lhc_buffer=>mt_data TO lt_data.
*    IF lt_data IS NOT INITIAL.
*    INSERT zgenpoheader
*     FROM TABLE @lt_data.
*     if sy-subrc ne 0.
    MODIFY zchallanheader FROM TABLE @lt_data.
*     endif.

    MOVE-CORRESPONDING lhc_buffer=>mt_data1 TO tdata1.
*    INSERT zgenpurchase FROM TABLE @tdata1.
    MODIFY zchallanitem FROM TABLE @tdata1.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

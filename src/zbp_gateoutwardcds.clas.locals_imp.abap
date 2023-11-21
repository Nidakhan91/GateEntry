CLASS lhc_buffer DEFINITION.
* 1) define the data buffer
  PUBLIC SECTION.

    TYPES: BEGIN OF ty_buffer.
             INCLUDE TYPE   zgateoutwardcds AS data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_buffer.

    TYPES tdata TYPE TABLE OF ty_buffer .

    CLASS-DATA mt_data TYPE tdata.
ENDCLASS.
CLASS lhc_zgateoutwardcds DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING gdata FOR CREATE zgateoutwardcds.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zgateoutwardcds.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zgateoutwardcds.

    METHODS read FOR READ
      IMPORTING keys FOR READ zgateoutwardcds RESULT result.

ENDCLASS.

CLASS lhc_zgateoutwardcds IMPLEMENTATION.

  METHOD create.
    DATA: number TYPE cl_numberrange_runtime=>nr_number,
          mapgen LIKE LINE OF mapped-zgateoutwardcds.
    DATA tgdt LIKE LINE OF lhc_buffer=>mt_data.
    LOOP AT gdata INTO DATA(dt) ."GROUP BY ( key1 = dt-plant key2 = dt-invoiceno key3 = dt-podocno key4 = dt-supplier  ).

*
      SELECT SINGLE * FROM zgateoutward  WHERE plant = @dt-plant
      AND customer = @dt-customer AND deliverydocument = @dt-deliverydocument  and cancelledind ne 'X' INTO @DATA(wg).
      IF sy-subrc NE 0.
        TRY.
            cl_numberrange_runtime=>number_get(  EXPORTING nr_range_nr = '01' object = 'ZGATEOUT' IMPORTING number = number ).
          CATCH cx_number_ranges.
            "handle exception
        ENDTRY.
*            LOOP AT GROUP dt INTO DATA(dt1).

        IF dt-gateentrynumber IS INITIAL.
          dt-gateentrynumber = number+10(10).
        ENDIF.
        IF dt-gateentrydate IS INITIAL.
          dt-gateentrydate = |{ sy-datum+6(2) }.{ sy-datum+4(2) }.{ sy-datum+0(4) }|.
        ENDIF.
        IF dt-entrytime IS INITIAL.
          dt-entrytime = |{ sy-timlo+0(2) }:{ sy-timlo+2(2) }:{ sy-timlo+4(2) }|..
        ENDIF.
        IF dt-isclosed EQ 'X'.
          dt-closedate = |{ sy-datum+6(2) }.{ sy-datum+4(2) }.{ sy-datum+0(4) }|.
          dt-closetime =  |{ sy-timlo+0(2) }:{ sy-timlo+2(2) }:{ sy-timlo+4(2) }|..
        ENDIF.

        MOVE-CORRESPONDING dt TO tgdt.
        tgdt-flag = 'C'.

*  clear tgdt.
        APPEND tgdt TO lhc_buffer=>mt_data.
*              append tgdt to mapped-zgenpurchasecds.
        IF dt-%cid IS NOT INITIAL.
          MOVE-CORRESPONDING dt TO mapgen.
          APPEND mapgen TO mapped-zgateoutwardcds.
*              insert VALUE #(  %cid = dt-%cid gateentryno = dt-gateentryno gateentrydate = dt-gateentrydate ) into TABLE mapped-zgenpurchasecds.
        ENDIF.
*            ENDLOOP.
      ELSE.
        IF dt-gateentrynumber IS NOT INITIAL.
          MOVE-CORRESPONDING dt TO wg .
        ENDIF.
        IF dt-isclosed EQ 'X' AND dt-gateentrynumber IS NOT INITIAL.
          wg-closedate = |{ sy-datum+6(2) }.{ sy-datum+4(2) }.{ sy-datum+0(4) }|.
          wg-closetime =  |{ sy-timlo+0(2) }:{ sy-timlo+2(2) }:{ sy-timlo+4(2) }|..
        ENDIF.
        MOVE-CORRESPONDING wg TO tgdt.
        MOVE-CORRESPONDING wg TO mapgen.
        APPEND tgdt TO lhc_buffer=>mt_data.
        APPEND mapgen TO mapped-zgateoutwardcds.

      ENDIF.



    ENDLOOP.

  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zgateoutwardcds DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zgateoutwardcds IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    DATA lt_data TYPE STANDARD TABLE OF zgateoutward.
    DATA: tdata1 TYPE STANDARD TABLE OF zgateoutward.
    MOVE-CORRESPONDING lhc_buffer=>mt_data TO lt_data.
*    IF lt_data IS NOT INITIAL.

*    TRY.
*        INSERT zgateoutward
*         FROM TABLE @lt_data.
*      CATCH cx_sy_open_sql_db. " DBSQL_DUPLICATE_KEY_ERROR.
*    IF sy-subrc NE 0.
        MODIFY zgateoutward FROM TABLE @lt_data.
*    ENDIF.
*        loop at lt_Data into data(py).
*        if py-isclosed = 'X'.
*        update zemptyvehicle set c = 'X',cancelledby = @py-cancelledby,cancelledon = @py-cancelledon,
*        cancelledtime = @py-cancelledtime,cancelreason = @py-cancelreason where gateentryno = @py-gateentrynumber.
*        endif.
*        endloop.

*    ENDTRY.

*    MOVE-CORRESPONDING lhc_buffer=>mt_data1 TO tdata1.
*    INSERT zgenpurchase FROM TABLE @tdata1.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

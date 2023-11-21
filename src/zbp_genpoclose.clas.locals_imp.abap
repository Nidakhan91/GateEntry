CLASS lhc_buffer DEFINITION.
* 1) define the data buffer
  PUBLIC SECTION.

    TYPES: BEGIN OF ty_buffer.
             INCLUDE TYPE   zgenpoclose AS data.
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
CLASS lhc_zgenpoclose DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING gdata FOR CREATE zgenpoclose.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zgenpoclose.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zgenpoclose.

    METHODS read FOR READ
      IMPORTING keys FOR READ zgenpoclose RESULT result.

ENDCLASS.

CLASS lhc_zgenpoclose IMPLEMENTATION.

  METHOD create.
    DATA:lhc LIKE LINE OF lhc_buffer=>mt_data,
         map LIKE LINE OF mapped-zgenpoclose.
    LOOP  AT gdata INTO DATA(wg) WHERE gateentryno IS NOT INITIAL.
      SELECT SINGLE * FROM zgenpoheader WHERE gateentryno = @wg-gateentryno  INTO @DATA(ph) .
      IF sy-subrc EQ 0 AND ph-isclose EQ ' '.
      MOVE-CORRESPONDING wg to lhc.

      MOVE-CORRESPONDING ph to map.
        lhc-gateentryno = ph-gateentryno.
        lhc-isclose = wg-isclose.
*        lhc-closedon = sy-datum.
*        lhc-closedtime = sy-uzeit.
        if lhc-closedon is INITIAL.
            lhc-closedon = |{ sy-datum+6(2) }.{ sy-datum+4(2) }.{ sy-datum+0(4) }|.
            endif.
            if lhc-closedtime is INITIAL.
             lhc-closedtime = |{ sy-timlo+0(2) }:{ sy-timlo+2(2) }:{ sy-timlo+4(2) }|.
            endif.
*        lhc-tarewt = wg-Tarewt.
      ELSEIF ph-isclose EQ 'X'.
      MOVE-CORRESPONDING ph to map.
        map-gateentryno = wg-gateentryno.
*   map-isclose = ph-Isclose.
      ENDIF.
      APPEND lhc TO lhc_buffer=>mt_data.
      APPEND map TO mapped-zgenpoclose.
    ENDLOOP.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zgenpoclose DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zgenpoclose IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.

    IF lhc_buffer=>mt_data IS NOT INITIAL.
      LOOP AT lhc_buffer=>mt_data INTO DATA(bg).
        IF bg-isclose EQ 'X'.
          UPDATE zgenpoheader SET isclose = 'X' ,netqty = @bg-netwt ,tareqty = @bg-tarewt ,remark = @bg-remark,
          closedon = @bg-closedon, closedtime = @bg-closedtime
          WHERE gateentryno = @bg-gateentryno.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

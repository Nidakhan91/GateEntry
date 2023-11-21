CLASS lhc_buffer DEFINITION.
* 1) define the data buffer
  PUBLIC SECTION.

    TYPES: BEGIN OF ty_buffer.
             INCLUDE TYPE   zgatecancel AS data.
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
CLASS lhc_zgatecancel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING gdata FOR CREATE zgatecancel.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zgatecancel.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zgatecancel.

    METHODS read FOR READ
      IMPORTING keys FOR READ zgatecancel RESULT result.

ENDCLASS.

CLASS lhc_zgatecancel IMPLEMENTATION.

  METHOD create.
    DATA:lhc LIKE LINE OF lhc_buffer=>mt_data,
         map LIKE LINE OF mapped-zgatecancel.
    LOOP  AT gdata INTO DATA(wg) WHERE gateentryno IS NOT INITIAL.
      SELECT SINGLE * FROM zgenpoheader WHERE gateentryno = @wg-gateentryno  INTO @DATA(ph) .
      IF sy-subrc EQ 0 AND ph-iscancelled EQ ' '.
        MOVE-CORRESPONDING wg TO lhc.

        MOVE-CORRESPONDING ph TO map.
        lhc-gateentryno = ph-gateentryno.
        lhc-iscancelled = wg-iscancelled.
        lhc-cancelreason = wg-cancelreason.
*        lhc-tarewt = wg-Tarewt.
      ELSEIF ph-isclose EQ 'X'.
        MOVE-CORRESPONDING ph TO map.
        map-gateentryno = wg-gateentryno.
*   map-isclose = ph-Isclose.
      ENDIF.
      APPEND lhc TO lhc_buffer=>mt_data.
      APPEND map TO mapped-zgatecancel.
    ENDLOOP.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zgatecancel DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zgatecancel IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.

    IF lhc_buffer=>mt_data IS NOT INITIAL.
      LOOP AT lhc_buffer=>mt_data INTO DATA(bg).
        IF bg-iscancelled EQ 'X'.
          UPDATE zgenpoheader SET iscancelled = 'X' ,cancelreason = @bg-cancelreason" ,tareqty = @bg-tarewt ,remark = @bg-remark
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

CLASS lhc_buffer DEFINITION.
* 1) define the data buffer
  PUBLIC SECTION.

    TYPES: BEGIN OF ty_buffer.
             INCLUDE TYPE   zgateoutwardclose AS data.
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
CLASS lhc_zgateoutwardclose DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zgateoutwardclose RESULT result.

    METHODS create FOR MODIFY
      IMPORTING gdata FOR CREATE zgateoutwardclose.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zgateoutwardclose.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zgateoutwardclose.

    METHODS read FOR READ
      IMPORTING keys FOR READ zgateoutwardclose RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zgateoutwardclose.

ENDCLASS.

CLASS lhc_zgateoutwardclose IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.

    DATA:lhc LIKE LINE OF lhc_buffer=>mt_data,
         map LIKE LINE OF mapped-zgateoutwardclose.
    LOOP  AT gdata INTO DATA(wg) WHERE gateentrynumber IS NOT INITIAL.
      SELECT SINGLE * FROM zgateoutward WHERE gateentrynumber = @wg-gateentrynumber  INTO @DATA(ph) .
      IF sy-subrc EQ 0 AND ph-isclosed EQ ' '.
        MOVE-CORRESPONDING wg TO lhc.

        MOVE-CORRESPONDING ph TO map.
        lhc-gateentrynumber = ph-gateentrynumber.
        lhc-isclosed = wg-isclosed.
        lhc-closedate = |{ sy-datum+6(2) }.{ sy-datum+4(2) }.{ sy-datum+0(4) }|.
.
        lhc-closetime = |{ sy-timlo+0(2) }:{ sy-timlo+2(2) }:{ sy-timlo+4(2) }|.
*            endif.
*            if map- is INITIAL.
*            map-closedate = |{ sy-datum+6(2) }.{ sy-datum+4(2) }.{ sy-datum+0(4) }|.
**            endif.
**            if map-closetime is INITIAL.
*             map-closetime = |{ sy-timlo+0(2) }:{ sy-timlo+2(2) }:{ sy-timlo+4(2) }|.
*            endif.
      ELSEIF ph-isclosed EQ 'X'.
*      MOVE-CORRESPONDING wg TO lhc.

*        MOVE-CORRESPONDING ph TO map.
        MOVE-CORRESPONDING ph TO map.
        map-gateentrynumber = wg-gateentrynumber.
         lhc-closedate = |{ sy-datum+6(2) }.{ sy-datum+4(2) }.{ sy-datum+0(4) }|.
*            endif.
*            if lhc-closetime is INITIAL.
        lhc-closetime = |{ sy-timlo+0(2) }:{ sy-timlo+2(2) }:{ sy-timlo+4(2) }|.
*   map-isclose = ph-Isclose.
      ENDIF.
      APPEND lhc TO lhc_buffer=>mt_data.
      APPEND map TO mapped-zgateoutwardclose.
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

ENDCLASS.

CLASS lsc_zgateoutwardclose DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zgateoutwardclose IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    IF lhc_buffer=>mt_data IS NOT INITIAL.
      LOOP AT lhc_buffer=>mt_data INTO DATA(bg).
        IF bg-isclosed EQ 'X'.
          UPDATE zgateoutward SET isclosed = 'X' ,netwt = @bg-netwt ,tarewt = @bg-tarewt ,remark = @bg-remark ,grosswt = @bg-grosswt,
          closedate = @bg-closedate,closetime = @bg-closetime
          WHERE gateentrynumber = @bg-gateentrynumber.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

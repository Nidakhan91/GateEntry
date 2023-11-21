CLASS lhc_buffer DEFINITION.
* 1) define the data buffer
  PUBLIC SECTION.

    TYPES: BEGIN OF ty_buffer.
             INCLUDE TYPE   zcancelcds AS data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_buffer.

    TYPES tdata TYPE TABLE OF ty_buffer .
    CLASS-DATA mt_data TYPE tdata.

ENDCLASS.
CLASS lhc_zcancelcds DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zcancelcds RESULT result.

    METHODS create FOR MODIFY
      IMPORTING gdata FOR CREATE zcancelcds.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zcancelcds.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zcancelcds.

    METHODS read FOR READ
      IMPORTING keys FOR READ zcancelcds RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zcancelcds.

ENDCLASS.

CLASS lhc_zcancelcds IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
    DATA:lhc LIKE LINE OF lhc_buffer=>mt_data,
         map LIKE LINE OF mapped-zcancelcds.
    LOOP AT gdata INTO DATA(gt).
      lhc-gateentrynumber = gt-gateentrynumber.
      lhc-gateentrydate  = gt-gateentrydate.
      lhc-cancelledby = gt-cancelledby.
      lhc-Cancelreason = gt-Cancelreason.

      lhc-cancelledind = gt-cancelledind.
      lhc-cancelledon = |{ sy-datum+6(2) }.{ sy-datum+4(2) }.{ sy-datum+0(4) }|.
      lhc-cancelledtime = |{ sy-timlo+0(2) }:{ sy-timlo+2(2) }:{ sy-timlo+4(2) }|.

      APPEND lhc TO lhc_buffer=>mt_data.
      MOVE-CORRESPONDING lhc TO map.
      APPEND map TO mapped-zcancelcds.


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

CLASS lsc_zcancelcds DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zcancelcds IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    LOOP AT lhc_buffer=>mt_data INTO DATA(mt).
      IF mt-cancelledind EQ 'X'.
        SELECT SINGLE * FROM zchallanheader WHERE gateentrynumber = @mt-gateentrynumber INTO @DATA(ch) .
        IF sy-subrc EQ 0.
          UPDATE zchallanheader SET cancelledind = 'X',cancelledon = @mt-cancelledon,cancelledtime = @mt-cancelledtime,
          cancelledby = @mt-cancelledby ,cancelreason = @mt-cancelreason WHERE gateentrynumber = @mt-gateentrynumber.
        ENDIF.

        SELECT SINGLE * FROM zemptyvehicle WHERE gateentryno = @mt-gateentrynumber INTO @DATA(vh) .
        IF sy-subrc EQ 0.
          UPDATE zemptyvehicle SET cancelledind = 'X',cancelledon = @mt-cancelledon,cancelledtime = @mt-cancelledtime,
          cancelledby = @mt-cancelledby,cancelreason = @mt-cancelreason WHERE gateentryno = @mt-gateentrynumber.
        ENDIF.

        SELECT SINGLE * FROM zgateoutward WHERE gateentrynumber = @mt-gateentrynumber INTO @DATA(ot) .
        IF sy-subrc EQ 0.
          UPDATE zgateoutward SET cancelledind = 'X',cancelledon = @mt-cancelledon,cancelledtime = @mt-cancelledtime,
          cancelledby = @mt-cancelledby,cancelreason = @mt-cancelreason WHERE gateentrynumber = @mt-gateentrynumber.
        ENDIF.

        SELECT SINGLE * FROM zgenpoheader WHERE gateentryno = @mt-gateentrynumber INTO @DATA(gn) .
        IF sy-subrc EQ 0.
          UPDATE zgenpoheader SET iscancelled = 'X',cancelledon = @mt-cancelledon,cancelledtime = @mt-cancelledtime,
          cancelledby = @mt-cancelledby,cancelreason = @mt-cancelreason WHERE gateentryno = @mt-gateentrynumber.
        ENDIF.

        SELECT SINGLE * FROM zsalesreturn WHERE gateentrynumber = @mt-gateentrynumber INTO @DATA(sl) .
        IF sy-subrc EQ 0.
          UPDATE zsalesreturn SET cancelledind = 'X',cancelledon = @mt-cancelledon,cancelledtime = @mt-cancelledtime,
          cancelledby = @mt-cancelledby,cancelreason = @mt-cancelreason WHERE gateentrynumber = @mt-gateentrynumber.
        ENDIF.

        SELECT SINGLE * FROM zsubcontracting WHERE gateentrynumber = @mt-gateentrynumber INTO @DATA(sb) .
        IF sy-subrc EQ 0.
          UPDATE zsubcontracting SET cancelledind = 'X',cancelledon = @mt-cancelledon,cancelledtime = @mt-cancelledtime,
          cancelledby = @mt-cancelledby,cancelreason = @mt-cancelreason WHERE gateentrynumber = @mt-gateentrynumber.
        ENDIF.


      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

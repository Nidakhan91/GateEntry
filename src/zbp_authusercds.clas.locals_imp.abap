CLASS lhc_zauthusercds DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zauthusercds RESULT result.

    METHODS create FOR MODIFY
      IMPORTING pdata FOR CREATE zauthusercds.

    METHODS update FOR MODIFY
      IMPORTING udata FOR UPDATE zauthusercds.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zauthusercds.

    METHODS read FOR READ
      IMPORTING keys FOR READ zauthusercds RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zauthusercds.

    METHODS rba_data FOR READ
      IMPORTING keys_rba FOR READ zauthusercds\data FULL result_requested RESULT result LINK association_links.

    METHODS cba_data FOR MODIFY
      IMPORTING data FOR CREATE zauthusercds\data.

ENDCLASS.

CLASS lhc_zauthusercds IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
    DATA:ldata TYPE TABLE OF zgeuserauth.
    MOVE-CORRESPONDING pdata TO ldata.
    MODIFY zgeuserauth FROM TABLE @ldata.
  ENDMETHOD.

  METHOD update.
    DATA:ldata TYPE TABLE OF zgeuserauth.
    MOVE-CORRESPONDING udata TO ldata.
    MODIFY zgeuserauth FROM TABLE @ldata.
  ENDMETHOD.

  METHOD delete.
    DATA:wdata TYPE TABLE OF zgeuserauth.
    MOVE-CORRESPONDING keys TO wdata.
    DELETE zgeuserauth FROM TABLE @wdata.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_data.
  ENDMETHOD.

  METHOD cba_data.
    DATA:tdata TYPE TABLE OF zauthdata.
*    MOVE-CORRESPONDING data TO tdata.
    LOOP AT data INTO DATA(gt).
      MOVE-CORRESPONDING gt-%target TO tdata.
      UPDATE zauthdata SET active = 'X' WHERE username = @gt-username AND role = @gt-role AND menu = @gt-menu.
      TRY.
          INSERT zauthdata FROM TABLE @tdata.
        CATCH:cx_sy_open_sql_db .
          MODIFY zauthdata FROM TABLE @tdata.
      ENDTRY.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_zauthdatacds DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING gdata FOR UPDATE zauthdatacds.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zauthdatacds.

    METHODS read FOR READ
      IMPORTING keys FOR READ zauthdatacds RESULT result.

    METHODS rba_head FOR READ
      IMPORTING keys_rba FOR READ zauthdatacds\head FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_zauthdatacds IMPLEMENTATION.

  METHOD update.
    DATA:tdata TYPE TABLE OF zauthdata.
    MOVE-CORRESPONDING gdata TO tdata.
    INSERT zauthdata FROM TABLE @tdata.
*  insert
  ENDMETHOD.

  METHOD delete.
    DATA:tdata TYPE TABLE OF zauthdata.
    MOVE-CORRESPONDING keys TO tdata.
    DELETE zauthdata FROM TABLE @tdata.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_head.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zauthusercds DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zauthusercds IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

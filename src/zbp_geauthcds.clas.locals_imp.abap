CLASS lhc_zgeauthcds DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING gdata FOR CREATE zgeauthcds.

    METHODS update FOR MODIFY
      IMPORTING keys FOR UPDATE zgeauthcds.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zgeauthcds.

    METHODS read FOR READ
      IMPORTING keys FOR READ zgeauthcds RESULT result.

ENDCLASS.

CLASS lhc_zgeauthcds IMPLEMENTATION.

  METHOD create.
    DATA:wg TYPE zgeuserauth.
    LOOP AT gdata INTO DATA(gd).
      wg-menu = gd-roletype.
      wg-role = gd-role.
      wg-username = gd-username.
      MODIFY zgeuserauth FROM @wg.
    ENDLOOP.
  ENDMETHOD.

  METHOD update.
    DATA:wg TYPE zgeuserauth.
    LOOP AT keys INTO DATA(gd).
      wg-menu = gd-roletype.
      wg-role = gd-role.
      wg-username = gd-username.
      MODIFY zgeuserauth FROM @wg.
    ENDLOOP.
  ENDMETHOD.

  METHOD delete.
    LOOP AT keys INTO DATA(kk).
      DELETE FROM zgeuserauth WHERE username = @kk-username AND menu = @kk-roletype AND role = @kk-role.
    ENDLOOP..
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zgeauthcds DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zgeauthcds IMPLEMENTATION.

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

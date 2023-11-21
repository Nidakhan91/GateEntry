CLASS lhc_zdelivery2 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zdelivery2 RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zdelivery2.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zdelivery2.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zdelivery2.

    METHODS read FOR READ
      IMPORTING keys FOR READ zdelivery2 RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zdelivery2.

    METHODS post FOR MODIFY
      IMPORTING keys FOR ACTION zdelivery2~post RESULT result.
*    METHODS get_instance_features FOR INSTANCE FEATURES
*      IMPORTING keys REQUEST requested_features FOR zdelivery2 RESULT result.

ENDCLASS.

CLASS lhc_zdelivery2 IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD post.
  LOOP AT RESult into data(rs).
  ENDLOOP.
  ENDMETHOD.

*  METHOD get_instance_features.
*  ENDMETHOD.

ENDCLASS.

CLASS lsc_zdelivery2 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zdelivery2 IMPLEMENTATION.

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

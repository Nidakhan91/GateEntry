CLASS lhc_buffer DEFINITION.
* 1) define the data buffer
  PUBLIC SECTION.

    TYPES: BEGIN OF ty_buffer.
             INCLUDE TYPE   zemptycds
             AS data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_buffer.

    TYPES tdata TYPE TABLE OF ty_buffer .

    CLASS-DATA mt_data TYPE tdata.
ENDCLASS.
CLASS lhc_zemptycds DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zemptycds  RESULT result.

    METHODS create FOR MODIFY
      IMPORTING gdata FOR CREATE zemptycds.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zemptycds.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zemptycds.

    METHODS read FOR READ
      IMPORTING keys FOR READ zemptycds RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zemptycds.

ENDCLASS.

CLASS lhc_zemptycds IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
    DATA: number TYPE cl_numberrange_runtime=>nr_number,
          mapgen LIKE LINE OF mapped-zemptycds.
    DATA tgdt LIKE LINE OF lhc_buffer=>mt_data.
    LOOP AT gdata INTO DATA(dt) ."GROUP BY ( key1 = dt-plant key2 = dt-invoiceno key3 = dt-podocno key4 = dt-supplier  ).

      TRY.
          cl_numberrange_runtime=>number_get(  EXPORTING nr_range_nr = '01' object = 'ZGATEOUT' IMPORTING number = number ).
          SELECT SINGLE * FROM zemptyvehicle  WHERE plant = @dt-plant AND entrydate = @dt-entrydate AND vehicalno = @dt-vehicalno
          INTO @DATA(wg).
          IF sy-subrc NE 0.
*            LOOP AT GROUP dt INTO DATA(dt1).

            IF dt-gateentryno IS INITIAL.
              dt-gateentryno = number+10(10).
            ENDIF.
            IF dt-gateentrydate IS INITIAL.
              dt-gateentrydate = |{ sy-datum+6(2) }.{ sy-datum+4(2) }.{ sy-datum+0(4) }|.
            ENDIF.
             if dt-entrytime is INITIAL.
             dt-entrytime = sy-uzeit.
            endif.

            MOVE-CORRESPONDING dt TO tgdt.
            tgdt-flag = 'C'.

*  clear tgdt.
            APPEND tgdt TO lhc_buffer=>mt_data.
*              append tgdt to mapped-zgenpurchasecds.
            IF dt-%cid IS NOT INITIAL.
              MOVE-CORRESPONDING dt TO mapgen.
              APPEND mapgen TO mapped-zemptycds.
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

CLASS lsc_zemptycds DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zemptycds IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    DATA lt_data TYPE STANDARD TABLE OF zemptyvehicle.
    DATA: tdata1 TYPE STANDARD TABLE OF zemptyvehicle.
    MOVE-CORRESPONDING lhc_buffer=>mt_data[] TO lt_data[].
*    IF lt_data IS NOT INITIAL.
    INSERT zemptyvehicle
     FROM TABLE @lt_data.
    IF sy-subrc NE 0.
*      MODIFY zgateoutward FROM TABLE @lt_data.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

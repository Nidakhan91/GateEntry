*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lhc_buffer DEFINITION.
* 1) define the data buffer
  PUBLIC SECTION.

    TYPES: BEGIN OF ty_buffer.
             INCLUDE TYPE   zgenpurchase AS data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_buffer.

    TYPES tdata TYPE TABLE OF ty_buffer .

    CLASS-DATA mt_data TYPE tdata.
ENDCLASS.
CLASS lcl_handler DEFINITION FINAL INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.
    METHODS modify FOR BEHAVIOR IMPORTING gdata FOR CREATE zgenpurchasecds .
    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zgenpurchasecds.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zgenpurchasecds.

    METHODS read FOR READ
      IMPORTING keys FOR READ zgenpurchasecds RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zgenpurchasecds.

ENDCLASS.

CLASS lcl_handler IMPLEMENTATION.

  METHOD modify.
    DATA: number     TYPE cl_numberrange_runtime=>nr_number,
          mapgen like line of mapped-zgenpurchasecds..
    DATA tgdt LIKE LINE OF lhc_buffer=>mt_data.
    LOOP AT gdata INTO DATA(dt) GROUP BY ( key1 = dt-plant  key2 = dt-podocno key3 = dt-supplier  ).

      TRY.
          cl_numberrange_runtime=>number_get(  EXPORTING nr_range_nr = '01' object = 'ZGENPO' IMPORTING number = number ).
          SELECT SINGLE * FROM zgenpurchase  WHERE plant = @dt-plant and podocno = @dt-podocno and supplier = @dt-supplier INTO @DATA(wg).
          IF sy-subrc NE 0.
            LOOP AT GROUP dt INTO DATA(dt1).
              dt-gateentryno = number+10(10).
              dt-gateentrydate = sy-datum.

              MOVE-CORRESPONDING dt TO tgdt.
              tgdt-flag = 'C'.

*  clear tgdt.
              APPEND tgdt TO lhc_buffer=>mt_data.
*              append tgdt to mapped-zgenpurchasecds.
              if dt-%cid is not INITIAL.
              MOVE-CORRESPONDING dt to mapgen.
              append mapgen to mapped-zgenpurchasecds.
*              insert VALUE #(  %cid = dt-%cid gateentryno = dt-gateentryno gateentrydate = dt-gateentrydate ) into TABLE mapped-zgenpurchasecds.
              endif.
            ENDLOOP.
          ELSE.
          MOVE-CORRESPONDING wg to tgdt.
          append tgdt to lhc_buffer=>mt_data.

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
  MOVE-CORRESPONDING entities to lhc_buffer=>mt_data.
  ENDMETHOD.

  METHOD delete.
*  MOVE-CORRESPONDING
  ENDMETHOD.

  METHOD read.
    MOVE-CORRESPONDING lhc_buffer=>mt_data TO result.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.
CLASS lcl_saver DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS finalize          REDEFINITION.
    METHODS check_before_save REDEFINITION.
    METHODS save              REDEFINITION.
ENDCLASS.

CLASS lcl_saver IMPLEMENTATION.

  METHOD save.
    DATA lt_data TYPE STANDARD TABLE OF zgenpurchase.

*    lt_data = VALUE #(  FOR row IN lhc_buffer=>mt_data  ).
    MOVE-CORRESPONDING lhc_buffer=>mt_data TO lt_data.
*    IF lt_data IS NOT INITIAL.
    INSERT zgenpurchase
     FROM TABLE @lt_data.
*    ENDIF.
*    lt_data = VALUE #(  FOR row IN lhc_buffer=>m WHERE  ( flag = 'U' ) (  row-data ) ).
*    IF lt_data IS NOT INITIAL.
*      UPDATE ztbooking_xxx FROM TABLE @lt_data.
*    ENDIF.
*    lt_data = VALUE #(  FOR row IN lhc_buffer=>mt_buffer WHERE  ( flag = 'D' ) (  row-data ) ).
*    IF lt_data IS NOT INITIAL.
*      DELETE ztbooking_xxx FROM TABLE @lt_data.
*    ENDIF.
  ENDMETHOD.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.
ENDCLASS.

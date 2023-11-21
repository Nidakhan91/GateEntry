CLASS lhc_buffer DEFINITION.
* 1) define the data buffer
  PUBLIC SECTION.

    TYPES: BEGIN OF ty_buffer.
             INCLUDE TYPE   zsalesreturn AS data.
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
CLASS lhc_zsalesreturncds DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zsalesreturncds RESULT result.

    METHODS create FOR MODIFY
      IMPORTING gdata FOR CREATE zsalesreturncds.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zsalesreturncds.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zsalesreturncds.

    METHODS read FOR READ
      IMPORTING keys FOR READ zsalesreturncds RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zsalesreturncds.

ENDCLASS.

CLASS lhc_zsalesreturncds IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
    DATA: number TYPE cl_numberrange_runtime=>nr_number,
          mapgen LIKE LINE OF mapped-zsalesreturncds..
    DATA tgdt LIKE LINE OF lhc_buffer=>mt_data.
    LOOP AT gdata INTO DATA(dt) ."GROUP BY ( key1 = dt-plant key2 = dt-invoiceno key3 = dt-podocno key4 = dt-supplier  ).

*      TRY.

      SELECT SINGLE * FROM zsalesreturn  WHERE plant = @dt-plant
      AND deliverydocument = @dt-deliverydocument AND customer = @dt-customer "and invoiceno = @dt-invoiceno
      and cancelledind ne 'X'
      INTO @DATA(wg).
      IF sy-subrc NE 0.
      try.
        cl_numberrange_runtime=>number_get(  EXPORTING nr_range_nr = '01' object = 'ZGENPO' IMPORTING number = number ).
        CATCH: cx_number_ranges.
*          "handle exception
      ENDTRY.
*            LOOP AT GROUP dt INTO DATA(dt1).
        IF dt-gateentrynumber IS INITIAL.
          dt-gateentrynumber = number+10(10).
        ENDIF.
        if dt-Gateentrydate is INITIAL.
            dt-gateentrydate = |{ sy-datum+6(2) }.{ sy-datum+4(2) }.{ sy-datum+0(4) }|.
            endif.
*            if dt-cre is INITIAL.
*             dt-creationtime = sy-uzeit.
*            endif.

        MOVE-CORRESPONDING dt TO tgdt.
        tgdt-flag = 'C'.

*  clear tgdt.
        APPEND tgdt TO lhc_buffer=>mt_data.
*              append tgdt to mapped-zgenpurchasecds.
        IF dt-%cid IS NOT INITIAL.
          MOVE-CORRESPONDING dt TO mapgen.
          APPEND mapgen TO mapped-zsalesreturncds.
*              insert VALUE #(  %cid = dt-%cid gateentryno = dt-gateentryno gateentrydate = dt-gateentrydate ) into TABLE mapped-zgenpurchasecds.
        ENDIF.
*            ENDLOOP.
      ELSE.
        MOVE-CORRESPONDING wg TO tgdt.
        tgdt-Gateentrynumber = wg-gateentrynumber.
        tgdt-Gateentrydate = wg-gateentrydate.
        IF dt-gateentrynumber IS NOT INITIAL.
          tgdt-flag = 'M'.
        ENDIF.
        APPEND tgdt TO lhc_buffer=>mt_data.

        MOVE-CORRESPONDING dt TO mapgen.
        APPEND mapgen TO mapped-zsalesreturncds.

      ENDIF.
*


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

CLASS lsc_zsalesreturncds DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zsalesreturncds IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    DATA lt_data TYPE STANDARD TABLE OF zsalesreturn.
    MOVE-CORRESPONDING lhc_buffer=>mt_data TO lt_data.

    IF lt_data IS NOT INITIAL.
      READ TABLE lhc_buffer=>mt_data INTO DATA(tt) WITH KEY flag = 'M'.
      IF sy-subrc NE 0.
        INSERT zsalesreturn
         FROM TABLE @lt_data.
      ELSE.
      loop at lt_data into data(lsd).
        MODIFY zsalesreturn FROM @lsd  .
      endloop.
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

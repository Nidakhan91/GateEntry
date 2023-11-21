CLASS lhc_buffer DEFINITION.
* 1) define the data buffer
  PUBLIC SECTION.

    TYPES: BEGIN OF ty_buffer.
             INCLUDE TYPE   z3rdpartyoutward AS data.
    TYPES:   flag TYPE c LENGTH 1,
           END OF ty_buffer.

    TYPES tdata TYPE TABLE OF ty_buffer .

    CLASS-DATA mt_data TYPE tdata.

ENDCLASS.
CLASS lhc_z3rdpartyoutward DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

*    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
*      IMPORTING keys REQUEST requested_authorizations FOR z3rdpartyoutward RESULT result.

    METHODS create FOR MODIFY
      IMPORTING gdata FOR CREATE z3rdpartyoutward.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE z3rdpartyoutward.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE z3rdpartyoutward.

    METHODS read FOR READ
      IMPORTING keys FOR READ z3rdpartyoutward RESULT result.

*    METHODS lock FOR LOCK
*      IMPORTING keys FOR LOCK z3rdpartyoutward.

ENDCLASS.

CLASS lhc_z3rdpartyoutward IMPLEMENTATION.

*  METHOD get_instance_authorizations.
*  ENDMETHOD.

  METHOD create.
    DATA: number TYPE cl_numberrange_runtime=>nr_number,
          mapgen LIKE LINE OF mapped-z3rdpartyoutward,
          report LIKE LINE OF reported-z3rdpartyoutward.
    DATA tgdt LIKE LINE OF lhc_buffer=>mt_data.
    LOOP AT gdata INTO DATA(dt) ."WHERE .grosswt IS NOT INITIAL AND netwt IS NOT INITIAL."GROUP BY ( key1 = dt-plant key2 = dt-invoiceno key3 = dt-podocno key4 = dt-supplier  ).

      MOVE-CORRESPONDING dt TO tgdt.
      mapgen-%cid = 'X'.
      APPEND tgdt TO lhc_buffer=>mt_data.
      MOVE-CORRESPONDING dt TO mapgen.

      APPEND mapgen TO mapped-z3rdpartyoutward.

      SELECT SINGLE * FROM zemptyvehicle  WHERE gateentryno = @dt-gateentrynumber INTO @DATA(wout).
      IF sy-subrc EQ 0.
        wout-deliverydocument = |{  wout-deliverydocument ALPHA = IN }|.
        DATA grs TYPE p DECIMALS 2.

        SELECT SINGLE * FROM i_deliverydocument  WHERE deliverydocument = @wout-deliverydocument INTO @DATA(del).
        IF sy-subrc EQ 0 ."AND .
          grs = dt-netwt.
          IF ( grs > del-HeaderGrossWeight  ).

            APPEND VALUE #( gateentrynumber = dt-gateentrynumber %cid = dt-%cid  ) TO failed-z3rdpartyoutward.
            APPEND VALUE #( gateentrynumber = dt-gateentrynumber  %msg = new_message_with_text( text = 'Entered  Wt > Delivered  wt' severity = if_abap_behv_message=>severity-error )
            %create = 'X' ) TO reported-z3rdpartyoutward.
          ENDIF.
        ELSE.
*          APPEND VALUE #( gateentrynumber = dt-gateentrynumber %cid = dt-%cid  ) TO failed-z3rdpartyoutward.
*          APPEND VALUE #( gateentrynumber = dt-gateentrynumber  %msg = new_message_with_text( text = 'Delivery Document does not exist please check' severity = if_abap_behv_message=>severity-error )
*          %create = 'X' ) TO reported-z3rdpartyoutward.
        ENDIF.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

*  METHOD lock.
*  ENDMETHOD.

ENDCLASS.

CLASS lsc_z3rdpartyoutward DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_z3rdpartyoutward IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.

  ENDMETHOD.

  METHOD save.
    DATA lt_data TYPE STANDARD TABLE OF z3rdpartyoutward.
    DATA:wdata TYPE zgateoutward.
    MOVE-CORRESPONDING lhc_buffer=>mt_data TO lt_data.

    LOOP AT lhc_buffer=>mt_data INTO DATA(wd)." WHERE grosswt IS NOT INITIAL.
      SELECT SINGLE * FROM zemptyvehicle  WHERE gateentryno = @wd-gateentrynumber INTO @DATA(empt).
      MOVE-CORRESPONDING empt TO wdata.
      wdata-gateentrynumber = empt-gateentryno.
      wdata-gateentrydate = empt-gateentrydate.
      wdata-plant = empt-plant.
      wdata-deliverydocument = empt-deliverydocument.
      SELECT SINGLE * FROM i_deliverydocument  WHERE ltrim( deliverydocument,'0' ) = @empt-deliverydocument INTO @DATA(del).
      IF del-soldtoparty IS NOT INITIAL.
        wdata-customer = |{ del-soldtoparty alpha = out }|.
      ELSE.
        wdata-customer = |{ del-shiptoparty ALpha = out }|.
      ENDIF.
      wdata-grosswt    = wd-grosswt.
      wdata-netwt      = wd-netwt.
      wdata-weightdate = wd-weightdate.
      wdata-weighttime = wd-weighttime.
      wdata-tarewt = wd-tarewt.

      MODIFY zgateoutward FROM @wdata.
      UPDATE zemptyvehicle SET tarewt = @wd-tarewt  WHERE gateentryno = @wd-gateentrynumber.

    ENDLOOP.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

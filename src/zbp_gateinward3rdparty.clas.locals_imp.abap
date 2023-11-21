CLASS lhc_buffer DEFINITION.
* 1) define the data buffer
  PUBLIC SECTION.

    TYPES: BEGIN OF ty_buffer.
             INCLUDE TYPE   zgateinward3rdparty AS data.
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
CLASS lhc_zgateinward3rdparty DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING gdata FOR CREATE zgateinward3rdparty.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zgateinward3rdparty.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zgateinward3rdparty.

    METHODS read FOR READ
      IMPORTING keys FOR READ zgateinward3rdparty RESULT result.

ENDCLASS.

CLASS lhc_zgateinward3rdparty IMPLEMENTATION.

  METHOD create.
  DATA: number TYPE cl_numberrange_runtime=>nr_number,
          mapgen LIKE LINE OF mapped-zgateinward3rdparty..
    DATA tgdt LIKE LINE OF lhc_buffer=>mt_data.
     LOOP AT gdata INTO DATA(dt) ."GROUP BY ( key1 = dt-plant key2 = dt-invoiceno key3 = dt-podocno key4 = dt-supplier  ).

            MOVE-CORRESPONDING dt TO tgdt.
            APPEND tgdt TO lhc_buffer=>mt_data.
*              append tgdt to mapped-zgenpurchasecds.
*            IF dt-%cid IS NOT INITIAL.
              MOVE-CORRESPONDING dt TO mapgen.
              APPEND mapgen TO mapped-zgateinward3rdparty.
*              insert VALUE #(  %cid = dt-%cid gateentryno = dt-gateentryno gateentrydate = dt-gateentrydate ) into TABLE mapped-zgenpurchasecds.
*            ENDIF.
*            ENDLOOP.

    ENDLOOP.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zgateinward3rdparty DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zgateinward3rdparty IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
   DATA lt_data TYPE STANDARD TABLE OF zgateinward3rdparty.
    DATA: tdata1 TYPE STANDARD TABLE OF zgenpurchase.
    MOVE-CORRESPONDING lhc_buffer=>mt_data TO lt_data.
*    IF lt_data IS NOT INITIAL.
*    INSERT zgenpoheader
*     FROM TABLE @lt_data.
*     if sy-subrc ne 0.
*     MODIFY zgenpoheader from table @lt_Data.
     loop at lt_data into data(wd).
     update zgenpoheader set grossqty = @wd-grossqty, netqty = @wd-netqty, tareqty = @wd-tareqty ,weighdate = @wd-weighdate
     ,weighttime = @wd-weighttime where gateentryno = @wd-gateentryno.
     endloop.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

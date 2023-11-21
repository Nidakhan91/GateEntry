CLASS zcl_zi_dmr_rep DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
     INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ZI_DMR_REP IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    IF io_request->is_data_requested( ).

      TYPES: BEGIN OF ty_final,
               sno                          TYPE int8,
               inspectionlot(12)            TYPE n,
               inspectioncharacteristictext TYPE char40,
               today(16)                    TYPE p DECIMALS 3,
               todate(16)                   TYPE p DECIMALS 3,
             END OF ty_final.

      DATA: it_final TYPE TABLE OF ty_final,
            wa_final TYPE          ty_final.


      DATA(lv_top)     = io_request->get_paging( )->get_page_size( ).
      IF lv_top < 0.
        lv_top = 1.
      ENDIF.
      DATA(lv_skip)    = io_request->get_paging( )->get_offset( ).

      DATA(lv_max_rows) = COND #( WHEN lv_top = if_rap_query_paging=>page_size_unlimited THEN 0
                                            ELSE lv_top ).


      lv_max_rows = lv_skip + lv_top.
      IF lv_skip > 0.
        lv_skip = lv_skip + 1.
      ENDIF.

      DATA(lt_sort)    = io_request->get_sort_elements( ).
      DATA : lv_orderby TYPE string.
      DATA(lv_conditions) =  io_request->get_filter( )->get_as_sql_string( ).
      DATA(it_input) =  io_request->get_filter(  )->get_as_ranges( ).




      IF lv_conditions IS NOT INITIAL.
        SELECT * FROM  i_inspectionresult
                 WHERE (lv_conditions)
                 INTO TABLE @DATA(it_dmr).

        DATA(it_dmr_01) = it_dmr.
        DATA(it_dmr_02) = it_dmr.
        DELETE it_dmr_01 WHERE inspplanoperationinternalid = '00000002'.
        DELETE it_dmr_02 WHERE inspplanoperationinternalid = '00000001'.

        SELECT * FROM  i_inspectioncharacteristic
                 WHERE (lv_conditions)
                 INTO TABLE @DATA(it_dmr_description).


        LOOP AT it_dmr_01 INTO DATA(wa_dmr_01) FROM lv_skip TO lv_max_rows.

          DATA(lv_tabix) = sy-tabix.

          READ TABLE it_dmr_02 INTO DATA(wa_dmr_02) INDEX lv_tabix.
          IF sy-subrc = 0.
            wa_final-todate = wa_dmr_02-inspectionresultmeanvalue.
          ENDIF.

          MOVE-CORRESPONDING  wa_dmr_01 TO wa_final.
          wa_final-sno = sy-tabix.
          wa_final-today = wa_dmr_01-inspectionresultmeanvalue.

          READ TABLE it_dmr_description INTO DATA(wa_dmr_description) WITH KEY inspectionlot = wa_dmr_01-inspectionlot
                                                                               inspectioncharacteristic = wa_dmr_01-inspectioncharacteristic.

          IF sy-subrc = 0.
            wa_final-inspectioncharacteristictext = wa_dmr_description-inspectioncharacteristictext.
          ENDIF.

          APPEND wa_final TO it_final.
          CLEAR: wa_final.
        ENDLOOP.
      ENDIF.

      DATA: lv_pagesize TYPE int8.

      lv_pagesize = lines( it_final ) + 50.
      io_response->set_total_number_of_records( lv_pagesize ).
      io_response->set_data( it_final ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.

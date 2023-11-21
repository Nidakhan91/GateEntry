CLASS zcl_test_fr_po2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
    INTERFACES if_rap_query_request .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_FR_PO2 IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
  TYPES: BEGIN OF ty_result,
         productid type char10,
         Category  type char40,
         name      type char10,
         END OF ty_result.

  DATA: lt_result type table of ty_result.
IF io_request->is_data_requested( ).

          TRY.
              "get and add filter
              DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ). "  get_filter_conditions( ).

            CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).

              "@todo :
              " raise an exception that the filter that has been provided
              " cannot be converted into select options
              " here we just continue

          ENDTRY.

          DATA(lv_top)     = io_request->get_paging( )->get_page_size( ).
          DATA(lv_skip)    = io_request->get_paging( )->get_offset( ).
          DATA(lt_fields)  = io_request->get_requested_elements( ).
          DATA(lt_sort)    = io_request->get_sort_elements( ).

 endif.

      lt_result = VALUE #( ( productid = 'HT-1000'  name = 'Notebook' )
                                    ( productid = 'HT-1001' name = 'Aotebook' )
                                    ( productid = 'HT-1002' name = 'Notebook' )
                                    ( productid = 'HT-1003' name = 'Notebook' )
                                    ( productid = 'HT-1004' name = 'Notebook' )
                                    ( productid = 'HT-1005' name = 'Notebook' )
                              ).
io_response->set_total_number_of_records( lines( lt_result ) ).
io_response->set_data( lt_result ).
  ENDMETHOD.


  METHOD if_rap_query_request~get_aggregation.
  ENDMETHOD.


  METHOD if_rap_query_request~get_entity_id.
  ENDMETHOD.


  METHOD if_rap_query_request~get_filter.
  ENDMETHOD.


  METHOD if_rap_query_request~get_parameters.
  ENDMETHOD.


  METHOD if_rap_query_request~get_requested_elements.
  ENDMETHOD.


  METHOD if_rap_query_request~get_search_expression.
  ENDMETHOD.


  METHOD if_rap_query_request~get_sort_elements.
  ENDMETHOD.


  METHOD if_rap_query_request~is_data_requested.
  ENDMETHOD.


  METHOD if_rap_query_request~is_total_numb_of_rec_requested.
  ENDMETHOD.
ENDCLASS.

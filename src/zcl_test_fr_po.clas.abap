CLASS zcl_test_fr_po DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
    INTERFACES if_rap_query_request.
  PROTECTED SECTION.
  PRIVATE SECTION.
   METHODS is_key_filter
      IMPORTING it_filter_cond          TYPE if_rap_query_filter=>tt_name_range_pairs
      RETURNING VALUE(rv_is_key_filter) TYPE abap_bool.

    METHODS get_orderby_clause
      IMPORTING it_sort_elements         TYPE if_rap_query_request=>tt_sort_elements
      RETURNING VALUE(rv_orderby_string) TYPE string.
ENDCLASS.



CLASS ZCL_TEST_FR_PO IMPLEMENTATION.


  METHOD get_orderby_clause.

  ENDMETHOD.


METHOD if_rap_query_provider~select.

TYPES: BEGIN OF ty_result,
       ProductId TYPE charg_d,
       Category   type charg_d,
       name      type charg_d,
       END OF ty_result.
DATA: lt_result TYPE TABLE of ty_result.

IF io_request->is_data_requested( ).

          TRY.
              DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ). "  get_filter_conditions( ).
            CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
          ENDTRY.

          DATA(lv_top)     = io_request->get_paging( )->get_page_size( ).
          DATA(lv_skip)    = io_request->get_paging( )->get_offset( ).
          DATA(lt_fields)  = io_request->get_requested_elements( ).
          DATA(lt_sort)    = io_request->get_sort_elements( ).

 endif.

SELECT *
        FROM ZI_FIpurchase_REGISTER INTO TABLE @data(it_final).
lt_result = VALUE #( ( productid = 'HT-1000' name = 'Notebook' )
                                    ( productid = 'HT-1001' name = 'Aotebook' )
                                    ( productid = 'HT-1002' name = 'Notebook' )
                                    ( productid = 'HT-1003' name = 'Notebook' )
                                    ( productid = 'HT-1004' name = 'Notebook' )
                                    ( productid = 'HT-1005' name = 'Notebook' )
                              ).
*io_request->is_total_numb_of_rec_requested(  ).
io_response->set_total_number_of_records( lines( lt_result ) ).
io_response->set_data( lt_result ).
  ENDMETHOD.


  METHOD is_key_filter.

    "check if the request is a single read
    READ TABLE it_filter_cond WITH KEY name = 'PRODUCTID' INTO DATA(ls_productid_filter_key).
    IF sy-subrc = 0 AND lines( ls_productid_filter_key-range ) = 1.
      READ TABLE ls_productid_filter_key-range INTO DATA(ls_id_option) INDEX 1.
      IF sy-subrc = 0 AND ls_id_option-sign = 'I' AND ls_id_option-option = 'EQ' AND ls_id_option-low IS NOT INITIAL.
        "read details for single record in list
        rv_is_key_filter = abap_true.
      ENDIF.
    ENDIF.

  ENDMETHOD.
ENDCLASS.

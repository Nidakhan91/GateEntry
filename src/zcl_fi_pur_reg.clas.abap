CLASS zcl_fi_pur_reg DEFINITION
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



CLASS zcl_fi_pur_reg IMPLEMENTATION.
 METHOD if_rap_query_provider~select.
  TYPES: BEGIN OF ty_result,
           referencedocumentmiro  TYPE char20,
           referencedocumentitem  TYPE char6,
           accountingdocument     TYPE char10,
           accountingdocumenttype TYPE char2,
         END OF ty_result.
  DATA: lt_result TYPE TABLE OF ty_result.
  DATA: it_final TYPE TABLE OF zi_fipurchase_register.

  IF io_request->is_data_requested( ).

    TRY.
      DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
    CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
    ENDTRY.
DATA   lv_top type int8.
   DATA(lv_page_size)     = io_request->get_paging( )->get_page_size( ).
   if   lv_page_size = io_request->get_paging( )->page_size_unlimited.
   lv_top = 0.
   else.
   lv_top = lv_page_size.
   endif.


*    DATA(lv_top)    = io_request->get_paging( )->page_size_unlimited.
    DATA(lv_skip)   = io_request->get_paging( )->get_offset( ).
    DATA(lt_fields) = io_request->get_requested_elements( ).
    DATA(lt_sort)   = io_request->get_sort_elements( ).


    " Fetch data based on your requirements (adjust WHERE clause as needed)
 DATA lv_orderby_string TYPE string.
    DATA lv_select_string TYPE string.
  lv_select_string = '*'.

*          LOOP AT lt_sort INTO DATA(ls_sort).
*  CONCATENATE lv_orderby_string ls_sort-element_name 'ASCENDING' INTO lv_orderby_string SEPARATED BY space.
*            ENDLOOP.

 CONCATENATE 'ACCOUNTINGDOCUMENT' 'ASCENDING' INTO lv_orderby_string SEPARATED BY space.

   SELECT (lv_select_string) FROM zi_fipurchase_register
           ORDER BY  (lv_orderby_string)
           INTO CORRESPONDING FIELDS OF TABLE @it_final
           up to @lv_top ROWS
    OFFSET @lv_skip .

    " Optionally, you can perform additional processing on the data if needed.

    " Populate lt_result with the fetched data
    LOOP AT it_final INTO DATA(wa_final).
      APPEND VALUE #( referencedocumentmiro  = wa_final-referencedocumentmiro
                      referencedocumentitem = wa_final-referencedocumentitem
                      accountingdocument     = wa_final-accountingdocument
                      accountingdocumenttype = wa_final-accountingdocumenttype )
           TO lt_result.
    ENDLOOP.

    " Set total number of records and response data
*    lv_top = '20'.
*io_response->set_total_number_of_records( iv_total_number_of_records = lv_top ).
*CATCH cx_rap_query_response_set_twic.
    io_response->set_total_number_of_records( lines( lt_result ) ).
    io_response->set_data( lt_result ).

  ENDIF.

ENDMETHOD.

  METHOD is_key_filter.

    "check if the request is a single read
*    READ TABLE it_filter_cond WITH KEY name = 'MIRO' INTO DATA(ls_productid_filter_key).
*    IF sy-subrc = 0 AND lines( ls_productid_filter_key-range ) = 1.
*      READ TABLE ls_productid_filter_key-range INTO DATA(ls_id_option) INDEX 1.
*      IF sy-subrc = 0 AND ls_id_option-sign = 'I' AND ls_id_option-option = 'EQ' AND ls_id_option-low IS NOT INITIAL.
*        "read details for single record in list
*        rv_is_key_filter = abap_true.
*      ENDIF.
*    ENDIF.

  ENDMETHOD.

  METHOD get_orderby_clause.
  ENDMETHOD.
ENDCLASS.

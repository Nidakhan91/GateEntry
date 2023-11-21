CLASS zcl_gatevalue DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES :if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA saplmigogoitem_ebeln TYPE string VALUE '(SAPLMIGO)GOITEM-EBELN' ##NO_TEXT.
ENDCLASS.



CLASS ZCL_GATEVALUE IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    DATA:tgate TYPE STANDARD TABLE OF zgenpovaluehelp.

    DATA(lo_paging) = io_request->get_paging( ).
    DATA(lsort) = io_request->get_sort_elements( ) .

    "io_request->get_requested_elements( )  --> could be used for optimizations
    DATA(lvs) = io_request->get_search_expression( ).
    DATA(filter1) = io_request->get_filter(  ).
    DATA(p1) = io_request->get_parameters(  ).
    DATA(p2) = io_request->get_requested_elements(  ).
    DATA(rng) = filter1->get_as_ranges(   ).

    DATA(str) = filter1->get_as_sql_string(  ).
    GET TIME STAMP FIELD DATA(tim).
*    ASSIGN ('(SAPLMIGO)GOITEM-EBELN') TO FIELD-SYMBOL(<ebeln>) .
    assign COMPONENT 'EBELN' of STRUCTURE '(SAPLMIGO)GOITEM'  to FIELD-SYMBOL(<ebeln>).
    IF <ebeln> IS ASSIGNED.
      SHIFT <ebeln> LEFT DELETING LEADING '0'.
      SELECT * FROM zgenpoheader WHERE isclose EQ 'X'  AND (str) AND podocno = @<ebeln> INTO CORRESPONDING FIELDS OF TABLE @tgate .
    ELSE.
      SELECT * FROM zgenpoheader WHERE isclose EQ 'X'  AND (str) INTO CORRESPONDING FIELDS OF TABLE @tgate .
    ENDIF..
    io_response->set_data( tgate ).
    io_response->set_total_number_of_records( lines( tgate ) ).
  ENDMETHOD.
ENDCLASS.

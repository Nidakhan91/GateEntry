CLASS zcl_vehicle DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_VEHICLE IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
  DATA(lvs) = io_request->get_search_expression( ).
    DATA(filter1) = io_request->get_filter(  ).
    DATA(p1) = io_request->get_parameters(  ).
    DATA(p2) = io_request->get_requested_elements(  ).
    DATA(rng) = filter1->get_as_ranges(   ).

    DATA(str) = filter1->get_as_sql_string(  ).
  ENDMETHOD.
ENDCLASS.

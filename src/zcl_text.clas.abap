CLASS zcl_text DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

*    INTERFACES if_sadl_exit .
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEXT IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.
    LOOP AT ct_calculated_data ASSIGNING FIELD-SYMBOL(<dd>).
*  <dd>-
      ASSIGN COMPONENT 'VEHICLENO' OF STRUCTURE <dd> TO FIELD-SYMBOL(<dt1>).
      IF <dt1> IS ASSIGNED.
        <dt1> = 'Long'.

      ENDIF.
    ENDLOOP..
    LOOP AT it_original_data ASSIGNING FIELD-SYMBOL(<dt>).
*  assign

    ENDLOOP.
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

  ENDMETHOD.
ENDCLASS.

function zassign.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     VALUE(FIELD) TYPE  CHAR100
*"----------------------------------------------------------------------
 " You can use the template 'functionModuleParameter' to add here the signature!
assign ('(SAPLMIGO)GOITEM-EBELN') to FIELD-SYMBOL(<eb>).
if sy-subrc eq 0.
field = <eb>.
endif.






ENDFUNCTION.

CLASS zcreategenpur DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  data wp type zgenpurchase.

  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCREATEGENPUR IMPLEMENTATION.


METHOD if_oo_adt_classrun~main .
*wp-plant = '1100'.
*wp-client = sy-mandt.
*wp-gateentryno = '8100000010'.
*wp-gateentrydate = '08.08.2023'.
*wp-supplier = '100010'.
*wp-invoiceno = '8100000010'.
*wp-invoicedate = sy-datum.
*wp-podocno = '4500000020'.
*wp-podoctype = 'ZDOM'.
*wp-poitem = '00010'.
*wp-material = '910-10'.
*wp-poqty = '10'.
*wp-openqty = '90'.
*
*insert zgenpurchase FROM @wp.
*wp-plant = '1100'.
*wp-client = sy-mandt.
*wp-gateentryno = '8100000010'.
*wp-gateentrydate = '08.08.2023'.
*wp-supplier = '100010'.
*wp-invoiceno = '8100000010'.
*wp-invoicedate = sy-datum.
*wp-podocno = '4500000020'.
*wp-podoctype = 'ZDOM'.
*wp-poitem = '00020'.
*wp-material = '910-20'.
*wp-poqty = '20'.
*wp-openqty = '80'.
*
*insert zgenpurchase FROM @wp.
* out->write( |{ sy-dbcnt } entries inserted successfully!| ).
**system.out->updated.
endmethod.
ENDCLASS.

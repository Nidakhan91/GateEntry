CLASS zcreategencdspr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  data wp type zgenpurchase.
  data wh type zgenpoheader.

  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCREATEGENCDSPR IMPLEMENTATION.


METHOD if_oo_adt_classrun~main .
*wp-plant = '1111'.
*wp-client = sy-mandt.
*wp-gateentryno = '8100000012'.
*wp-gateentrydate = '08.08.2023'.
*wp-supplier = '100011'.
*wp-invoiceno = '8100000012'.
*wp-invoicedate = sy-datum.
*wp-podocno = '4500000022'.
*wp-podoctype = 'ZDOM'.
*wp-poitem = '00010'.
*wp-material = '910-10'.
*wp-poqty = '10'.
*wp-openqty = '90'.
*MOVE-CORRESPONDING wp to wh.
*insert zgenpoheader FROM @wh.
*insert zgenpurchase FROM @wp.
*wp-plant = '1100'.
*wp-client = sy-mandt.
*wp-gateentryno = '8100000012'.
*wp-gateentrydate = '08.08.2023'.
*wp-supplier = '100010'.
*wp-invoiceno = '8100000012'.
*wp-invoicedate = sy-datum.
*wp-podocno = '4500000022'.
*wp-podoctype = 'ZDOM'.
*wp-poitem = '00020'.
*wp-material = '910-20'.
*wp-poqty = '20'.
*wp-openqty = '80'.
*
*insert zgenpurchase FROM @wp.
* out->write( |{ sy-dbcnt } entries inserted successfully!| ).
*system.out->updated.
endmethod.
ENDCLASS.

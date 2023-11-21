@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View'
define root view entity zgenpurchasepr //as select from zgenpurchasecds
provider contract transactional_query
as projection on zgenpurchasecds
//composition of target_data_source_name as _association_name
{  
    key gateentryno,
    key gateentrydate,
    key plant,
    key Supplier,
    //key Invoiceno,
    //key Invoicedate,
    key podocno,
   key podoctype,
  key poitem,
    Suppliermatdesc,
   
  material,
   materialdesc,
 poqty,
  openqty,
    Ewaybill,
    Vendorname,
    Noofpackages,
    Vehicleno,
    Vehicletype,
    Binsyesno,
    Noofbins,
    Transporter,
    Transportmode,
    Lrno,
    Approvervendor,
    customercode,
    Customername,
    Lrdate,
    Gateentryactualdate,
    Grossqty,
    Tolorane,
    Tareqty,
    Netqty,
    Weighttime,
    Weighdate,
    Remark
    //_association_name // Make association public
}

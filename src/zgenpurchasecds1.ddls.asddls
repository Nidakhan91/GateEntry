@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GENPO CDS'
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity zgenpurchasecds1 as select from zgenpurchase as genitem
association to parent ZGENPOCDS as _genh
//    on $projection.element_name = _genitem.target_element_name
     on $projection.Gateentryno = _genh.gateentryno and
       $projection.Gateentrydate = _genh.gateentrydate and 
       $projection.Plant = _genh.plant and
       $projection.Supplier = _genh.supplier and
//       $projection.Invoiceno = _genh.invoiceno and 
       $projection.Podocno = _genh.podocno
{
    key gateentryno as Gateentryno,
    key gateentrydate as Gateentrydate,
    key plant as Plant,
    key supplier as Supplier,
    key podocno as Podocno,
    key podoctype as Podoctype,
    key poitem as Poitem,
    suppliertype as Suppliertype,
    suppliermatdesc as Suppliermatdesc,
    material as Material,
    materialdesc as Materialdesc,
    poqty as Poqty,
    openqty as Openqty,
    geqty as GEqty,
    
    uom as uom,
    ewaybill as Ewaybill,
    vendorname as Vendorname,
    noofpackages as Noofpackages,
    vehicleno as Vehicleno,
    vehicletype as Vehicletype,
    binsyesno as Binsyesno,
    noofbins as Noofbins,
    transporter as Transporter,
    transportmode as Transportmode,
    lrno as Lrno,
    approvervendor as Approvervendor,
    customercode as Customercode,
    customername as Customername,
    lrdate as Lrdate,
    gateentryactualdate as Gateentryactualdate,
    grossqty as Grossqty,
    tolorane as Tolorane,
    tareqty as Tareqty,
    netqty as Netqty,
    weighttime as Weighttime,
    weighdate as Weighdate,
    remark as Remark,
    _genh
//    _genitem // Make association public
}

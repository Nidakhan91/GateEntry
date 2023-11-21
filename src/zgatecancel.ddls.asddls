@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cancel Gate Entry CDS'
define root view entity zgatecancel as select from zgenpoheader
//composition of target_data_source_name as _association_name
{
    key plant as Plant,
    key gateentryno as Gateentryno,
//    key gateentrydate as Gateentrydate,
//    key supplier as Supplier,
//    key podocno as Podocno,
//    invoiceno as Invoiceno,
//    suppliertype as Suppliertype,
//    ewaybill as Ewaybill,
//    vendorname as Vendorname,
//    noofpackages as Noofpackages,
//    vehicleno as Vehicleno,
//    vehicletype as Vehicletype,
//    binsyesno as Binsyesno,
//    noofbins as Noofbins,
//    transporter as Transporter,
//    transportmode as Transportmode,
//    lrno as Lrno,
//    approvervendor as Approvervendor,
//    customercode as Customercode,
//    customername as Customername,
//    lrdate as Lrdate,
//    gateentryactualdate as Gateentryactualdate,
//    grossqty as Grossqty,
//    tolorane as Tolorane,
//    tareqty as Tareqty,
//    netqty as Netqty,
//    weighttime as Weighttime,
//    weighdate as Weighdate,
//    remark as Remark,
//    isclose as Isclose,
    iscancelled as Iscancelled,
    cancelreason as Cancelreason
//    _association_name // Make association public
}

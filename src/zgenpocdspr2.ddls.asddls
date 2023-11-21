@EndUserText.label: 'Check PR 2'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity zgenpocdspr2 as projection on ZGENPOCDS
{
    key plant,
    key gateentryno,
    key gateentrydate,
    key supplier,
    key podocno,
    suppliertype,
    ewaybill,
    vendorname,
    noofpackages,
    vehicleno,
    vehicletype,
    binsyesno,
    noofbins,
    transporter,
    transportmode,
    lrno,
    approvervendor,
    customercode,
    customername,
    lrdate,
    gateentryactualdate,
    grossqty,
    tolorane,
    tareqty,
    netqty,
    weighttime,
    weighdate,
    remark,
    /* Associations */
    _genitem
}

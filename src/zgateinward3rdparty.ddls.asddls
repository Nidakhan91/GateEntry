@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '3rd Party API for Weight inward'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zgateinward3rdparty as select from ZGENPOCDS
{
//    key plant,
    key gateentryno,
//    key gateentrydate,
//    key supplier,
     key podocno,
    invoiceno,
//    suppliertype,
//    ewaybill,
//    vendorname,
//    noofpackages,
//    vehicleno,
//    vehicletype,
//    binsyesno,
//    noofbins,
//    transporter,
//    transportmode,
//    lrno,
//    approvervendor,
//    customercode,
//    customername,
//    lrdate,
//    gateentryactualdate,
    grossqty,
//    tolorane,
    tareqty,
    netqty,
    weighttime,
    weighdate
//    remark,
//    isclose,
//    iscancelled,
//    cancelreason,
//    /* Associations */
//    _genitem
}

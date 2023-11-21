@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gen PO CDs for Header and Item Pr'
define root view entity  ZGENPOCDSpr //as select from ZGENPOCDS
provider contract transactional_query
as projection on ZGENPOCDS  
//composition of zgenpoheader as genitem
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
    //_association_name // Make association public
}

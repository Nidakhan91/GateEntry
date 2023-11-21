@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Return CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zsalesreturncds as select from zsalesreturn
{
    key gateentrynumber as Gateentrynumber,
    key gateentrydate as Gateentrydate,
    key deliverydocument as Deliverydocument,
    key plant as Plant,
    customertype as Customertype,
    customer as Customer,
    customername as Customername,
    vehicaltype as Vehicaltype,
    vehicalno as Vehicalno,
    weightdate as Weightdate,
    weighttime as Weighttime,
    grosswt as Grosswt,
    netwt as Netwt,
    remark as Remark,
    transporter as Transporter,
    cancelledind,
    cancelledby,
    cancelledon,
    cancelledtime,
    createdby
}

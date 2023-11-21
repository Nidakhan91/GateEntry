@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Subcon CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zsubconcds as select from zsubcontracting
{
    key gateentrynumber as Gateentrynumber,
    key gateentrydate as Gateentrydate,
    key plant as Plant,
    key billingdocument as Billingdocument,
    key supplier as Supplier,
    suppliertype as Suppliertype,
    suppliername as Suppliername,
    vehicaltype as Vehicaltype,
    vehicalno as Vehicalno,
    tarewt as Tarewt,
    weightdate as Weightdate,
    weighttime as Weighttime,
    grosswt as Grosswt,
    netwt as Netwt,
    remark as Remark,
    transporter as Transporter,
    entrytime,
    isclosed,
    closedate,
    closedtime,
    cancelledind,
    cancelledby,
    cancelledon,
    cancelledtime,
    createdby
}

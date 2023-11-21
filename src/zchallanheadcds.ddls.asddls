@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Challan Header CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zchallanheadcds as select from zchallanheader as head
composition[ 0..* ] of zchallanitemcds as item
{
    key gateentrynumber as Gateentrynumber,
    key gateentrydate as Gateentrydate,
    key materialdocument as Materialdocument,
    key materialdocumentyear as Materialdocumentyear,
    
    gateentrytype as Gateentrytype,
    supplier as Supplier,
    plant as plant,
    supliername as Supliername,
    vehicalnumber as Vehicalnumber,
    vehicaltype as Vehicaltype,
    transportmode as Transportmode,
    transporter as Transporter,
    transportername as Transportername,
    grosswt as Grosswt,
    netwt as Netwt,
    remark as Remark,
    noofpackages as Noofpackages,
    isclosed,
    closedate,
    closetime,
    cancelledind,
    cancelledby,
    cancelledon,
    cancelledtime,
    createdby,
    item 
    
}

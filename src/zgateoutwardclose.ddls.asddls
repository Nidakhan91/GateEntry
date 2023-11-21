@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gate Outward Close'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zgateoutwardclose as select from zgateoutward
{
    key gateentrynumber as Gateentrynumber,
     tarewt as Tarewt,
//    weightdate as Weightdate,
//    weighttime as Weighttime,
    grosswt as Grosswt,
    netwt as Netwt,
    remark as Remark,
    isclosed as Isclosed,
    closedate as closedate,
    closetime as closetime
}

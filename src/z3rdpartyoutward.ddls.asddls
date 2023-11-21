@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '3rd Party API for Weight outward'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define root view entity z3rdpartyoutward
  as select from zgateoutwardcds
{
  key Gateentrynumber,
      Tarewt,
      Weightdate,
      Weighttime,
      Grosswt,
      Netwt
//      Remark as error
}
union all select from zemptyvehicle
{
  key gateentryno as Gateentrynumber,
      tarewt,
      ' ' as Weightdate,
      ' ' as Weighttime,
      ' ' as grosswt,
      ' ' as netwt
//      remark as error
} 

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cancel CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zcancelcds
  as select from zchallanheader
{
  key gateentrynumber as Gateentrynumber,
  key gateentrydate   as Gateentrydate,

      cancelledind    as Cancelledind,
      cancelledby     as Cancelledby,
      cancelledon     as Cancelledon,
      cancelledtime   as Cancelledtime,
      cancelreason    as Cancelreason
}
union all select from zemptyvehicle
{
  key gateentryno   as Gateentrynumber, //: abap.char(12) not null;
  key gateentrydate as Gateentrydate, //: abap.char(12) not null;
      cancelledind  as Cancelledind,
      cancelledby   as Cancelledby,
      cancelledon   as Cancelledon,
      cancelledtime as Cancelledtime,
      cancelreason    as Cancelreason

}
union all select from zgateoutward
{

  key gateentrynumber as Gateentrynumber,
  key gateentrydate   as Gateentrydate,
      cancelledind    as Cancelledind,
      cancelledby     as Cancelledby,
      cancelledon     as Cancelledon,
      cancelledtime   as Cancelledtime,
      cancelreason    as Cancelreason

}
union all select from zgenpoheader
{

  key gateentryno   as Gateentrynumber,
  key gateentrydate as Gateentrydate,
      iscancelled   as Cancelledind,
      cancelledby   as Cancelledby,
      cancelledon   as Cancelledon,
      cancelledtime as Cancelledtime,
      cancelreason    as Cancelreason

}
union all select from zsalesreturn
{

  key gateentrynumber as Gateentrynumber,
  key gateentrydate   as Gateentrydate,
      cancelledind    as Cancelledind,
      cancelledby     as Cancelledby,
      cancelledon     as Cancelledon,
      cancelledtime   as Cancelledtime,
      cancelreason    as Cancelreason

}
union all select from zsubcontracting
{

  key gateentrynumber as Gateentrynumber,
  key gateentrydate   as Gateentrydate,
      cancelledind    as Cancelledind,
      cancelledby     as Cancelledby,
      cancelledon     as Cancelledon,
      cancelledtime   as Cancelledtime,
      cancelreason    as Cancelreason

}

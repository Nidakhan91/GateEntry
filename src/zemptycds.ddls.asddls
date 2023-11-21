//@AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Empty Vehicale CDS'
//@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zemptycds
  as select from zemptyvehicle
{
  key gateentryno      as Gateentryno,
  key gateentrydate    as Gateentrydate,
  key plant            as Plant,
  key vehicalno        as Vehicalno,
  key entrydate        as Entrydate,
      deliverydocument as deliverydocument,
      vehicletype      as vehicletype,
      tarewt           as Tarewt,
      transporter      as Transporter,
      weightdate       as Weightdate,
      weighttime       as Weighttime,
      remark           as Remark,
      cancelledind,
      cancelledby,
      cancelledon,
      cancelledtime,
      entrytime,
      createdby
}

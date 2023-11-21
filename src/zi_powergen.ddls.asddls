@AbapCatalog.sqlViewName: 'ZI_POWGEN'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS for Power Generation'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view ZI_PowerGen
  as select distinct from ZI_POWER_GEN_DATE as Power
  association [1] to ZI_POWER_GEN_DATE105 as DateCDS on  Power.SyDate            = DateCDS.SyDate
                                                     and Power.MsmtValuationCode = DateCDS.MsmtValuationCode
  association [1] to ZI_POWER_EXPORT      as PowExp  on  Power.SyDate            = PowExp.SyDate
                                                     and Power.MsmtValuationCode = PowExp.MsmtValuationCode
{
  key Power.SyDate                                                         as ODate,
      coalesce( Power.TodayRead ,0 ) + coalesce( DateCDS.TodayRead105 ,0 ) as PGReading,
      PowExp.EReading                                                      as EXReading
}

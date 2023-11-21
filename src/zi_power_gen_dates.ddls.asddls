@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS for Power Gen Date'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_POWER_GEN_DATES
  as select from I_MeasurementDocument as A
{
  key A.MsmtRdngDate                            as MsmtRdngDate,
      A.MeasuringPoint                          as MeasuringPoint,
      A.MeasurementReadingInEntryUoM            as MeasurementReadingInEntryUoM,
      A.MsmtValuationCode                       as MsmtValuationCode,
      A.MsmtRdngIsReversed                      as MsmtRdngIsReversed,
      dats_add_days(A.MsmtRdngDate, -1, 'NULL') as ODate
}
//where A.MsmtRdngDate = dats_add_days(A.MsmtRdngDate, -1, 'NULL') 

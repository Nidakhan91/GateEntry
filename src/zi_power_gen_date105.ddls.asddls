@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS for Reasing of 105 point'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_POWER_GEN_DATE105
  as select from ZI_POWER_GEN_DATES as A
  association [1] to I_MeasurementDocument as B on  B.MsmtRdngDate      = A.ODate
                                                and A.MeasuringPoint    = B.MeasuringPoint
                                                and A.MsmtValuationCode = B.MsmtValuationCode

{
  key A.MeasuringPoint                                                                           as MeasuringPoint,
      A.MsmtRdngDate                                                                             as SyDate,
      B.MsmtCounterReadingDifference                                                             as PGReading,
      A.MsmtValuationCode                                                                        as MsmtValuationCode,
      A.MeasurementReadingInEntryUoM                                                             as MeasurementreadingINENTRYUOM,
      B.MeasurementReadingInEntryUoM                                                             as MeasurementreadingINENTRYUOMB,
      B.MsmtRdngIsReversed                                                                       as MsmtRdngIsReversed,
      A.ODate,
      case when A.MsmtValuationCode = 'C'
                then
      (cast(coalesce( A.MeasurementReadingInEntryUoM ,0 ) as abap.fltp) -
      cast(coalesce( cast( B.MeasurementReadingInEntryUoM as abap.fltp ),0 ) as abap.fltp))  end as TodayRead105
}
where
  (
       A.MeasuringPoint     = '000000000105'
    or A.MeasuringPoint     = '000000000022'
  )
  and  B.MsmtRdngIsReversed = ' '
  and  A.MsmtRdngIsReversed = ' '
  and  A.MsmtValuationCode  = 'C'
  and  B.MsmtValuationCode  = 'C'

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite View for Power Generation'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZC_PowerGeneration
  as select from ZI_PowerGen as PowerG
{
      @UI.facet: [{
          id:'Date',
          label: 'Date',
          type      : #IDENTIFICATION_REFERENCE,
          position  : 10
                 }]
      @UI: {  lineItem: [ { position: 10 } ],
              identification: [ { position:10 } ],
              selectionField: [ { position: 10 } ]

         }
      @EndUserText.label: 'Date'

  key PowerG.ODate,

      @UI: {  lineItem: [ { position: 20 } ],
                  identification: [ { position: 20 } ]
          }
      @EndUserText.label: 'Power Generation'

      cast(PowerG.PGReading as abap.fltp) * cast(1000 as abap.fltp) as PowGenReading,

      @UI: {  lineItem: [ { position: 30 } ],
               identification: [ { position: 30 } ]
       }
      @EndUserText.label: 'Power Export'

      cast(PowerG.EXReading as abap.fltp) * cast(1800 as abap.fltp) as PowExpReading,

      @UI: {  lineItem: [ { position: 40 } ],
               identification: [ { position: 40 } ]
       }
      @EndUserText.label: 'Capative Consumption'

      cast(PowerG.PGReading as abap.fltp) * cast(1000 as abap.fltp) -
      cast(PowerG.EXReading as abap.fltp) * cast(1800 as abap.fltp) as Difference
}

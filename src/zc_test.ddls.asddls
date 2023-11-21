@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'composite test'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zc_test as select from Ztestr1
{
@UI.facet: [{
          id:'TradersNo',
          label: 'Sales Register',
          type      : #IDENTIFICATION_REFERENCE,
      //          targetQualifier:'Sales_Tender.SoldToParty',
          position  : 10
          }
          ]
//          @Objectmodel.
//@Consumption.filter.mandatory: true
//@Search.defaultSearchElement: true
//@ObjectModel.text.association: 'Billing_Doc_No'
    @UI: {  lineItem: [ { position: 1 } ],
              identification: [ { position:1  } ],
              selectionField: [ { position:1  } ] 
         }
      @EndUserText.label: 'BILLING DOC. Type'
   key  billing_type
}

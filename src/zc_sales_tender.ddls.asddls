@AbapCatalog.sqlViewName: 'ZC_SALE_TEND'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Composite View for Sales Tender'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view ZC_SALES_TENDER
  as select from ZI_SALES_TENDER as Sales_Tender
{
      @UI.facet: [{
          id:'TradersNo',
          label: 'Traders No',
          type      : #IDENTIFICATION_REFERENCE,
      //          targetQualifier:'Sales_Tender.SoldToParty',
          position  : 10
                 }
       ]
      @UI: {  lineItem: [ { position: 10, importance: #HIGH } ],
              identification: [ { position:10 } ],
              selectionField: [ { position: 10 } ]
         }
      @EndUserText.label: 'Traders No'

  key Sales_Tender.SoldToParty,

      @UI: {  lineItem: [ { position: 20, importance: #HIGH } ],
              identification: [ { position:20 } ]
         }
      @Search.defaultSearchElement: true
      @EndUserText.label: 'Traders Name'

      Sales_Tender.TCustomerName,

      @UI: {  lineItem: [ { position: 30 } ],
              identification: [ { position:30 } ]
         }
      @Search.defaultSearchElement: true
      @EndUserText.label: 'Customer No'

      Sales_Tender.Payer,

      @UI: {  lineItem: [ { position: 40 } ],
              identification: [ { position:40 } ]
         }
      @Search.defaultSearchElement: true
      @EndUserText.label: 'Customer Name'

      Sales_Tender.CustomerName,

      @UI: {  lineItem: [ { position: 50 } ],
              identification: [ { position:50 } ],
              selectionField: [ { position: 250 } ]
         }
      @EndUserText.label: 'Sales Contract No.'

      Sales_Tender.PrecedingDocument,

      @UI: {  lineItem: [ { position: 60 } ],
              identification: [ { position:60 } ]
         }
      @EndUserText.label: 'Sales Contract Date'

      Sales_Tender.SCreationDate,

      @UI: {  lineItem: [ { position: 70 } ],
              identification: [ { position:70 } ]
         }
      @EndUserText.label: 'Target Quanity '

      Sales_Tender.RequestedQuantity,
      
      @UI: {  lineItem: [ { position: 80 } ],
              identification: [ { position:80 } ]
         }
      @EndUserText.label: 'Invoice Quantity'

      Sales_Tender.BillingQuantity,
      
      @UI: {  lineItem: [ { position: 90 } ],
              identification: [ { position:90 } ]
         }
      @EndUserText.label: 'Dispatched Qty'

      Sales_Tender.DispatchedQty,
      
      @UI: {  lineItem: [ { position: 100 } ],
              identification: [ { position:100 } ]
         }
      @EndUserText.label: 'Balance Qty'

      Sales_Tender.BalanceQty,

      @UI: {  lineItem: [ { position: 110 } ],
              identification: [ { position:110 } ]
         }
      @EndUserText.label: 'Sales Order No'

      Sales_Tender.SalesDocument,

      @UI: {  lineItem: [ { position: 120 } ],
              identification: [ { position:120 } ]
         }
      @EndUserText.label: 'Sales Order Date'

      Sales_Tender.SOCreationDate,

      @UI: {  lineItem: [ { position: 130 } ],
              identification: [ { position:130 } ]
         }
      @EndUserText.label: 'Delivery No'

      Sales_Tender.SubsequentDocumentD,

      @UI: {  lineItem: [ { position: 140 } ],
              identification: [ { position:140 } ]
         }
      @Consumption.hidden: true
      @EndUserText.label: 'Delivery Date'

      Sales_Tender.CreationDateD,

      @UI: {  lineItem: [ { position: 150 } ],
              identification: [ { position:150 } ]
         }
      @Consumption.hidden: true
      @EndUserText.label: 'Proforma Invoice No.'

      Sales_Tender.SubsequentDocumentP,

      @UI: {  lineItem: [ { position: 160 } ],
              identification: [ { position:160 } ]
         }
      @Consumption.hidden: true
      @EndUserText.label: 'Proforma Invoice Date'

      Sales_Tender.CreationDateP,

      @UI: {  lineItem: [ { position: 170 } ],
              identification: [ { position:170 } ],
              selectionField: [ { position:170 } ]
         }
      @EndUserText.label: 'Billing Doc. No.'

      Sales_Tender.BillingDocument,

      @UI: {  lineItem: [ { position: 180 } ],
              identification: [ { position:180 } ],
              selectionField: [ { position:180 } ]
         }
      @Consumption.filter.mandatory: true
      @EndUserText.label: 'Billing Date'

      Sales_Tender.BCreationDate,

//      @UI: {  lineItem: [ { position: 170 } ],
//              identification: [ { position:170 } ],
//              selectionField: [ { position:170 } ]
//         }
//      @Consumption.hidden: true
//      @EndUserText.label: 'Billing Type'
//
//      Sales_Tender.BillingDocumentType,

      @UI: {  lineItem: [ { position: 190 } ],
              identification: [ { position: 190 } ]
         }
      @EndUserText.label: 'Item No.'

      Sales_Tender.BillingDocumentItem,

      @UI: {  lineItem: [ { position: 200 } ],
              identification: [ { position:200 } ]
         }
      @EndUserText.label: 'Material Code'

      Sales_Tender.Product,

      @UI: {  lineItem: [ { position: 210 } ],
              identification: [ { position:210 } ]
         }
      @EndUserText.label: 'Material Description'

      Sales_Tender.BillingDocumentItemText,

      @UI: {  lineItem: [ { position: 220 } ],
              identification: [ { position:220 } ]
         }
      @Consumption.hidden: true
      @EndUserText.label: 'Batch No'

      Sales_Tender.Batch,

      @UI: {  lineItem: [ { position: 230 } ],
              identification: [ { position:230 } ]
         }
      @Consumption.hidden: true
      @EndUserText.label: 'Free Quantity'

      Sales_Tender.BillingQuantityTA,

      @UI: {  lineItem: [ { position: 240 } ],
              identification: [ { position:240 } ]
         }
      @EndUserText.label: 'Unit Rate'

      Sales_Tender.ConditionRateAmount,

      @UI: {  lineItem: [ { position: 250 } ],
              identification: [ { position:250 } ]
         }
      @EndUserText.label: 'Net Amount of item'

      Sales_Tender.NetAmount,

      @UI: {  lineItem: [ { position: 260 } ],
              identification: [ { position:260 } ]
         }
      @EndUserText.label: 'Total Tax of item'

      Sales_Tender.TaxAmount,

      @UI: {  lineItem: [ { position: 270 } ],
              identification: [ { position:270 } ]
         }
      @EndUserText.label: 'Gross Value of item'

      Sales_Tender.GrossValue,
      
      @UI: {  lineItem: [ { position: 280 } ],
              identification: [ { position:280 } ],
              selectionField: [ { position:280 } ]
         }
      @Search.defaultSearchElement: true
//      @Consumption.filter.mandatory: true
      @EndUserText.label: 'Valid From'

      Sales_Tender.ContractStartDate,
      
      @UI: {  lineItem: [ { position: 290 } ],
              identification: [ { position:290 } ],
              selectionField: [ { position:290 } ]
         }
      @Search.defaultSearchElement: true
//      @Consumption.filter.mandatory: true
      @EndUserText.label: 'Valid To'

      Sales_Tender.ContractEndDate,
      
      @UI: {  lineItem: [ { position: 300 } ],
              identification: [ { position:300 } ],
              selectionField: [ { position:300 } ]
         }
      @Search.defaultSearchElement: true
      @Consumption.filter.mandatory: true
      @EndUserText.label: 'Division'

      Sales_Tender.Division
      
}

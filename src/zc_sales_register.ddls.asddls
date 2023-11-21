@AbapCatalog.sqlViewName: 'ZC_SALES_REG'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite for Sales Register'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
//@ObjectModel.supportedCapabilities

//@ObjectModel.usageType:{
//    serviceQuality: #X,
//    sizeCategory: #S,
//    dataClass: #MIXED
//}
define view  ZC_SALES_REGISTER
as select from ZI_SALES_REGISTER_R3 as Sales_Register 
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
      @EndUserText.label: 'BILLING DOC. NO.'
//      @Consumption.valueHelpDefinition: [{entity: {element: 'BillingDocument' , name: 'Z_I_BILLING_F4HELP'}}]
key Sales_Register.Billing_Doc_No ,

@UI: {  lineItem: [ { position: 29 } ],
              identification: [ { position:29 } ]

         }
      @EndUserText.label: 'ITEM NO.'
  key    Sales_Register.Item_No,

@UI: {  lineItem: [ { position: 2 } ],
              identification: [ { position:2 } ],
              selectionField: [ { position:2  } ] 

         }
//         @Consumption.filter.mandatory: true
      @EndUserText.label: 'BILLING DATE'
      Sales_Register.Billing_date,
      
 @Consumption.filter.mandatory: true
 @UI: {  lineItem: [ { position: 3 } ],
              identification: [ { position:3 } ],
              selectionField: [ { position:3  } ] 

         }
      @EndUserText.label: 'BILLING TYPE.'
      @Consumption.valueHelpDefinition: [{entity: {element: 'BillingDocumentType' , name: 'Z_I_BILLING_F4HELP' }}]
     Sales_Register.Billing_Type, 
      
      @UI: {  lineItem: [ { position: 4 } ],
              identification: [ { position:4 } ]

         }
      @EndUserText.label: 'BILLING DESCRIPTION'
      Sales_Register.Billing_Description,
      
      @UI: {  lineItem: [ { position: 5 } ],
              identification: [ { position:5 } ]

         }
      @EndUserText.label: 'PRECEDING INVOICE NO.'
      Sales_Register.Preceding_Invoice_No,
      
      @UI: {  lineItem: [ { position: 6 } ],
              identification: [ { position:6 } ]

         }
      @EndUserText.label: 'PRECEDING INVOICE DATE'
      Sales_Register.Preceding_Invoice_date,
      
      @UI: {  lineItem: [ { position: 7 } ],
              identification: [ { position:7 } ]

         }
      @EndUserText.label: 'GST INVOICE NO.'
      Sales_Register.GST_Invoice_No,
      
      @UI: {  lineItem: [ { position: 8 } ],
              identification: [ { position:8 } ]

         }
      @EndUserText.label: 'BILLING DOCUMENT NO.'
      Sales_Register.Accounting_Doc_No,
      
      @UI: {  lineItem: [ { position: 9 } ],
              identification: [ { position:9 } ]

         }
      @EndUserText.label: 'DISTRIBUTION CHANNEL'
      Sales_Register.Distribution_Channel,
      
      @UI: {  lineItem: [ { position: 10 } ],
              identification: [ { position:10 } ]

         }
      @EndUserText.label: 'DIST, CHANNEL DESC.'
      Sales_Register.Dist_Channel_Desc,
      
     @Consumption.filter.mandatory: true 
      @UI: {  lineItem: [ { position: 11 } ],
              identification: [ { position:11 } ],
               selectionField: [ { position:12  } ] 

         }
      @EndUserText.label: 'DIVISION'
       @Consumption.valueHelpDefinition: [{entity: {element: 'Division' , name: 'Z_I_DIVISION_VH' }}]
      Sales_Register.Division,
      
      @UI: {  lineItem: [ { position: 12 } ],
              identification: [ { position:12 } ]
              
             
         }
      @EndUserText.label: 'DIVISION DESC.'
      Sales_Register.Division_Desc,
      
      @UI: {  lineItem: [ { position: 13 } ],
              identification: [ { position:13 } ],
              selectionField: [ { position:13  } ] 

         }
      @EndUserText.label: 'CUSTOMER GROUP'
      Sales_Register.Customer_Group,
      
            @Consumption.hidden: true
      @UI: {  lineItem: [ { position: 14 } ],
              identification: [ { position:14 } ]

         }
      @EndUserText.label: 'CUSTOMER GROUP DESC.'
      Sales_Register.Customer_Group_Desc,
      
      @UI: {  lineItem: [ { position: 15 } ],
              identification: [ { position:15 } ]

         }
      @EndUserText.label: 'CUSTOMER NO.'
      Sales_Register.Customer_No,
      
      @UI: {  lineItem: [ { position: 16 } ],
              identification: [ { position:16 } ]

         }
      @EndUserText.label: 'CUSTOMER NAME'
      Sales_Register.Customer_Name,
      
      @UI: {  lineItem: [ { position: 17 } ],
              identification: [ { position:17 } ]

         }
      @EndUserText.label: 'CUSTOMER GSTIN NO.'
      Sales_Register.Customer_GSTIN_No,
      
      @UI: {  lineItem: [ { position: 18 } ],
              identification: [ { position:18 } ]

         }
      @EndUserText.label: 'CUSTOMER PAN'
      Sales_Register.Customer_Pan,
      
      @UI: {  lineItem: [ { position: 19 } ],
              identification: [ { position:19 } ]

         }
      @EndUserText.label: 'CUSTOMER TIN'
      Sales_Register.Customer_Tin,
      
      @UI: {  lineItem: [ { position: 20 } ],
              identification: [ { position:20 } ]

         }
      @EndUserText.label: 'CUSTOMER STATE CODE'
      Sales_Register.Region,
      
      @UI: {  lineItem: [ { position: 21 } ],
              identification: [ { position:21 } ]

         }
      @EndUserText.label: 'SALES CONTRACT NO.'
      Sales_Register.Sales_Contract_No,
      
      @UI: {  lineItem: [ { position: 22 } ],
              identification: [ { position:22 } ]

         }
      @EndUserText.label: 'CUSTOMER PO NO.'
      Sales_Register.Customer_PO_No,
      
      @UI: {  lineItem: [ { position: 23 } ],
              identification: [ { position:23 } ]

         }
      @EndUserText.label: 'CUSTOMER PO DATE'
      Sales_Register.Customer_PO_Date,
      
      @UI: {  lineItem: [ { position: 24 } ],
              identification: [ { position:24 } ]

         }
      @EndUserText.label: 'SALES ORDER NO.'
      Sales_Register.sales_order_no,
      
      @UI: {  lineItem: [ { position: 25 } ],
              identification: [ { position:25 } ]

         }
      @EndUserText.label: 'SALES ORDER DATE'
      Sales_Register.Sales_Order_Date,
      
      @UI: {  lineItem: [ { position: 26 } ],
              identification: [ { position:26 } ]

         }
      @EndUserText.label: 'DELIVERY NO.'
      Sales_Register.Delivery_No,
      
      @UI: {  lineItem: [ { position: 27 } ],
              identification: [ { position:27 } ]

         }
      @EndUserText.label: 'DELIVERY DATE'
      Sales_Register.Delivery_Date,
      
      @UI: {  lineItem: [ { position: 28 } ],
              identification: [ { position:28 } ]

         }
      @EndUserText.label: 'MATERIAL GROUP'
      Sales_Register.Material_Group,
      
//      @UI: {  lineItem: [ { position: 29 } ],
//              identification: [ { position:29 } ]
//
//         }
//      @EndUserText.label: 'ITEM NO.'
//  key    Sales_Register.Item_No,
      
      @UI: {  lineItem: [ { position: 30 } ],
              identification: [ { position:30 } ]

         }
      @EndUserText.label: 'MATERIAL CODE'
      Sales_Register.Material_COde,
      
      @UI: {  lineItem: [ { position: 31 } ],
              identification: [ { position:31 } ]

         }
      @EndUserText.label: 'MATERIAL DESCRIPTION'
      Sales_Register.Material_Description,
      
      @UI: {  lineItem: [ { position: 32 } ],
              identification: [ { position:32 } ]

         }
      @EndUserText.label: 'HSN CODE'    
      Sales_Register.HSN_Code,

 @UI: {  lineItem: [ { position: 33 } ],
              identification: [ { position:33 } ]

         }
      @EndUserText.label: 'PRICE GROUP'    
      Sales_Register.Price_Group,

      @Consumption.hidden: true
      @UI: {  lineItem: [ { position: 33 } ],
              identification: [ { position:33 } ]

         }
      @EndUserText.label: 'BATCH NO.'    
      Sales_Register.Batch_NO,

      @Consumption.hidden: true
      @UI: {  lineItem: [ { position: 34 } ],
              identification: [ { position:34 } ]

         }
      @EndUserText.label: 'MANUFACTURING DATE'    
  Sales_Register.Manufacturing_Date,

      @Consumption.hidden: true
      @UI: {  lineItem: [ { position: 35 } ],
              identification: [ { position:35 } ]

         }
      @EndUserText.label: 'EXPIRY DATE'    
Sales_Register.Expiry_Date,

//@Semantics.quantity.unitOfMeasure: 'Unit'
      @UI: {  lineItem: [ { position: 36 } ],
              identification: [ { position:36 } ]

         }
      @EndUserText.label: 'INVOICE QUANTITY'    
Sales_Register.Invoice_Qty,

@Consumption.hidden: true
//@Semantics.quantity.unitOfMeasure: 'Unit'
      @UI: {  lineItem: [ { position: 37 } ],
              identification: [ { position:37 } ]

         }
      @EndUserText.label: 'FREE QUANTITY'    
Sales_Register.Free_Quantity,


      @UI: {  lineItem: [ { position: 38 } ],
              identification: [ { position:38 } ]

         }
      @EndUserText.label: 'UOM'    
 Sales_Register.Unit,     
      
    //  @Semantics.quantity.unitOfMeasure: 'Unit'
      @UI: {  lineItem: [ { position: 39 } ],
              identification: [ { position:39 } ]

         }
      @EndUserText.label: 'UNIT RATE'    
      Sales_Register.Unit_Rate,
      
       @Consumption.hidden: true
     // @DefaultAggregation:#NONE
     // @Semantics.amount.currencyCode: 'TransactionCurrency'
      @UI: {  lineItem: [ { position: 67 } ],
              identification: [ { position:67 } ]

         }
      @EndUserText.label: 'TRANSACTION CURRENCY'    
      Sales_Register.TransactionCurrency,
      
//      @DefaultAggregation:#NONE
//      @Semantics.amount.currencyCode: 'TransactionCurrency'     
      @UI: {  lineItem: [ { position: 40 } ],
              identification: [ { position:40 } ]

         }
      @EndUserText.label: 'FREIGHT AMOUNT'    
      Sales_Register.Freight_Amount,
      
//      @DefaultAggregation:#NONE
//      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @UI: {  lineItem: [ { position: 41 } ],
              identification: [ { position:41 } ]

         }
      @EndUserText.label: 'INSURANCE AMOUNT'    
      Sales_Register.Insurance_Amount,
      
//      @DefaultAggregation:#NONE
//      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @UI: {  lineItem: [ { position: 42 } ],
              identification: [ { position:42 } ]

         }
      @EndUserText.label: 'PACKAGING COST'    
      Sales_Register.Packaging_Cost,
      
      
      @UI: {  lineItem: [ { position: 43 } ],
              identification: [ { position:43 } ]

         }
      @EndUserText.label: 'BASIC AMOUNT'    
      Sales_Register.Basic_Amount,
      
//      @DefaultAggregation:#NONE
//      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @UI: {  lineItem: [ { position: 44 } ],
              identification: [ { position:44 } ]

         }
      @EndUserText.label: 'TAXABLE VALUE IN RS.'    
      Sales_Register.Taxable_Value_In_RS,
      
      @Consumption.hidden: true
      @UI: {  lineItem: [ { position: 45 } ],
              identification: [ { position:45 } ]

         }
      @EndUserText.label: 'GST RATE'    
      Sales_Register.GST_RATE,
      
      
      @UI: {  lineItem: [ { position: 46 } ],
              identification: [ { position:46 } ]

         }
      @EndUserText.label: 'CGST RATE'    
      Sales_Register.CGST_RATE,
      
//      @DefaultAggregation:#NONE
//      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @UI: {  lineItem: [ { position: 47 } ],
              identification: [ { position:47 } ]

         }
      @EndUserText.label: 'CGST'    
      Sales_Register.CGST,
      
      
      @UI: {  lineItem: [ { position: 48 } ],
              identification: [ { position:48 } ]

         }
      @EndUserText.label: 'SGST RATE'    
      Sales_Register.SGST_Rate,
      
//      @DefaultAggregation:#NONE
//      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @UI: {  lineItem: [ { position: 49 } ],
              identification: [ { position:49 } ]

         }
      @EndUserText.label: 'SGST'    
      Sales_Register.SGST,
      
      
      @UI: {  lineItem: [ { position: 50 } ],
              identification: [ { position:50 } ]

         }
      @EndUserText.label: 'IGST RATE'    
      Sales_Register.IGST_Rate,
      
//      @DefaultAggregation:#NONE
//      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @UI: {  lineItem: [ { position: 51 } ],
              identification: [ { position:51 } ]

         }
      @EndUserText.label: 'IGST'    
      Sales_Register.IGST,
      
      
      @UI: {  lineItem: [ { position: 52 } ],
              identification: [ { position:52 } ]

         }
      @EndUserText.label: 'TCS RATE'    
      Sales_Register.TCS_Rate,
      
//      @DefaultAggregation:#NONE
//      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @UI: {  lineItem: [ { position: 53 } ],
              identification: [ { position:53 } ]

         }
      @EndUserText.label: 'TCS'    
      Sales_Register.TCS,
      
      
      @UI: {  lineItem: [ { position: 54 } ],
              identification: [ { position:54 } ]

         }
      @EndUserText.label: 'VAT RATE'    
      Sales_Register.VAT_Rate,
      
//      @DefaultAggregation:#NONE
//      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @UI: {  lineItem: [ { position: 55 } ],
              identification: [ { position:55 } ]

         }
      @EndUserText.label: 'VAT'    
      Sales_Register.VAT,
      
      
      @UI: {  lineItem: [ { position: 56 } ],
              identification: [ { position:56 } ]

         }
      @EndUserText.label: 'CST RATE'    
      Sales_Register.CST_Rate,
      
//      @DefaultAggregation:#NONE
//      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @UI: {  lineItem: [ { position: 57 } ],
              identification: [ { position:57 } ]

         }
      @EndUserText.label: 'CST'    
      Sales_Register.CST,
      
//      @DefaultAggregation:#NONE
//      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @UI: {  lineItem: [ { position: 58 } ],
              identification: [ { position:58 } ]

         }
      @EndUserText.label: 'TOTAL TAX'    
      Sales_Register.Totaltax,
      
//      @DefaultAggregation:#NONE
//      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @UI: {  lineItem: [ { position: 59 } ],
              identification: [ { position:59 } ]

         }
      @EndUserText.label: 'GROSS VALUE'    
      Sales_Register.Gross_Value,
      
      
      @UI: {  lineItem: [ { position: 60 } ],
              identification: [ { position:60 } ]

         }
      @EndUserText.label: 'TRANSPORTER PURCHASE ORDER NO.'    
      Sales_Register.Transporter_Purchase_Doc_No,
      
      
      @UI: {  lineItem: [ { position: 61 } ],
              identification: [ { position:61 } ]

         }
      @EndUserText.label: 'FREIGHT VENDOR'    
      Sales_Register.Freight_vendor,
      
//      @DefaultAggregation:#NONE
//      @Semantics.amount.currencyCode: 'TransactionCurrency'
      @UI: {  lineItem: [ { position: 62 } ],
              identification: [ { position:62 } ]

         }
      @EndUserText.label: 'FREIGHT Expences'    
      Sales_Register.Freight_Exp,
      
      @UI: {  lineItem: [ { position: 63 } ],
              identification: [ { position:63 } ]

         }
      @EndUserText.label: 'FREIGHT MARGIN'    
      Sales_Register.Freight_Margin,
      
      @UI: {  lineItem: [ { position: 64 } ],
              identification: [ { position:64 } ]

         }
      @EndUserText.label: 'SALES SEASON'    
      Sales_Register.Sales_Season,
      
      @UI: {  lineItem: [ { position: 65 } ],
              identification: [ { position:65 } ]

         }
      @EndUserText.label: 'BROKER CODE'    
      Sales_Register.Broker_Code,
      
      @UI: {  lineItem: [ { position: 66 } ],
              identification: [ { position:66 } ]

         }
      @EndUserText.label: 'BROKER NAME'    
      Sales_Register.Broker_Name,
      
      @UI: {  lineItem: [ { position: 67 } ],
              identification: [ { position:66 } ]

         }
      @EndUserText.label: 'TRANSPORTER NAME'    
      Sales_Register.Transporter_Name
}

@AbapCatalog.sqlViewName: 'ZC_PUR_REG'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite View for Purchase Register'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view ZC_PURCHASE_REGISTER
  as select from ZI_PURCHASE_REGISTER as Purchase_Register
{
//      @UI.facet: [{
//          id:'TradersNo',
//          label: 'Traders No',
//          type      : #IDENTIFICATION_REFERENCE,
//      //          targetQualifier:'Sales_Tender.SoldToParty',
//          position  : 10
//                 }]
//      @UI: {  lineItem: [ { position: 10 } ],
//              identification: [ { position:10 } ]
//
//         }
//      @EndUserText.label: 'MIRO NO'
//
//  key Purchase_Register.SupplierInvoiceMIRO,
      @UI.facet: [{
          id:'TradersNo',
          label: 'Traders No',
          type      : #IDENTIFICATION_REFERENCE,
          position  : 10
                 }]
      @UI: {  lineItem: [ { position: 10 } ],
              identification: [ { position:10 } ]

         }
      @EndUserText.label: 'MIRO No.'

  key Purchase_Register.ReferenceDocumentMIRO,
  
//  @UI: {  lineItem: [ { position: 190 } ],
//               identification: [ { position: 190 } ]
//       }
//      @EndUserText.label: 'PO ITEM NO'
//
//key      Purchase_Register.PurchasingDocumentItem,

 @UI: {  lineItem: [ { position: 350 } ],
               identification: [ { position: 350 } ]
       }
      @EndUserText.label: ' Ref Doc Item'

 key     Purchase_Register.ReferenceDocumentItem,

//        @UI: {  lineItem: [ { position: 10 } ],
//              identification: [ { position: 10 } ],
//              selectionField: [ { position: 10 } ]
//      }
//      @EndUserText.label: 'ACC DOC NO'
//      Purchase_Register.AccountingDocument,
      
      @UI: {  lineItem: [ { position: 20 } ],
              identification: [ { position: 20 } ],
              selectionField: [ { position: 20 } ]
      }
      @EndUserText.label: 'POSTING DATE'

      Purchase_Register.PostingDate,

      @UI: {  lineItem: [ { position: 30 } ],
               identification: [ { position: 30 } ]
       }
      @EndUserText.label: 'REF DOC NO'

      Purchase_Register.RefDocNo,

      @UI: {  lineItem: [ { position: 40 } ],
               identification: [ { position: 40 } ]
       }
      @EndUserText.label: 'INVOICE DATE'

      Purchase_Register.InvoiceDate,

      @UI: {  lineItem: [ { position: 50 } ],
               identification: [ { position: 50 } ],
               selectionField: [ { position: 50 } ]
       }
      @EndUserText.label: 'VENDOR'

      Purchase_Register.Vendor,

      @UI: {  lineItem: [ { position: 60 } ],
               identification: [ { position: 60 } ]
       }
      @EndUserText.label: 'VENDOR NAME'

      Purchase_Register.VendorName,

      @UI: {  lineItem: [ { position: 70 } ],
               identification: [ { position: 70 } ]
       }
      @EndUserText.label: 'VENDOR REGION'

      Purchase_Register.VendorRegion,

      @UI: {  lineItem: [ { position: 80 } ],
               identification: [ { position: 80 } ]
       }
      @EndUserText.label: 'VENDOR STATE'

      Purchase_Register.RegionName,


      @UI: {  lineItem: [ { position: 90 } ],
               identification: [ { position: 90 } ]
       }
      @EndUserText.label: 'GSTIN'

      Purchase_Register.GSTIN,

      @UI: {  lineItem: [ { position: 100 } ],
               identification: [ { position: 100 } ]
       }
      @EndUserText.label: 'TIN'

      Purchase_Register.TIN,

      @UI: {  lineItem: [ { position: 110 } ],
               identification: [ { position: 110 } ],
               selectionField: [ { position: 110 } ]
       }
      @EndUserText.label: 'DEPARTMENT'

      Purchase_Register.Department,
      
      @UI: {  lineItem: [ { position: 120 } ],
               identification: [ { position: 120 } ]
       }
      @EndUserText.label: 'DEPARTMENT Description'

      Purchase_Register.DepartmentDescreption,

      @UI: {  lineItem: [ { position: 130 } ],
               identification: [ { position: 130 } ]
       }
      @EndUserText.label: 'MATERIAL CODE'

      Purchase_Register.MaterialCode,

      @UI: {  lineItem: [ { position: 140 } ],
               identification: [ { position: 140 } ]
       }
      @EndUserText.label: 'MATERIAL DESCRIPTION'

      Purchase_Register.MaterialDescription,

      @UI: {  lineItem: [ { position: 150 } ],
               identification: [ { position: 150 } ]
       }
      @EndUserText.label: 'UOM'

      Purchase_Register.UOM,

      @UI: {  lineItem: [ { position: 160 } ],
               identification: [ { position: 160 } ]
       }
      @EndUserText.label: 'HSN CODE'

      Purchase_Register.HSNCode,

      @UI: {  lineItem: [ { position: 170 } ],
               identification: [ { position: 170 } ]
       }
      @EndUserText.label: 'PO DATE'

      Purchase_Register.PurchaseOrderDate,

      @UI: {  lineItem: [ { position: 180 } ],
               identification: [ { position: 180 } ]
       }
      @EndUserText.label: 'PO NO'

      Purchase_Register.PurchasingDocument,

      @UI: {  lineItem: [ { position: 190 } ],
               identification: [ { position: 190 } ]
       }
      @EndUserText.label: 'PO ITEM NO'

      Purchase_Register.PurchasingDocumentItem,

      @UI: {  lineItem: [ { position: 200 } ],
               identification: [ { position: 200 } ]
       }
      @EndUserText.label: 'PO QTY'

      Purchase_Register.POrderQuantity,

      @UI: {  lineItem: [ { position: 210 } ],
               identification: [ { position: 210 } ]
       }
      @EndUserText.label: 'BILL QTY'

      Purchase_Register.QuantityInPurchaseOrderUnit,

      @UI: {  lineItem: [ { position: 220 } ],
              identification: [ { position: 220 } ]
      }
      @EndUserText.label: 'RATE'

      Purchase_Register.Rate,

      @UI: {  lineItem: [ { position: 230 } ],
              identification: [ { position: 230 } ]
      }
      @EndUserText.label: 'BASE AMOUNT'

      Purchase_Register.BaseAmount,

      @UI: {  lineItem: [ { position: 240 } ],
             identification: [ { position: 240 } ]
      }
      @EndUserText.label: 'DISCOUNT %'

      Purchase_Register.Discount,
 
      @UI: {  lineItem: [ { position: 250 } ],
              identification: [ { position: 250 } ]
      }
      @EndUserText.label: 'TAX CODE'

      Purchase_Register.TaxCode,

      @UI: {  lineItem: [ { position: 260 } ],
              identification: [ { position: 260 } ]
      }
      @EndUserText.label: 'SGST AMOUNT'

      Purchase_Register.SGST,

      @UI: {  lineItem: [ { position: 270 } ],
              identification: [ { position: 270 } ]
      }
      @EndUserText.label: 'CGST AMOUNT'

      Purchase_Register.CGST,

      @UI: {  lineItem: [ { position: 280 } ],
              identification: [ { position: 280 } ]
      }
      @EndUserText.label: 'IGST AMOUNT'

      Purchase_Register.IGST,

      @UI: {  lineItem: [ { position: 290 } ],
               identification: [ { position: 290 } ]
       }
      @EndUserText.label: 'RCM CGST INPUT AMT'

      Purchase_Register.RCGST,

      @UI: {  lineItem: [ { position: 300 } ],
               identification: [ { position: 300 } ]
       }
      @EndUserText.label: 'RCM SGST INPUT AMT'

      Purchase_Register.RSGST,

      @UI: {  lineItem: [ { position: 310 } ],
               identification: [ { position: 310 } ]
       }
      @EndUserText.label: 'RCM IGST INPUT AMT'

      Purchase_Register.RIGST,
      
      @UI: {  lineItem: [ { position: 320 } ],
               identification: [ { position: 320 } ]
       }
      @EndUserText.label: 'Net Invoice Amount'

      Purchase_Register.NetInvoiceAmount,

//      @UI: {  lineItem: [ { position: 320 } ],
//               identification: [ { position: 320 } ]
//       }
//      @EndUserText.label: 'TOTAL'

//      Purchase_Register.AmountInTransactionCurrencyTO,

      @UI: {  lineItem: [ { position: 330 } ],
               identification: [ { position: 330 } ],
               selectionField: [ { position: 330 } ]
       }
      @EndUserText.label: 'Accounting Document No'

      Purchase_Register.AccountingDocument,

      @UI: {  lineItem: [ { position: 340 } ],
               identification: [ { position: 340 } ]
       }
      @EndUserText.label: 'MIGO Doc No'

      Purchase_Register.ReferenceDocumentMIGO
      

//      @UI: {  lineItem: [ { position: 350 } ],
//               identification: [ { position: 350 } ]
//       }
//      @EndUserText.label: ' Ref Doc Item'
//
//      Purchase_Register.ReferenceDocumentItem
}

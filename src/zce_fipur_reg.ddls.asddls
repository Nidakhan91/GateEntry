@ObjectModel.query.implementedBy: 'ABAP:ZCL_FI_PUR_REG'
@EndUserText.label: 'ttt'
define root custom entity ZCE_FIPUR_REG
  //with
{
      @UI.facet                   : [
                 {
                   id             :       'Product',
                   purpose        :  #STANDARD,
                   type           :     #IDENTIFICATION_REFERENCE,
                   label          : 'Traders No',
                   position       : 10 }
               ]

      @UI                         : {
      lineItem                    : [{position: 10, importance: #HIGH}],
      identification              : [{position: 10}],
      selectionField              : [{position: 10}]
      }
      @EndUserText.label          : 'MIRO No.'
  key ReferenceDocumentMIRO       : abap.char( 20 );
      @UI                         : {
      lineItem                    : [{position: 20, importance: #HIGH}],
      identification              : [{position: 20}]
      }
      @EndUserText.label          : 'Reference Document Item'
      ReferenceDocumentItem       : abap.char( 6 );
//      @UI                         : {
//      lineItem                    : [{position: 30, importance: #HIGH}],
//      identification              : [{position: 30}]
//      }
//      @EndUserText.label          : 'Posting Date'
//      PostingDate                 : abap.dats( 8 );
//      @UI                         : {
//      lineItem                    : [{position: 40, importance: #HIGH}],
//      identification              : [{position: 40}]
//      }
//      @EndUserText.label          : 'Ref Doc No.'
//      RefDocNo                    : abap.char( 16 );
//      @UI                         : {
//      lineItem                    : [{position: 50, importance: #HIGH}],
//      identification              : [{position: 50}]
//      }
//      @EndUserText.label          : 'Invoice Date'
//      InvoiceDate                 : abap.dats( 8 );
//      @UI                         : {
//      lineItem                    : [{position: 60, importance: #HIGH}],
//      identification              : [{position: 60}]
//      }
//      @EndUserText.label          : 'Vendor'
//      Vendor                      : abap.char( 10 );
//      @UI                         : {
//      lineItem                    : [{position: 70, importance: #HIGH}],
//      identification              : [{position: 70}]
//      }
//      @EndUserText.label          : 'Vendor Name'
//      VendorName                  : abap.char( 80 );
//      @UI                         : {
//      lineItem                    : [{position: 80, importance: #HIGH}],
//      identification              : [{position: 80}]
//      }
//      @EndUserText.label          : 'Vendor Region'
//      VendorRegion                : abap.char( 3 );
//      @UI                         : {
//      lineItem                    : [{position: 90, importance: #HIGH}],
//      identification              : [{position: 90}]
//      }
//      @EndUserText.label          : 'Region Name'
//      RegionName                  : abap.char( 20 );
//      @UI                         : {
//      lineItem                    : [{position: 100, importance: #HIGH}],
//      identification              : [{position: 100}]
//      }
//      @EndUserText.label          : 'GSTIN'
//      GSTIN                       : abap.char( 18 );
//      @UI                         : {
//      lineItem                    : [{position: 110, importance: #HIGH}],
//      identification              : [{position: 110}]
//      }
//      @EndUserText.label          : 'TIN'
//      TIN                         : abap.char( 11 );
//      @UI                         : {
//      lineItem                    : [{position: 120, importance: #HIGH}],
//      identification              : [{position: 120}]
//      }
//      @EndUserText.label          : 'DEPARTMENT'
//      Department                  : abap.char( 3 );
//      @UI                         : {
//      lineItem                    : [{position: 130, importance: #HIGH}],
//      identification              : [{position: 130}]
//      }
//      @EndUserText.label          : 'DEPARTMENT Description'
//      DepartmentDescreption       : abap.char( 3 );
//      @UI                         : {
//      lineItem                    : [{position: 140, importance: #HIGH}],
//      identification              : [{position: 140}]
//      }
//      @EndUserText.label          : 'MaterialCode'
//      MaterialCode                : abap.char( 40 );
//      @UI                         : {
//      lineItem                    : [{position: 150, importance: #HIGH}],
//      identification              : [{position: 150}]
//      }
//      @EndUserText.label          : 'DEPARTMENT Description'
//      MaterialDescription         : abap.char( 40 );
//      @UI                         : {
//      lineItem                    : [{position: 160, importance: #HIGH}],
//      identification              : [{position: 160}]
//      }
//      @EndUserText.label          : 'UOM'
//      UOM                         : abap.unit( 3 );
//      @UI                         : {
//      lineItem                    : [{position: 170, importance: #HIGH}],
//      identification              : [{position: 170}]
//      }
//      @EndUserText.label          : 'HSN CODE'
//      HSNCode                     : abap.char( 16 );
//      @UI                         : {
//      lineItem                    : [{position: 180, importance: #HIGH}],
//      identification              : [{position: 180}]
//      }
//      @EndUserText.label          : 'PO DATE'
//      PurchaseOrderDate           : abap.dats( 8 );
//      @UI                         : {
//      lineItem                    : [{position: 190, importance: #HIGH}],
//      identification              : [{position: 190}]
//      }
//      @EndUserText.label          : 'PO NO'
//      PurchasingDocument          : abap.char( 10 );
//      @UI                         : {
//      lineItem                    : [{position: 200, importance: #HIGH}],
//      identification              : [{position: 200}]
//      }
//      @EndUserText.label          : 'PO Item'
//      PurchasingDocumentItem      : abap.numc( 5 );
//      @UI                         : {
//      lineItem                    : [{position: 210, importance: #HIGH}],
//      identification              : [{position: 210}]
//      }
//      @EndUserText.label          : 'PO QTY'
//      POQTY                       : abap.unit( 3 );
//      @UI                         : {
//      lineItem                    : [{position: 220, importance: #HIGH}],
//      identification              : [{position: 220}]
//      }
//      @EndUserText.label          : 'BILL QTY'
//      @Semantics.quantity.unitOfMeasure: 'UOM'
//      QuantityInPurchaseOrderUnit : abap.quan( 13, 0 );
//      @UI                         : {
//      lineItem                    : [{position: 230, importance: #HIGH}],
//      identification              : [{position: 230}]
//      }
//      @EndUserText.label          : 'DocumentCurrency'
//      DocumentCurrency            : abap.cuky( 5 );
//      @UI                         : {
//      lineItem                    : [{position: 240, importance: #HIGH}],
//      identification              : [{position: 240}]
//      }
//      @EndUserText.label          : 'Rate'
//      @Semantics.amount.currencyCode: 'DocumentCurrency'
//      Rate                        : abap.curr( 11,2 );
//      @UI                         : {
//      lineItem                    : [{position: 250, importance: #HIGH}],
//      identification              : [{position: 250}]
//      }
//      @EndUserText.label          : 'Base Amount'
//      @Semantics.amount.currencyCode: 'DocumentCurrency'
//      BaseAmount                  : abap.curr( 15, 2 );
//      @UI                         : {
//      lineItem                    : [{position: 260, importance: #HIGH}],
//      identification              : [{position: 260}]
//      }
//      @EndUserText.label          : 'DISCOUNT %'
//      @Semantics.amount.currencyCode: 'DocumentCurrency'
//      Discount                    : abap.curr( 11, 2 );
//      @UI                         : {
//      lineItem                    : [{position: 270, importance: #HIGH}],
//      identification              : [{position: 270}]
//      }
//      @EndUserText.label          : 'TAX CODE'
//      TaxCode                     : abap.char( 2 );
//      @UI                         : {
//      lineItem                    : [{position: 280, importance: #HIGH}],
//      identification              : [{position: 280}]
//      }
//      @EndUserText.label          : 'SGST Amount'
//      @Semantics.amount.currencyCode: 'DocumentCurrency'
//      SGST                        : abap.curr( 13, 2 );
//      @UI                         : {
//      lineItem                    : [{position: 290, importance: #HIGH}],
//      identification              : [{position: 290}]
//      }
//      @EndUserText.label          : 'CGST Amount'
//      @Semantics.amount.currencyCode: 'DocumentCurrency'
//      CGST                        : abap.curr( 13, 2 );
//      @UI                         : {
//      lineItem                    : [{position: 300, importance: #HIGH}],
//      identification              : [{position: 300}]
//      }
//      @EndUserText.label          : 'IGST Amount'
//      @Semantics.amount.currencyCode: 'DocumentCurrency'
//      IGST                        : abap.curr( 13, 2 );
//      @UI                         : {
//      lineItem                    : [{position: 310, importance: #HIGH}],
//      identification              : [{position: 310}]
//      }
//      @EndUserText.label          : 'RCM CGST INPUT AMT'
//      @Semantics.amount.currencyCode: 'DocumentCurrency'
//      RCGST                       : abap.curr( 13, 2 );
//      @UI                         : {
//      lineItem                    : [{position: 320, importance: #HIGH}],
//      identification              : [{position: 320}]
//      }
//      @EndUserText.label          : 'RCM SGST INPUT AMT'
//      @Semantics.amount.currencyCode: 'DocumentCurrency'
//      RSGST                       : abap.curr( 13, 2 );
//      @UI                         : {
//      lineItem                    : [{position: 330, importance: #HIGH}],
//      identification              : [{position: 330}]
//      }
//      @EndUserText.label          : 'RCM IGST INPUT AMT'
//      @Semantics.amount.currencyCode: 'DocumentCurrency'
//      RIGST                       : abap.curr( 13, 2 );
//      @UI                         : {
//      lineItem                    : [{position: 340, importance: #HIGH}],
//      identification              : [{position: 340}]
//      }
//      @EndUserText.label          : 'Net Invoice Amount'
//      @Semantics.amount.currencyCode: 'DocumentCurrency'
//      NetInvoiceAmount            : abap.curr( 13, 2 );
      @UI                         : {
      lineItem                    : [{position: 350, importance: #HIGH}],
      identification              : [{position: 350}]
      }
      @EndUserText.label          : 'Accounting Document No'
      AccountingDocument          : abap.char( 10 );
//      @UI                         : {
//      lineItem                    : [{position: 360, importance: #HIGH}],
//      identification              : [{position: 360}]
//      }
//      @EndUserText.label          : 'MIGO Doc No'
//      ReferenceDocumentMIGO       : abap.char( 10 );
//      @UI                         : {
//      lineItem                    : [{position: 370, importance: #HIGH}],
//      identification              : [{position: 370}]
//      }
//      @EndUserText.label          : 'Fiscal Year'
//      FiscalYear                  : abap.numc( 4 );
//      @UI                         : {
//      lineItem                    : [{position: 380, importance: #HIGH}],
//      identification              : [{position: 380}]
//      }
//      @EndUserText.label          : 'Debit Credit Code'
//      DebitCreditCode             : abap.char( 1 );
      @UI                         : {
      lineItem                    : [{position: 390, importance: #HIGH}],
      identification              : [{position: 390}]
      }
      @EndUserText.label          : 'Accounting Doc Type'
      AccountingDocumentType      : abap.char( 2 );
//      @UI                         : {
//      lineItem                    : [{position: 400, importance: #HIGH}],
//      identification              : [{position: 400}]
//      }
//      @EndUserText.label          : 'Condition Rate Value'
//      ConditionRateValue          : abap.dec( 24, 2 );
}

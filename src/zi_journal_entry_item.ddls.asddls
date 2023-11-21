@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View for Journal Entry Item Details'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_JOURNAL_ENTRY_ITEM
  as select distinct from I_JournalEntryItem as JournalEntryItem
  association [0..1] to ZI_PO_MASTER as PO_Master on  JournalEntryItem.ReferenceDocument     = PO_Master.SupplierInvoice
                                               and JournalEntryItem.ReferenceDocumentItem = PO_Master.SupplierInvoiceItem
                                               and JournalEntryItem.FiscalYear            = PO_Master.FiscalYear

{
  key JournalEntryItem.ReferenceDocument           as ReferenceDocument,
  key JournalEntryItem.ReferenceDocumentItem       as ReferenceDocumentItem,
  key PO_Master.PurchaseOrder                      as PurchaseOrder,
  key PO_Master.PurchaseOrderItem                  as PurchaseOrderItem,
  key PO_Master.PurchaseOrderItemMaterial          as PurchaseOrderItemMaterial,
      JournalEntryItem.FiscalYear                  as FiscalYear,
      JournalEntryItem.TransactionTypeDetermination as TransactionTypeDetermination,
      JournalEntryItem.CompanyCodeCurrency         as CompanyCodeCurrency,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      JournalEntryItem.AmountInTransactionCurrency as AmountInTransactionCurrency,
      PO_Master.PurchasingGroup                    as PurchasingGroup,
      PO_Master.PurchaseOrderItemText              as PurchaseOrderItemText,
      PO_Master.BaseUnit                           as BaseUnit,
      PO_Master.ConsumptionTaxCtrlCode             as ConsumptionTaxCtrlCode,
      PO_Master.PurchaseOrderDate                  as PurchaseOrderDate,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      PO_Master.NetPriceAmount                     as NetPriceAmount,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      PO_Master.OrderQuantity                      as OrderQuantity,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      PO_Master.QuantityInPurchaseOrderUnit        as QuantityInPurchaseOrderUnit,
      PO_Master.DocumentCurrency                   as DocumentCurrency,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      PO_Master.SupplierInvoiceItemAmount          as SupplierInvoiceItemAmount,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      PO_Master.ConditionAmount                    as ConditionAmount,
      PO_Master.ConditionRateValue                 as ConditionRateValue,
      PO_Master.TaxCode                            as TaxCode,
      PO_Master.ConditionRateValueC                as ConditionRateValueC,
      PO_Master.ReferenceDocument                  as ReferenceDocumentMIGO,

//      @Semantics.amount.currencyCode: 'DocumentCurrency'
//      case JournalEntryItem.TransactionTypeDetermination
//      when 'WRX' then     JournalEntryItem.AmountInTransactionCurrency
//      end                                          as AmountInTransactionCurrencyW,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      case JournalEntryItem.TransactionTypeDetermination
      when 'JIS' then     JournalEntryItem.AmountInTransactionCurrency
      end                                          as AmountInTransactionCurrencyS
//      @Semantics.amount.currencyCode: 'DocumentCurrency'
//      case JournalEntryItem.TransactionTypeDetermination
//      when 'JIC' then     JournalEntryItem.AmountInTransactionCurrency
//      end                                          as AmountInTransactionCurrencyC
}
where
  JournalEntryItem.ReferenceDocumentItem <> '000000'
//  and PO_Master.PurchaseOrder <> ''
//  and PO_Master.PurchaseOrderItem <> '00000'

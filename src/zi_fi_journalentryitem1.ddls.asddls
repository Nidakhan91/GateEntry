@AbapCatalog.sqlViewName: 'ZI_FI_JOUITEM'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS for FI JOURNALENTRYITEM'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view ZI_FI_JOURNALENTRYITEM1
  as select distinct from I_JournalEntryItem as JournalItem
  //  association [0..1] to I_JournalEntryItem            as GetSupplier on  JournalItem.CompanyCode          =  GetSupplier.CompanyCode
  //                                                                     and JournalItem.FiscalYear           =  GetSupplier.FiscalYear
  //                                                                     and JournalItem.AccountingDocument   =  GetSupplier.AccountingDocument
  //                                                                     and GetSupplier.FinancialAccountType =  'K'
  //                                                                     and GetSupplier.Supplier             <> ''
  //                                                                     and JournalItem.DebitCreditCode      =  'S'
  //                                                                     and JournalItem.OffsettingAccount    <> ''
  //  association [0..1] to I_SuplrInvcItemPurOrdRefAPI01 as Supplier on  JournalItem.ReferenceDocument     = Supplier.SupplierInvoice
  //                                                                  and JournalItem.ReferenceDocumentItem = Supplier.SupplierInvoiceItem
  //                                                                  and JournalItem.FiscalYear            = Supplier.FiscalYear
{
  key JournalItem.AccountingDocument     as AccountingDocument,
      //key JournalItem.AccountingDocumentItem as AccountingDocumentItem,
  key JournalItem.FiscalYear             as FiscalYear,
      JournalItem.PurchasingDocument     as PurchasingDocument,

      JournalItem.PostingDate            as PostingDate,
      JournalItem.OffsettingAccount      as OffsettingAccount,
      JournalItem.PurchasingDocumentItem as PurchasingDocumentItem,
      JournalItem.DebitCreditCode        as DebitCreditCode,
      JournalItem.ReferenceDocument      as ReferenceDocumentMIRO,
      JournalItem.ReferenceDocumentItem  as ReferenceDocumentItem,
      JournalItem.TaxCode                as TaxCode,
      JournalItem.AccountingDocumentType as AccountingDocumentType,
      //            @Semantics: { amount : {currencyCode: 'AmountInFunctionalCurrency'} }
      //      @Semantics.amount.currencyCode:'AmountInFunctionalCurrency'
      //      @Semantics.currencyCode: true
      //      JournalItem.AmountInFunctionalCurrency as AmountInFunctionalCurrency,

      JournalItem.Supplier               as Supplier
}
where
//  //       JournalItem.Supplier               <> ' '
//  //  and
       JournalItem.DebitCreditCode        =  'S'
  and  JournalItem.OffsettingAccount      <> ' '
//  //  and  JournalItem.FinancialAccountType   =  'K'
  and(
       JournalItem.AccountingDocumentType =  'RE'
    or JournalItem.AccountingDocumentType =  'KR'
  )
  and  JournalItem.PurchasingDocument     =  ' '

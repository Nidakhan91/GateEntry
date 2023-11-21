@AbapCatalog.sqlViewName: 'ZI_JOURNALITEM'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'JOURNAL ENTRY FILTER LOGIC'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view ZI_JOURNALENTRYITEM1
  as select distinct from I_JournalEntryItem as JournalItem
  association [0..1] to I_JournalEntryItem as GetSupplier on  JournalItem.CompanyCode          =  GetSupplier.CompanyCode
                                                          and JournalItem.FiscalYear           =  GetSupplier.FiscalYear
                                                          and JournalItem.AccountingDocument   =  GetSupplier.AccountingDocument
                                                          and GetSupplier.FinancialAccountType =  'K'
                                                          and GetSupplier.Supplier             <> ''
{
  key JournalItem.AccountingDocument     as AccountingDocument,
  key JournalItem.PurchasingDocument     as PurchasingDocument,
  key JournalItem.FiscalYear             as FiscalYear,
      JournalItem.PostingDate            as PostingDate,
      JournalItem.OffsettingAccount      as OffsettingAccount,
      JournalItem.PurchasingDocumentItem as PurchasingDocumentItem,
      JournalItem.DebitCreditCode        as DebitCreditCode,
      JournalItem.ReferenceDocument      as ReferenceDocumentMIRO,
      JournalItem.ReferenceDocumentItem  as ReferenceDocumentItem,
      JournalItem.TaxCode                as TaxCode,
      //            @Semantics: { amount : {currencyCode: 'AmountInFunctionalCurrency'} }
      //      @Semantics.amount.currencyCode:'AmountInFunctionalCurrency'
      //      @Semantics.currencyCode: true
      //      JournalItem.AmountInFunctionalCurrency as AmountInFunctionalCurrency,

      GetSupplier.Supplier               as Supplier
}
where
      JournalItem.PurchasingDocument     <> ''
  and JournalItem.DebitCreditCode        =  'S'
  and JournalItem.OffsettingAccount      <> ''
  and JournalItem.AccountingDocumentType =  'RE'

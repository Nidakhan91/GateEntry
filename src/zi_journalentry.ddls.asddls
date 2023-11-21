@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Fetch GL Account from Billing Document'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_JournalEntry as select from I_BillingDocumentBasic as Billingheader
association [0..1] to I_JournalEntryItem as Journal 
on Journal.AccountingDocument = Billingheader.AccountingDocument 
and Journal.DebitCreditCode  = 'H'
and Journal.PostingKey       = '50'
//AND JOURNAL.IT

association [0..1] to ZI_GLACCOUNTDATA as GLname
on GLname.AccountingDocument = Billingheader.AccountingDocument
//and GLname.

{
    key Billingheader.BillingDocument ,
    key Billingheader.AccountingDocument,
        Journal.DebitCreditCode,
        Journal.PostingKey,
        Journal.GLAccount,
        GLname.GLAccountName
}

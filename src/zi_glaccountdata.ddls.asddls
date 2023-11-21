@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GL Account Desc by passing GL Account No.'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_GLACCOUNTDATA as select from I_JournalEntryItem as Journal
association [0..1] to  I_BillingDocumentBasic as Billingheader
on Billingheader.AccountingDocument = Journal.AccountingDocument
//and Billingheader. journal.AccountingDocumentItem



association [0..1] to  I_GLAccountTextRawData as GLdesc
on GLdesc.GLAccount = Journal.GLAccount
and GLdesc.Language = 'E'
and GLdesc.ChartOfAccounts = Journal.ChartOfAccounts



{
    key Journal.GLAccount,
        Billingheader.AccountingDocument,
        GLdesc.GLAccountName
        
}

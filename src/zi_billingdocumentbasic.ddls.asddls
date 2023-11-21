@AbapCatalog.sqlViewName: 'ZI_BILLDOCBASIC'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View for Billing Doc Basic'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view ZI_BillingDocumentBasic as select from I_BillingDocumentBasic as BillingDocBasic
association [0..1] to I_Customer as Customer
    on BillingDocBasic.PayerParty = Customer.Customer
{
    key BillingDocBasic.BillingDocument as BillingDocument,
        BillingDocBasic.PayerParty as PayerParty,
        BillingDocBasic.BillingDocumentType as BillingDocumentType,
        Customer.CustomerName as CustomerName
}

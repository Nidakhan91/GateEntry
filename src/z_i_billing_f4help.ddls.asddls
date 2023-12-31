@AbapCatalog.sqlViewName: 'ZIBILLING_F4HELP'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Billing Document F4 help'
@Metadata.ignorePropagatedAnnotations: true
//@AbapCatalog.extensibility.extensible: true
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.supportedCapabilities: [#CDS_MODELING_ASSOCIATION_TARGET, #CDS_MODELING_DATA_SOURCE, #SQL_DATA_SOURCE, #VALUE_HELP_PROVIDER, #SEARCHABLE_ENTITY]
//@ObjectModel.usageType:{
//    serviceQuality: #X,
//    sizeCategory: #S,
//    dataClass: #MIXED
//}
@ObjectModel.resultSet.sizeCategory: #XS
define view Z_I_BILLING_F4HELP as select from I_BillingDocumentBasic as Billingheader
{
//    key Billingheader.BillingDocument as BillingDocument,
    key Billingheader.BillingDocumentType as BillingDocumentType
//        Billingheader.Division
    
}
where Billingheader.AccountingPostingStatus = 'C' 
and   Billingheader.BillingDocumentIsCancelled <> 'X'
and   Billingheader.BillingDocumentType <> 'S1'
and   Billingheader.BillingDocumentType <> 'S2' 
group by Billingheader.BillingDocumentType //, Billingheader.Division

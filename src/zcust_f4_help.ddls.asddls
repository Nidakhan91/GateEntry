@AbapCatalog.sqlViewName: 'ZCUSTF4HELP'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.representativeKey: 'BillingDocumenttype'
//@ObjectModel.dataCategory: #TEXT
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #X
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.supportedCapabilities: [#SQL_DATA_SOURCE,#CDS_MODELING_DATA_SOURCE,#CDS_MODELING_ASSOCIATION_TARGET,#LANGUAGE_DEPENDENT_TEXT]
@EndUserText.label: 'Custom F4 Help'
@Metadata.ignorePropagatedAnnotations: true

@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory: #VALUE_HELP
//@ObjectModel.usageType:{
//    serviceQuality: #X,
//    sizeCategory: #S,
//    dataClass: #MIXED
//}
define view Zcust_f4_Help as select from I_BillingDocumentBasic as Billingheader
{
   key Billingheader.BillingDocumentType as BillingDocumentType
}
where Billingheader.AccountingPostingStatus = 'C' 
and   Billingheader.BillingDocumentIsCancelled <> 'X'
and   Billingheader.BillingDocumentType <> 'S1'
and   Billingheader.BillingDocumentType <> 'S2' 
group by Billingheader.BillingDocumentType

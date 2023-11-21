@AbapCatalog.sqlViewName: 'ZITESTBASICVIEW'
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Testing F4 help for Basic View'
//@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.usageType:{
//    serviceQuality: #X,
//    sizeCategory: #S,
//    dataClass: #MIXED
//}
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'BillingDocumentType'
@ObjectModel.dataCategory: #TEXT
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #X
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.supportedCapabilities: [#SQL_DATA_SOURCE,#CDS_MODELING_DATA_SOURCE,#CDS_MODELING_ASSOCIATION_TARGET,#LANGUAGE_DEPENDENT_TEXT]
@Search.searchable: true
//@VDM.viewType: #BASIC
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Doc. Type'
define view ZI_TEST_BASICVIEW as select from I_BillingDocumentTypeText 
{
@Semantics.language: true
    key Language as Spras,
@Search.defaultSearchElement: true
key BillingDocumentType
}

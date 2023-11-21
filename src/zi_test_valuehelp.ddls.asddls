////@AbapCatalog.viewEnhancementCategory: [#NONE]
////@AccessControl.authorizationCheck: #NOT_REQUIRED
////@EndUserText.label: 'Billing Document Type F4 Value Help'
////@Metadata.ignorePropagatedAnnotations: true
////@ObjectModel.usageType:{
////    serviceQuality: #X,
////    sizeCategory: #S,
////    dataClass: #MIXED
////}
@AbapCatalog.sqlViewName: 'ZITESTVALUEHELP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BILLING DOCUMENT Value Help'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.supportedCapabilities: [#CDS_MODELING_ASSOCIATION_TARGET, #CDS_MODELING_DATA_SOURCE, #SQL_DATA_SOURCE, #VALUE_HELP_PROVIDER, #SEARCHABLE_ENTITY]
@Search.searchable: true
//@ObjectModel.query.implementedBy: 'ABAP:_GATEVALUE'
//@VDM.viewType: #BASIC
define view ZI_TEST_ValueHelp as select from ZI_TEST_DataTable
{
 @ObjectModel.text.association: '_BASIC'
      @Search.defaultSearchElement: true
      key BillingDocumentType,
      _BASIC
    
} group by BillingDocumentType 

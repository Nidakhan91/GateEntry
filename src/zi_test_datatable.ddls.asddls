@AbapCatalog.sqlViewName: 'ZITESTDATATABLE'
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Billing Document Type F4 Value Help Data Table'
//@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.usageType:{
//    serviceQuality: #X,
//    sizeCategory: #S,
//    dataClass: #MIXED
//}

@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Country Help'

@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'BillingDocumentType'
@ObjectModel.sapObjectNodeType.name: 'BillingDocumentType'
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.supportedCapabilities: [#CDS_MODELING_ASSOCIATION_TARGET, #CDS_MODELING_DATA_SOURCE, #SQL_DATA_SOURCE]
//@VDM.viewType: #BASIC
define view  ZI_TEST_DataTable as select from I_BillingDocumentBasic
association [0..1] to ZI_TEST_BASICVIEW as _BASIC on $projection.BillingDocumentType = _BASIC.BillingDocumentType

{
@ObjectModel.text.association: '_Basic'
      @Search.defaultSearchElement: true
    key I_BillingDocumentBasic.BillingDocumentType,
//    BillingDocumentTypeName,
    _BASIC         //Make Association Public
}

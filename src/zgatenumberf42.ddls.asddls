//@AbapCatalog.viewEnhancementCategory: [#NONE]
@AbapCatalog.sqlViewName: 'ZGATENUMBER42'
@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gate Number F4'
//@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #S,
    dataClass: #CUSTOMIZING
}
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.supportedCapabilities: [#CDS_MODELING_ASSOCIATION_TARGET, #CDS_MODELING_DATA_SOURCE, #SQL_DATA_SOURCE, #VALUE_HELP_PROVIDER, #SEARCHABLE_ENTITY]
@Search.searchable: true
//@VDM.viewType: #BASIC
define view  zgatenumberf42 as select from zgenpoheader
{
   
    key plant as Plant, @Search.defaultSearchElement: true
    key gateentryno as Gateentryno,
    key gateentrydate as Gateentrydate
}

//@AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Gate Entry Value Help'
//@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.usageType:{
 //   serviceQuality: #X,
  //  sizeCategory: #S,
   // dataClass: #MIXED
//}
//@AbapCatalog.extensibility.extensible: true
//@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gen PO CDs for Header and Item'
@ObjectModel.dataCategory: #VALUE_HELP
//@ObjectModel.supportedCapabilities: [#CDS_MODELING_ASSOCIATION_TARGET, #CDS_MODELING_DATA_SOURCE, #SQL_DATA_SOURCE, #VALUE_HELP_PROVIDER, #SEARCHABLE_ENTITY]
//@Search.searchable: true
@ObjectModel.query.implementedBy: 'ABAP:ZCL_GATEVALUE'
define custom entity zgenpovaluehelp 
{ //@Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8 }
 @Search: { defaultSearchElement: true }
     @ObjectModel.text.element: ['gateentryno']
    
    key gateentryno :abap.char(10);
    gateentrydate:abap.char(12);
    plant :abap.char(5);
    supplier:abap.char(12);
    podocno:abap.char(12);
    invoiceno:abap.char(12);
    suppliertype:abap.char(12);
}

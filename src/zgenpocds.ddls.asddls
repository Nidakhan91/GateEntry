//@AbapCatalog.sqlViewName: 'ZGENPOCDS'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AbapCatalog.extensibility.extensible: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gen PO CDs for Header and Item'
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.supportedCapabilities: [#CDS_MODELING_ASSOCIATION_TARGET, #CDS_MODELING_DATA_SOURCE, #SQL_DATA_SOURCE, #VALUE_HELP_PROVIDER, #SEARCHABLE_ENTITY]

//@OData.publish:true
define root view entity ZGENPOCDS as select from zgenpoheader as genh
composition [0..*] of zgenpurchasecds1 as _genitem
//    on $projection.gateentryno = _genitem.gateentryno and
//       $projection.plant = _genitem.plant and
//       $projection.supplier = _genitem.Supplier and
//       $projection.podocno = _genitem.podocno
{
    key plant          ,
// @Consumption.valueHelpDefinition: [{ entity: { name: 'ZTEST_FR_CDS', element: 'Value' } }]
  key gateentryno     ,
  key gateentrydate  ,
  key supplier       ,
  key podocno        ,
  invoiceno,
  invoicedate,
  suppliertype        ,
  ewaybill            ,
  vendorname          ,
  noofpackages        ,//: abap.sstring(25);
  vehicleno           ,//: abap.sstring(25);
  vehicletype         ,//: abap.sstring(25);
  binsyesno           ,//: abap.sstring(25);
  noofbins            ,//: abap.sstring(25);
  transporter         ,//: abap.sstring(25);
  transportmode       ,//: abap.sstring(25);
  lrno                ,//: abap.sstring(25);
  approvervendor      ,//: abap.sstring(25);
  customercode        ,//: abap.sstring(12);
  customername        ,//: abap.sstring(50);
  lrdate              ,//: abap.sstring(25);
  gateentryactualdate ,//: abap.sstring(25);
  grossqty            ,//: abap.sstring(25);
  tolorane            ,//: abap.sstring(25);
  tareqty             ,//: abap.sstring(25);
  netqty              ,//: abap.sstring(25);
  weighttime          ,//: abap.sstring(25);
  weighdate           ,//: abap.sstring(25);
  remark              ,//: abap.sstring(25);
  isclose,  
  iscancelled,
  
  cancelreason,
  creationtime        ,
   createdby          ,
  closedon            ,
  closedtime          ,
  cancelledon         ,
    cancelledby,
    cancelledtime,
    _genitem // Make association public
}

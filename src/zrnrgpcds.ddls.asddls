//@AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'RGP/NRGP CDS'
//@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.usageType:{
  //  serviceQuality: #X,
   // sizeCategory: #S,
    //dataClass: #MIXED
//}
define root view entity zrnrgpcds as select from zrnrgpheader as head
composition [0..*] of zrnrgpitemcds as item 
{
    key gatepasstype as Gatepasstype,
    key gatepassnumber as Gatepassnumber,
    key gatepassyear as Gatepassyear,
    key plant as Plant,
    purchasematerialdoc as purchasematerialdoc,
    requester as Requester,
    valueininr as Valueininr,
    remark as Remark,
    transportmode as Transportmode,
    vehicalnumber as Vehicalnumber,
    customer as Customer,
    supplier as Supplier,
    deletionind as Deletionind,
    deletedby as Deletedby,
    approvalstatus as Approvalstatus,
    approvedby as Approvedby,
    createdby as Createdby,
    createdon as Createdon,
    createdat,
    changedby,
    changedon,
    changetime,
    item
}

//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
//@AbapCatalog.buffering.status: #NOT_ALLOWED
//@AbapCatalog.sqlViewName: 'ITXTOBJPLNLTXT'
//@AccessControl.authorizationCheck: #PRIVILEGED_ONLY
////@ClientHandling.algorithm: #SESSION_VARIABLE
//@ObjectModel.usageType.serviceQuality: #A
//@ObjectModel.usageType.dataClass: #MIXED
//@ObjectModel.usageType.sizeCategory: #XL
//@ObjectModel.dataCategory: #TEXT
//@ObjectModel.representativeKey: 'TextObjectKey'
//@VDM.viewType: #BASIC
//@EndUserText.label: 'Replicated Plain Longtext(SAPScript)'
define view entity znote2 as select from  
I_PurchaseOrderItemAPI01       as PurchaseOrderItem
//    inner join   
//    itxtobjplnltxt  as PurchaseOrderText 
//    on PurchaseOrderItem.PurchaseOrderItemUniqueID = PurchaseOrderText.textobjecttype
//  association [1..*] to I_TextObjectPlainLongText as _TextObjectPlainLongText on  _TextObjectPlainLongText.TextObjectKey      = $projection.PurchaseOrderItemUniqueID
//                                                                              and _TextObjectPlainLongText.TextObjectCategory = 'EKPO'
{

  key PurchaseOrderItem.PurchaseOrder,
  key PurchaseOrderItem.PurchaseOrderItem,
@EndUserText: {label: 'Long Text'}
//@ObjectModel.readOnly: true
//@ObjectModel.virtualElement: true
@ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_TEXT'
  cast( '' as abap.char( 1099 )) as longtext
//  key PurchaseOrderText.textobjecttype,
//  key PurchaseOrderText.language 
//      PurchaseOrderItem.PurchaseOrderItemUniqueID,
//      PurchaseOrderText.longtext
//      PurchaseOrderText.Lan as textlan
      
//      _TextObjectPlainLongText

}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order'
define root view entity zpurchaseorder as select from I_PurchaseOrderAPI01
//composition of target_data_source_name as _association_name
{
    key PurchaseOrder,
    key _PurchaseOrderItem.PurchaseOrderItem,
    PurchaseOrderType,
    _PurchaseOrderItem.Material,
    Supplier,
    CreatedByUser,
    CreationDate,
    PurchaseOrderDate,
    CompanyCode,
    PurchasingOrganization,
    PurchasingGroup,
    PaymentTerms,
    _PurchaseOrderItem.MaterialGroup,
    _PurchaseOrderItem.Plant,
    _PurchaseOrderItem.StorageLocation,
//    _PurchaseOrderItem.NetPriceQuantity,

    _PurchaseOrderItem.OrderQuantity,
    _PurchaseOrderItem.PurchaseOrderQuantityUnit,
    _PurchaseOrderItem.NetAmount,
    _PurchaseOrderItem.DocumentCurrency
    
}

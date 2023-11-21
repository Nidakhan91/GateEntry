@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Doc CDS'
define root view entity zmaterialdoc as select from I_MaterialDocumentItem_2 as a 
left outer join I_Product as b on a.Material = b.Product
left outer join I_ProductDescription as d on a.Material = d.Product and d.Language = 'E'
inner join zadmin as c on a.GoodsMovementType = c.fieldvalue and c.fieldkey = 'MOVE'

//composition of target_data_source_name as _association_name
{
key a.MaterialDocument,
key a.MaterialDocumentItem,
key a.MaterialDocumentYear,
a.Material,
//a.MaterialDocumentItemText,
d.ProductDescription as MaterialDocumentItemText,
b.ProductType as materialtype,
a.Plant,
a.EntryUnit,
@Semantics.quantity.unitOfMeasure:'EntryUnit' 
a.QuantityInBaseUnit as quantity,
a.GoodsMovementType,
a.Supplier,
a._Supplier.SupplierName,
a._Supplier.SupplierAccountGroup

    
//    _association_name // Make association public
} where a.ReversedMaterialDocument = ' '

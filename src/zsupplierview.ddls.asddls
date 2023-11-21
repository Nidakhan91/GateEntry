@EndUserText.label: 'Supplier View'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity zsupplierview as select  from I_Supplier as vh
//inner join i_supplier as b on vh.supplier = b.supplier
{
   key vh.Supplier,
   vh.SupplierAccountGroup,
   vh.SupplierName,
   vh._AddressRepresentation.CityName
   
} //where vh.SupplierAccountGroup <> 'ZFAR' or vh.SupplierAccountGroup <> 'ZTRD'

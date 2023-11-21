@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Delivry Gross'
define root view entity zdeliverygross as select from I_OutboundDelivery as a 
left outer join I_Customer as b on a.SoldToParty = b.Customer
left outer join I_Customer as c on a.ShipToParty = c.Customer

left outer join I_Supplier as d on b.Supplier = d.Supplier
left outer join I_Supplier as e on c.Supplier = e.Supplier
//composition of target_data_source_name as _association_name
{
    key a.OutboundDelivery,
    a.DeliveryDocumentType,
    a._Item.Plant,
    a.HeaderGrossWeight,
    a.HeaderWeightUnit,
    a.HeaderNetWeight,
    case when a.SoldToParty <> '' then b.Customer
    when a.ShipToParty <> '' then c.Customer end as customer,
    case when a.SoldToParty <> '' then b.CustomerName
    when a.ShipToParty <> '' then c.CustomerName end as customerName,
    case when a.SoldToParty <> '' then b.CustomerAccountGroup
    when a.ShipToParty <> '' then c.CustomerAccountGroup end as  CustomerAccountGroup,
    case when a.SoldToParty <> '' then b.Supplier
    when a.ShipToParty <> '' then c.Supplier end as supplier,
    case when a.SoldToParty <> '' then d.SupplierName
    when a.ShipToParty <> '' then e.SupplierName end as supplierName,
    case when a.SoldToParty <> '' then b._CorrespondingSupplier.SupplierAccountGroup
    when a.ShipToParty <> '' then c._CorrespondingSupplier.SupplierAccountGroup end as supplieraccountgroup
    
    
//    _association_name // Make association public
}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Delivery API'
define root view entity zdelivery as select distinct from I_DeliveryDocumentItem as b
inner join I_DeliveryDocument as a on a.DeliveryDocument = b.DeliveryDocument
left outer join I_Customer as c on a.SoldToParty = c.Customer
left outer join I_Customer as d on a.ShipToParty = d.Customer
left outer join I_Supplier as e on c.Supplier = e.Supplier
left outer join I_Supplier as f on d.Supplier = f.Supplier
//composition of target_data_source_name as _association_name
{
    key a.DeliveryDocument,
    a.DeliveryDocumentType,
    a.HeaderGrossWeight,
    a.HeaderNetWeight,
    a.HeaderWeightUnit,
    case when a.SoldToParty <> ' ' then ltrim( a.SoldToParty,'0')
    when a.ShipToParty <> ' ' then ltrim( a.ShipToParty,'0')
    else '' end as customercode,
    case when a.SoldToParty <> ' ' then c.CustomerAccountGroup
    when a.ShipToParty <> ' ' then d.CustomerAccountGroup
    else '' end as accountgroup,
    case when a.SoldToParty <> ' ' then c.CustomerName
    when a.ShipToParty <> ' ' then d.CustomerName
    else '' end as customername,
    b.Plant,
    case when a.SoldToParty <> ' ' then c.Supplier
    when a.ShipToParty <> ' ' then d.Supplier
    else '' end as Supplier, 
    case when c.Supplier <> ' ' then e.SupplierAccountGroup
    when d.Supplier <> ' ' then f.SupplierAccountGroup
    else '' end as Supplieraccountgroup 
    
//    _association_name // Make association public
}

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Billing Doc API'
define root view entity zbillingdocapi as select from I_BillingDocument as a 
left outer join I_Customer as b on a.SoldToParty = b.Customer 
left outer join I_Supplier as c on b.Supplier = c.Supplier 
//left outer join i_supplier as c on a.s
//composition of target_data_source_name as _association_name
{
  key a.BillingDocument,
  a.BillingDocumentType,
  b.Supplier,
  c.SupplierAccountGroup,
  c.SupplierName
  
    //_association_name // Make association public
} where a.BillingDocumentType = 'JSN'
 
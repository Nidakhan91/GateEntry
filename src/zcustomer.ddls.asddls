@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer'
define root view entity zcustomer as select from I_Customer
//composition of target_data_source_name as _association_name
{
    key Customer,
    CustomerName,
    CustomerAccountGroup,
    _AddressRepresentation.CityName
//    _association_name // Make association public
}

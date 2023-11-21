@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Type'
define root view entity zcustomertype as select from I_Customer
//composition of target_data_source_name as _association_name
{
    key Customer,
    CustomerName,
    CustomerAccountGroup
//    _association_name // Make association public
}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Delivery API'
define root view entity Zdeliverydoc as select distinct from I_DeliveryDocument
//composition of target_data_source_name as _association_name
{

key DeliveryDocument,
SoldToParty    
//    _association_name // Make association public
}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'clientauth'
define root view entity zclientauth_cds as select from zclientauth
//composition of target_data_source_name as _association_name
{
   key clientid,
   key hostname,
   granttype,
   clientsecreate 
   
}

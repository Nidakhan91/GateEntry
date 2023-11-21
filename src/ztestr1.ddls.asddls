@AbapCatalog.sqlViewName: 'ZTESTR11'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'test'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view Ztestr1 as select from zbilling
{
    key billing_type
}

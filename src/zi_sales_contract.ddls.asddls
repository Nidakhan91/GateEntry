@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View For Sales Contract'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_Sales_Contract
  as select from I_SalesContract as SalesContract
  association [0..1] to I_Customer as Customer on SalesContract.SoldToParty = Customer.Customer
{
  key SalesContract.SalesContract                  as SalesContract,
  key Customer.Customer                            as Customer,
      SalesContract.SoldToParty                    as SoldToParty,
      Customer.CustomerName                        as CustomerName,
      SalesContract.CreationDate                   as CreationDate,
      SalesContract.SalesContractValidityStartDate as SalesContractValidityStartDate,
      SalesContract.SalesContractValidityEndDate   as SalesContractValidityEndDate
}

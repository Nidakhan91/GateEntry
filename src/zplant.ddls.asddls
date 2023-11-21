@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PLant'
define root view entity zplant as select from I_Plant
//composition of target_data_source_name as _association_name
{
    key Plant,
    PlantName
//    ValuationArea,
//    PlantCustomer,
//    PlantSupplier,
//    FactoryCalendar,
//    DefaultPurchasingOrganization,
//    SalesOrganization,
//    AddressID,
//    PlantCategory,
//    DistributionChannel,
//    Division,
//    Language,
//    IsMarkedForArchiving,
//    /* Associations */
//    _Address,
//    _Customer,
//    _MRPArea,
//    _OrganizationAddress,
//    _PlantCategoryText,
//    _ResponsiblePurchaseOrg,
//    _Supplier,
//    _ValuationArea,
//    _association_name // Make association public
}

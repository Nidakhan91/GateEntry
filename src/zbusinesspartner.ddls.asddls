@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Partner Grouping'
define root view entity zbusinesspartner as select from I_BusinessPartnerGrouping
//composition of target_data_source_name as _association_name
{
    key BusinessPartnerGrouping,
    _Text[ Language = 'E' ].BusinessPartnerGroupingText
//    _association_name // Make association public
}

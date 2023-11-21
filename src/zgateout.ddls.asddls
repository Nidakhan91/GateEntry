@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gate Out'
define root view entity zgateout as select from zgateoutwardcds
//composition of target_data_source_name as _association_name
{
    key Gateentrynumber,
    key Gateentrydate,
    key Plant,
    Customer,
    Deliverydocument
//    Customertype,
//    Customername,
//    suppliertype,
//    suppliercode,
//    suppliername,
//    Vehicaltype,
//    Vehicalno,
//    Deliverydocumentgrosswt,
//    Tarewt,
//    Weightdate,
//    Weighttime,
//    Grosswt,
//    Netwt,
//    Remark,
//    Transporter,
//    entrytype,
//    isclosed,
//    closedate,
//    closetime,
//    cancelledind,
//    cancelledby,
//    cancelledon,
//    cancelledtime,
//    entrytime,
//    createdby,
//    _association_name // Make association public
}

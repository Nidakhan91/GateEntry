@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RGP/NRGP Report'
//@ObjectModel.virtualElementCalculatedBy: 'ABAP:<Z_CLASS>'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zrnrgpreport
  as select from    zrnrgpheader as head
    inner join      zrnrgpitem   as item on  head.gatepasstype   = item.gatepasstype
                                         and head.gatepassnumber = item.gatepassnumber
                                         and head.gatepassyear   = item.gatepassyear
                                         and head.plant          = item.plant

  //{ ObjectModel.virtualElementCalculatedBy :  }
    left outer join I_Customer   as cust on head.customer = ltrim(
      cust.Customer, '0'
    )
    left outer join I_Supplier   as supp on head.supplier = ltrim(
      supp.Supplier, '0'
    )
{
  key head.gatepasstype     as Gatepasstype,
  key head.gatepassnumber   as Gatepassnumber,
  key head.gatepassyear     as Gatepassyear,
  key head.plant            as Plant,
  key item.lineitem         as Lineitem,
      head.requester        as Requester,
      head.valueininr       as Valueininr,
      head.remark           as Remark,
      head.transportmode    as Transportmode,
      head.vehicalnumber    as Vehicalnumber,
      head.customer         as Customer,
      cust.CustomerFullName as customer_name,
      head.supplier         as Supplier,
      supp.SupplierFullName as supp_name,


      item.material         as Material,
      item.materialdesc     as Materialdesc,
      item.qty              as Qty,
      item.recqty           as recqty,
      item.remqty           as remqty,
      item.unit             as Unit,
      item.duedate          as Duedate,
      item.value            as Value,
      item.remark           as itemRemark,

      head.deletionind      as Deletionind,
      head.deletedby        as Deletedby,
      head.approvalstatus   as Approvalstatus,
      head.approvedby       as Approvedby,
      head.createdby        as Createdby,
      head.createdon        as Createdon,
      head.createdat,
      //concat( substring( head.createdat,1,2 ) ,concat( ':',concat( substring( head.createdat,2,2 ),concat( ':' ,substring( head.createdat,4,2 ) ) ) ) )  as createdat,
      
      head.changedby        as changedby,
      head.changedon        as changedon,
      head.changetime       as changetime


}

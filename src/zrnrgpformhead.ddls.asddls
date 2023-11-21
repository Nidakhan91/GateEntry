@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Form Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zrnrgpformhead as select from zrnrgpheader as head
inner join zrnrgpitem as item on 
head.gatepasstype = item.gatepasstype and 
head.gatepassnumber = item.gatepassnumber and 
head.gatepassyear = item.gatepassyear and 
head.plant = item.plant

left outer join I_Supplier as supp on head.supplier = ltrim( supp.Supplier ,'0' )
left outer join I_Customer as cust on head.customer = ltrim( cust.Customer ,'0' )

left outer join I_Plant as plant on head.plant = plant.Plant
{
    key head.gatepasstype as Gatepasstype,
    key head.gatepassnumber as Gatepassnumber,
    key head.gatepassyear as Gatepassyear,
    key head.plant as Plant,
    plant._OrganizationAddress.Building,
    plant._OrganizationAddress.StreetName,
    plant._OrganizationAddress.CityName,
    plant._OrganizationAddress.Region,
    
    plant._OrganizationAddress.Country as plant_country,
    head.purchasematerialdoc as Purchasematerialdoc,
    head.requester as Requester,
    head.valueininr as Valueininr,
    head.remark as Remark,
    head.transportmode as Transportmode,
    head.vehicalnumber as Vehicalnumber,
    head.customer as Customer,
    cust.CustomerName as cust_name,
    cust._AddressRepresentation.Street,
    cust._AddressRepresentation.CityName as cust_city,
    cust._AddressRepresentation.Region as cust_region,
    cust._AddressRepresentation.Country as cust_country,
    cust._AddressRepresentation.PostalCode as cust_post,
    head.supplier as Supplier,
    supp.SupplierName as supp_name,
    supp._AddressRepresentation.Street as supp_street,
    supp._AddressRepresentation.CityName as supp_city,
    supp._AddressRepresentation.Region as supp_region,
    supp._AddressRepresentation.Country as supp_country,
    supp._AddressRepresentation.PostalCode as supp_post,
    
    item.material as Material,
    item.materialdesc as Materialdesc,
    item.qty as Qty,
    item.recqty as recqty,
    item.remqty as remqty,
    item.unit as Unit,
    item.duedate as Duedate,
    item.value as Value,
    item.remark as itemRemark,
//    supp.
    head.deletionind as Deletionind,
    head.deletedby as Deletedby,
    head.approvalstatus as Approvalstatus,
    head.approvedby as Approvedby,
    head.createdby as Createdby,
    head.createdon as Createdon
}

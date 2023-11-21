//@AbapCatalog.sqlViewName: 'ZVT1'
//@AbapCatalog.compiler.compareFilter: true
////@AbapCatalog.preserveKey: true
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Transporter and Vehicle CDS'
//@ObjectModel.query.implementedBy: c

//@ObjectModel.v: true
//@ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_TEXT'
//
define root view entity zvehicletransporter as select distinct from I_SalesOrderItmSubsqntProcFlow as a inner join
I_SalesOrderPartner as b on a.SalesOrder = b.SalesOrder and a.SubsequentDocumentCategory = 'J' and b.PartnerFunction = 'U3' 
and a.SalesOrderItem = '000010' 
left outer join I_Supplier as c on b.Supplier = c.Supplier
//left outer join  I_OutboundDeliveryTextTP as d on d.Language = 'E' and d.OutboundDelivery = a.SubsequentDocument
//and d.LongTextID = 'JGVN' 
//left outer join 
{
 key a.SubsequentDocument as deliverydoc,
 b.Supplier as transporter,
 c.SupplierName as stransportername

//  @ObjectModel.virtualElement: true
//  @ObjectModel
//  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_TEXT'
//cast('' as abap.char(20) ) as vehicleno,
//d.LongText as vehicleno   
}

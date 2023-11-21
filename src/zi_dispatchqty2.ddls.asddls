@AbapCatalog.sqlViewName: 'ZI_DISPATCHQNTY2'
//@AbapCatalog.sqlViewName: 'ZTEST'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sub CDS for Dispatch Quantity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view ZI_DISPATCHQTY2 as select from I_SalesOrderItmPrecdgProcFlow as Procflow //SLSORDRITMPRCDG
//////association [1] to I_SalesOrderItem  as SalesOrdItm on SLSORDRITMPRCDG.SalesOrder = SalesOrdItm.SalesOrder and
//////                                                       SLSORDRITMPRCDG.SalesOrderItem = SalesOrdItm.SalesOrderItem
//////{
//////    key SalesOrdItm.SalesOrder as SalesOrder,
//////    key SalesOrdItm.SalesOrderItem as SalesOrderItem,
//////    SalesOrdItm.OrderQuantity as OrderQuantity
//////    
//////}
//define view entity Ztest as select from I_SalesOrderItmPrecdgProcFlow as Procflow
association [0..1] to I_SalesOrderItem as Sales
on Sales.ReferenceSDDocument = Procflow.PrecedingDocument
and Sales.SalesOrder <= Procflow.SalesOrder
and Sales.SalesOrderItem = Procflow.SalesOrderItem
{
key Procflow.PrecedingDocument,
key Procflow.SalesOrder,
    Procflow.SalesOrderItem,
    
    sum(Sales.OrderQuantity) as Dispatched_Quantity

    
}//where Procflow.PrecedingDocument = '0030000025' and Procflow.SalesOrder = '0050000101'
group by Procflow.SalesOrder, Procflow.SalesOrderItem, Procflow.PrecedingDocument

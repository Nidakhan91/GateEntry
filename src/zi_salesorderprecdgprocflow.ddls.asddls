//@AbapCatalog.sqlViewName: 'ZZI_SALEORDFLOW'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View for Sales Ord Proc FLow'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_SALESORDERPRECDGPROCFLOW
  as select from I_SalesOrderItmPrecdgProcFlow as SalesOrdProcFlow
  association [1] to ZI_Sales_Contract   as _SalesContract     on  SalesOrdProcFlow.PrecedingDocument         = _SalesContract.SalesContract
                                                               and SalesOrdProcFlow.PrecedingDocumentCategory = 'G'
  association [1] to I_SalesContractItem as _SALESCONTRACTITEM on  SalesOrdProcFlow.PrecedingDocument         = _SALESCONTRACTITEM.SalesContract
                                                               and SalesOrdProcFlow.SalesOrderItem            = _SALESCONTRACTITEM.SalesContractItem
                                                               and SalesOrdProcFlow.PrecedingDocumentCategory = 'G'
{
  key SalesOrdProcFlow.SalesOrder                   as SalesOrder,
  key _SalesContract.SalesContract                  as SalesContract,
  key _SALESCONTRACTITEM.SalesContractItem          as ISalesContractItem,
      SalesOrdProcFlow.PrecedingDocumentCategory    as PrecedingDocumentCategory,
      SalesOrdProcFlow.PrecedingDocument            as PrecedingDocument,
      _SalesContract.SoldToParty                    as SoldToParty,
      _SalesContract.CustomerName                   as CustomerName,
      _SalesContract.CreationDate                   as CreationDate,
      @Semantics.quantity.unitOfMeasure: 'RequestedQuantityUnit'
      _SALESCONTRACTITEM.RequestedQuantity          as RequestedQuantity,
      _SALESCONTRACTITEM.RequestedQuantityUnit      as RequestedQuantityUnit,
      _SalesContract.SalesContractValidityStartDate as SalesContractValidityStartDate,
      _SalesContract.SalesContractValidityEndDate   as SalesContractValidityEndDate
}

@AbapCatalog.sqlViewName: 'ZZI_TENDER_SALE1'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS for SortBilling Date in ASC'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view ZI_SALES_TENDER1
  as select from ZI_SALES_TENDER as A 
{
  A.BillingDocumentItem     as BillingDocumentItem,
  A.SalesOrder              as SalesOrder,
  A.SalesContract           as SalesContract,
  A.ISalesContractItem      as ISalesContractItem,
  A.SoldToParty             as SoldToParty,
  A.TCustomerName           as TCustomerName,
  A.Payer                   as Payer,
  A.CustomerName            as CustomerName,
  A.PrecedingDocument       as PrecedingDocument,
  A.SCreationDate           as SCreationDate,
  A.RequestedQuantity       as RequestedQuantity,
  A.RequestedQuantityUnit   as RequestedQuantityUnit,
  A.SalesDocument           as SalesDocument,
  A.SOCreationDate          as SOCreationDate,
  A.BillingDocument         as BillingDocument,
  A.BCreationDate           as BCreationDate,
  A.Product                 as Product,
  A.BillingDocumentItemText as BillingDocumentItemText,
  A.Batch                   as Batch,
  A.BillingQuantity         as BillingQuantity,
  A.ConditionRateAmount     as ConditionRateAmount,
  A.BillingQuantityTA       as BillingQuantityTA,
  A.NetAmount               as NetAmount,
  A.TaxAmount               as TaxAmount,
  A.GrossValue              as GrossValue,
  A.BalanceQty              as BalanceQty,
  A.SubsequentDocumentD     as SubsequentDocumentD,
  A.CreationDateD           as CreationDateD,
  A.SubsequentDocumentP     as SubsequentDocumentP,
  A.CreationDateP           as CreationDateP,
  A.Division                as Division,
  A.DispatchedQty           as DispatchedQty,
  A.ContractStartDate       as ContractStartDate,
  A.ContractEndDate         as ContractEndDate
}

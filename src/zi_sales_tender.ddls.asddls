@AbapCatalog.sqlViewName: 'ZI_TENDER_SALES'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Tender Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view ZI_SALES_TENDER
  as select distinct from I_BillingDocumentItemBasic  as BillingDocItem
  
    inner join            ZI_SALESORDERPRECDGPROCFLOW as SalesOrdProcFlow on  BillingDocItem.SalesDocument       = SalesOrdProcFlow.SalesOrder
                                                                          and BillingDocItem.BillingDocumentItem = SalesOrdProcFlow.ISalesContractItem
                                                                          
  association [0..1] to I_BillingDocumentBasic  as BillingDoc 
  on BillingDoc.BillingDocument = BillingDocItem.BillingDocument
  and BillingDoc.BillingDocumentIsCancelled <> 'X'
  
                                                                          
  association [1]    to ZI_BillingDocumentBasic        as BillingDocBasic      on  BillingDocItem.BillingDocument = BillingDocBasic.BillingDocument
  association [0..1] to ZI_SALESORDERPRECDGPROCFLOW    as SalesOrdProcFlow1    on  BillingDocItem.SalesDocument                = SalesOrdProcFlow1.SalesOrder
                                                                               and BillingDocItem.BillingDocumentItem          = SalesOrdProcFlow1.ISalesContractItem
                                                                               and SalesOrdProcFlow1.PrecedingDocumentCategory = 'G'
  association [0..1] to I_SalesOrder                   as SalesOrder           on  BillingDocItem.SalesDocument = SalesOrder.SalesOrder
  association [0..1] to I_BillingDocItemPrcgElmntBasic as BillingDocElemBasic  on  BillingDocItem.BillingDocument          =  BillingDocElemBasic.BillingDocument
                                                                               and BillingDocElemBasic.ConditionType       =  'PPR0'
                                                                               and BillingDocElemBasic.ConditionRateAmount <> 0.00
  //  association [0..1] to I_BillingDocumentItemPrcgElmnt as BillDocItemPrcgElem  on  BillingDocItem.BillingDocument     = BillDocItemPrcgElem.BillingDocument
  //                                                                               and BillingDocItem.BillingDocumentItem = BillDocItemPrcgElem.BillingDocumentItem
  //                                                                               and BillDocItemPrcgElem.ConditionType  = 'JOIG'
  //   association [0..1] to I_BillingDocumentItemPrcgElmnt as BillDocItemPrcgElem1  on  BillingDocItem.BillingDocument     = BillDocItemPrcgElem1.BillingDocument
  //                                                                               and BillingDocItem.BillingDocumentItem = BillDocItemPrcgElem1.BillingDocumentItem
  //                                                                               and  BillDocItemPrcgElem1.ConditionType  = 'JOCG'
  //   association [0..1] to I_BillingDocumentItemPrcgElmnt as BillDocItemPrcgElem2  on  BillingDocItem.BillingDocument     = BillDocItemPrcgElem2.BillingDocument
  //                                                                               and BillingDocItem.BillingDocumentItem = BillDocItemPrcgElem2.BillingDocumentItem
  //                                                                               and BillDocItemPrcgElem2.ConditionType  = 'JOSG'
  association [0..1] to ZI_SALESORDERITMSUBSQNTPROCFLW as SalesOrdItmSubsqFlw  on  BillingDocItem.SalesDocument                   = SalesOrdItmSubsqFlw.SalesOrder
                                                                               and BillingDocItem.BillingDocumentItem             = SalesOrdItmSubsqFlw.SubsequentDocumentItem
                                                                               and SalesOrdItmSubsqFlw.SubsequentDocumentCategory = 'J'
  association [0..1] to ZI_SALESORDERITMSUBSQNTPROCFLW as SalesOrdItmSubsqFlw1 on  BillingDocItem.SalesDocument                    = SalesOrdItmSubsqFlw1.SalesOrder
                                                                               and BillingDocItem.BillingDocumentItem              = SalesOrdItmSubsqFlw1.SubsequentDocumentItem
                                                                               and SalesOrdItmSubsqFlw1.SubsequentDocumentCategory = 'U'
  association [0..1] to I_SalesOrderItmSubsqntProcFlow as SalesOrdItmSubsqFlw2 on  BillingDocItem.SalesDocument                    = SalesOrdItmSubsqFlw2.SalesOrder
                                                                               and BillingDocItem.BillingDocumentItem              = SalesOrdItmSubsqFlw2.SubsequentDocumentItem
                                                                               and SalesOrdItmSubsqFlw2.SubsequentDocumentCategory = 'M'
  association [0..1] to ZI_DISPATCHQTY2                as Dispatch             on  Dispatch.SalesOrder     = BillingDocItem.SalesDocument
                                                                               and Dispatch.SalesOrderItem = BillingDocItem.SalesDocumentItem
{
      //    key BillingDocItem.BillingDocument as BillingDocument,
  key BillingDocItem.BillingDocumentItem                                               as BillingDocumentItem,
  key  SalesOrdProcFlow.SalesOrder                                                      as SalesOrder,
   SalesOrdProcFlow.SalesContract                                                   as SalesContract,
    //SalesOrdItmSubsqFlw.SubsequentDocument                                           as SubsequentDocumentD,
//  SalesOrdProcFlow.SalesOrder                                                      as SalesOrder,
     
      SalesOrdProcFlow.ISalesContractItem                                              as ISalesContractItem,
      SalesOrdProcFlow.SoldToParty                                                     as SoldToParty,
      SalesOrdProcFlow.CustomerName                                                    as TCustomerName,
      BillingDocBasic.PayerParty                                                       as Payer,
      BillingDocBasic.CustomerName                                                     as CustomerName,
      SalesOrdProcFlow1.PrecedingDocument                                              as PrecedingDocument,
      SalesOrdProcFlow.CreationDate                                                    as SCreationDate,
      @Semantics.quantity.unitOfMeasure: 'RequestedQuantityUnit'
      floor(SalesOrdProcFlow.RequestedQuantity )                                       as RequestedQuantity,
      SalesOrdProcFlow.RequestedQuantityUnit                                           as RequestedQuantityUnit,
      BillingDocItem.SalesDocument                                                     as SalesDocument,
      SalesOrder.CreationDate                                                          as SOCreationDate,
//      SalesOrdItmSubsqFlw2.SubsequentDocument                                          as BillingDocument,
      BillingDocItem.BillingDocument                                                   as BillingDocument, 
      BillingDocItem.CreationDate                                                      as BCreationDate,
      BillingDocItem.Product                                                           as Product,
      BillingDocItem.BillingDocumentItemText                                           as BillingDocumentItemText,
      BillingDocItem.Batch                                                             as Batch,
      floor(BillingDocItem.BillingQuantity)                                            as BillingQuantity,
      cast((BillingDocElemBasic.ConditionRateAmount) as abap.dec( 15, 2 ))             as ConditionRateAmount,
      case BillingDocItem.SalesDocumentItemCategory
      when  'TANN'
            then floor(BillingDocItem.BillingQuantity) end                             as BillingQuantityTA,
      cast((BillingDocItem.NetAmount) as abap.dec( 15, 2 ))                            as NetAmount,
      BillingDocItem.TaxAmount                                                         as TaxAmount,
      cast((BillingDocItem.NetAmount + BillingDocItem.TaxAmount) as abap.dec( 15, 2 )) as GrossValue,
      floor(SalesOrdProcFlow.RequestedQuantity - Dispatch.Dispatched_Quantity)         as BalanceQty,
     SalesOrdItmSubsqFlw.SubsequentDocument                                           as SubsequentDocumentD,
      SalesOrdItmSubsqFlw.CreationDateD                                                as CreationDateD,
      SalesOrdItmSubsqFlw1.SubsequentDocument                                          as SubsequentDocumentP,
      SalesOrdItmSubsqFlw1.CreationDateP                                               as CreationDateP,
      BillingDocItem.Division                                                          as Division,
      Dispatch.Dispatched_Quantity                                                     as DispatchedQty,
      SalesOrdProcFlow.SalesContractValidityStartDate                                  as ContractStartDate,
      SalesOrdProcFlow.SalesContractValidityEndDate                                    as ContractEndDate

}
where
      BillingDocItem.BillingQuantity           <> 0
  and BillingDocItem.SalesDocumentItemCategory =  'TAN'
  and BillingDocItem.TaxAmount                 <> 0
  and BillingDocItem.ReturnItemProcessingType <> 'X'
  and BillingDoc.BillingDocumentIsCancelled   <> 'X'
  and BillingDoc.SDDocumentCategory = 'M'

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View for Subsequent FLow'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_SALESORDERITMSUBSQNTPROCFLW as select from I_SalesOrderItmSubsqntProcFlow as SalesOrdItmSubsqFlw
association [1] to I_DeliveryDocument as DelDoc on SalesOrdItmSubsqFlw.SubsequentDocument = DelDoc.DeliveryDocument
association [0..1] to I_BillingDocumentBasic as BillDocBas on SalesOrdItmSubsqFlw.SubsequentDocument = BillDocBas.BillingDocument
{
    key SalesOrdItmSubsqFlw.SalesOrder as SalesOrder,
    key SalesOrdItmSubsqFlw.SalesOrderItem as SalesOrderItem,
        SalesOrdItmSubsqFlw.SubsequentDocument as SubsequentDocument,
        SalesOrdItmSubsqFlw.SubsequentDocumentItem as SubsequentDocumentItem,
        SalesOrdItmSubsqFlw.SubsequentDocumentCategory as SubsequentDocumentCategory,
        DelDoc.CreationDate as CreationDateD,
        BillDocBas.CreationDate as CreationDateP
}

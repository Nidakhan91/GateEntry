@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View for PO Details'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_PO_MASTER
  as select from I_SuplrInvcItemPurOrdRefAPI01 as SupplierInvoicePORef
  association [0..1] to I_PurchaseOrderAPI01           as POAPI01        on  SupplierInvoicePORef.PurchaseOrder = POAPI01.PurchaseOrder
  association [1]    to I_PurchaseOrderItemAPI01       as POItemAPI01    on  SupplierInvoicePORef.PurchaseOrder     = POItemAPI01.PurchaseOrder
                                                                         and SupplierInvoicePORef.PurchaseOrderItem = POItemAPI01.PurchaseOrderItem
  association [0..1] to I_ProductPlantIntlTrd          as ProductPlant   on  SupplierInvoicePORef.PurchaseOrderItemMaterial = ProductPlant.Product
  association [0..1] to I_PurOrdItmPricingElementAPI01 as POItemPricing  on  SupplierInvoicePORef.PurchaseOrder     = POItemPricing.PurchaseOrder
                                                                         and SupplierInvoicePORef.PurchaseOrderItem = POItemPricing.PurchaseOrderItem
                                                                         and POItemPricing.ConditionType            = 'PMP0'
                                                                         or  POItemPricing.ConditionType            = 'PPR0'
  association [0..1] to I_PurOrdItmPricingElementAPI01 as POItemPricing1 on  SupplierInvoicePORef.PurchaseOrder     = POItemPricing1.PurchaseOrder
                                                                         and SupplierInvoicePORef.PurchaseOrderItem = POItemPricing1.PurchaseOrderItem
                                                                         and POItemPricing1.ConditionType           = 'DL01'
  association [0..1] to I_PurOrdItmPricingElementAPI01 as POItemPricing2 on  SupplierInvoicePORef.PurchaseOrder     = POItemPricing2.PurchaseOrder
                                                                         and SupplierInvoicePORef.PurchaseOrderItem = POItemPricing2.PurchaseOrderItem
                                                                         and POItemPricing2.ConditionType           = 'ZCES'
  association [0..1] to ZI_JOURNALENTRYITEM1           as JournalItem    on  JournalItem.ReferenceDocumentMIRO = SupplierInvoicePORef.SupplierInvoice
                                                                         and JournalItem.ReferenceDocumentItem = SupplierInvoicePORef.SupplierInvoiceItem
                                                                         and JournalItem.FiscalYear            = SupplierInvoicePORef.FiscalYear
{
  key SupplierInvoicePORef.SupplierInvoice             as SupplierInvoice,
  key SupplierInvoicePORef.SupplierInvoiceItem         as SupplierInvoiceItem,
  key SupplierInvoicePORef.PurchaseOrder               as PurchaseOrder,
  key SupplierInvoicePORef.FiscalYear                  as FiscalYear,
  key SupplierInvoicePORef.PurchaseOrderItem           as PurchaseOrderItem,
  key SupplierInvoicePORef.PurchaseOrderItemMaterial   as PurchaseOrderItemMaterial,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      SupplierInvoicePORef.QuantityInPurchaseOrderUnit as QuantityInPurchaseOrderUnit,
      POAPI01.PurchasingGroup                          as PurchasingGroup,
      POItemAPI01.PurchaseOrderItemText                as PurchaseOrderItemText,
      POItemAPI01.BaseUnit                             as BaseUnit,
      ProductPlant.ConsumptionTaxCtrlCode              as ConsumptionTaxCtrlCode,
      POAPI01.PurchaseOrderDate                        as PurchaseOrderDate,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      POItemAPI01.OrderQuantity                        as OrderQuantity,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      POItemAPI01.NetPriceAmount                       as NetPriceAmount,
      SupplierInvoicePORef.DocumentCurrency            as DocumentCurrency,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      SupplierInvoicePORef.SupplierInvoiceItemAmount   as SupplierInvoiceItemAmount,
      @Semantics.amount.currencyCode: 'DocumentCurrency'
      POItemPricing.ConditionAmount                    as ConditionAmount,
      POItemPricing1.ConditionRateValue                as ConditionRateValue,
      SupplierInvoicePORef.TaxCode                     as TaxCode,
      POItemPricing2.ConditionRateValue                as ConditionRateValueC,
      SupplierInvoicePORef.ReferenceDocument           as ReferenceDocument,
      case
      when JournalItem.TaxCode = 'G2' or JournalItem.TaxCode = 'H1'
       then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.025)
      when JournalItem.TaxCode = 'G3' or JournalItem.TaxCode = 'H2'
       then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.06)
      when JournalItem.TaxCode = 'G4' or JournalItem.TaxCode = 'H3'
       then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.09)
      when JournalItem.TaxCode = 'G5' or JournalItem.TaxCode = 'H4'
       then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.14)
        end                                  as SGST,
      case
      when JournalItem.TaxCode = 'G2' or JournalItem.TaxCode = 'H1'
      then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.025)
      when JournalItem.TaxCode = 'G3' or JournalItem.TaxCode = 'H2'
      then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.06)
      when JournalItem.TaxCode = 'G4' or JournalItem.TaxCode = 'H3'
      then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.09)
      when JournalItem.TaxCode = 'G5' or JournalItem.TaxCode = 'H4'
      then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.14)
       end                                   as CGST,
      case
      when JournalItem.TaxCode = 'G6' or JournalItem.TaxCode = 'H5'
       then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.05)
      when JournalItem.TaxCode = 'G7' or JournalItem.TaxCode = 'H6'
       then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.12)
      when JournalItem.TaxCode = 'G8' or JournalItem.TaxCode = 'H7'
       then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.18)
      when JournalItem.TaxCode = 'G9' or JournalItem.TaxCode = 'H8'
       then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.18)
        end                                  as IGST,

      case
      when JournalItem.TaxCode = 'J1'
       then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.025)
      when JournalItem.TaxCode = 'J2'
       then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.06)
      when JournalItem.TaxCode = 'J3'
       then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.09)
      when JournalItem.TaxCode = 'J4'
       then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.14)
        end                                  as RSGST,
      case
      when JournalItem.TaxCode = 'J1'
      then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.025)
      when JournalItem.TaxCode = 'J2'
      then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.06)
      when JournalItem.TaxCode = 'J3'
      then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.09)
      when JournalItem.TaxCode = 'J4'
      then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.14)
       end                                   as RCGST,
      case
      when JournalItem.TaxCode = 'J5'
       then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.05)
      when JournalItem.TaxCode = 'J6'
       then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.12)
      when JournalItem.TaxCode = 'J7' or JournalItem.TaxCode = 'H7'
       then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.18)
      when JournalItem.TaxCode = 'J8'
       then (cast(SupplierInvoicePORef.SupplierInvoiceItemAmount as abap.fltp)*0.18)
        end                                  as RIGST

}

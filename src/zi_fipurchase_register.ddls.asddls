//@AbapCatalog.sqlViewName: 'ZI_FIPURCH_REG'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS for FI Purchase Register'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_FIPURCHASE_REGISTER
  //define view  ZI_FIPURCHASE_REGISTER
  as select from ZI_FI_JOURNALENTRYITEM1 as JournalItem
  association [0..1] to ZI_VENDOR_MASTER               as VendorDetails   on  JournalItem.OffsettingAccount = VendorDetails.Supplier
                                                                          and VendorDetails.Langauage       = 'E'
                                                                          and VendorDetails.Country         = 'IN'
  association [0..1] to ZI_PO_MASTER                   as PO_Master       on  JournalItem.ReferenceDocumentMIRO = PO_Master.SupplierInvoice
                                                                          and JournalItem.ReferenceDocumentItem = PO_Master.SupplierInvoiceItem
                                                                          and JournalItem.FiscalYear            = PO_Master.FiscalYear
  association [0..1] to I_SupplierInvoiceAPI01         as SupplierInvoice on  SupplierInvoice.SupplierInvoice = JournalItem.ReferenceDocumentMIRO
                                                                          and SupplierInvoice.FiscalYear      = JournalItem.FiscalYear
  association [0..1] to I_PurOrdItmPricingElementAPI01 as POItemPricing   on  JournalItem.PurchasingDocument     = POItemPricing.PurchaseOrder
                                                                          and JournalItem.PurchasingDocumentItem = POItemPricing.PurchaseOrderItem
                                                                          and (
                                                                             POItemPricing.ConditionType         = 'PMP0'
                                                                             or POItemPricing.ConditionType      = 'PPR0'
                                                                           )
  association [0..1] to Z_Discount                     as Discount        on  JournalItem.ReferenceDocumentMIRO = Discount.ReferenceDocumentMIRO
                                                                          and JournalItem.ReferenceDocumentItem = Discount.ReferenceDocumentItem
                                                                          and JournalItem.FiscalYear            = Discount.FiscalYear
{
  key JournalItem.ReferenceDocumentMIRO  as ReferenceDocumentMIRO,
  key JournalItem.ReferenceDocumentItem  as ReferenceDocumentItem,
      //      JournalItem.PostingDate                           as PostingDate,
      //      SupplierInvoice.SupplierInvoiceIDByInvcgParty     as RefDocNo,
      //      SupplierInvoice.DocumentDate                      as InvoiceDate,
      //      JournalItem.Supplier                              as Vendor,
      //      VendorDetails.SupplierName                        as VendorName,
      //      VendorDetails.Region                              as VendorRegion,
      //      VendorDetails.RegionName                          as RegionName,
      //      VendorDetails.TaxNumber3                          as GSTIN,
      //      VendorDetails.TaxNumber2                          as TIN,
      //      PO_Master.PurchasingGroup                         as Department,
      //      case
      //        when PO_Master.PurchasingGroup = '001' then 'Group 001'
      //        when PO_Master.PurchasingGroup = '002' then 'Group 002'
      //        when PO_Master.PurchasingGroup = '003' then 'Group 003'
      //        when PO_Master.PurchasingGroup = '005' then 'Transportation Srv'
      //        when PO_Master.PurchasingGroup = '006' then 'TM – Ext. Planning'
      //        when PO_Master.PurchasingGroup = '007' then 'TM – Int. Planning'
      //        when PO_Master.PurchasingGroup = 'Z01' then 'Sales & Marketing'
      //        when PO_Master.PurchasingGroup = 'Z02' then 'Canteen Dept.'
      //        when PO_Master.PurchasingGroup = 'Z03' then 'Safety Dept.'
      //        when PO_Master.PurchasingGroup = 'Z04' then 'General Admin'
      //        when PO_Master.PurchasingGroup = 'Z05' then 'Accounts & Finance'
      //        when PO_Master.PurchasingGroup = 'Z06' then 'EDP/IT Dept.'
      //        when PO_Master.PurchasingGroup = 'Z07' then 'Store Dept.'
      //        when PO_Master.PurchasingGroup = 'Z08' then 'Purchase Dept.'
      //        when PO_Master.PurchasingGroup = 'Z09' then 'Civil Dept.'
      //        when PO_Master.PurchasingGroup = 'Z10' then 'Engineering Dept.'
      //        when PO_Master.PurchasingGroup = 'Z11' then 'Electrical Dept.'
      //        when PO_Master.PurchasingGroup = 'Z12' then 'Instrument Dept.'
      //        when PO_Master.PurchasingGroup = 'Z13' then 'Manufacturing Dept'
      //        when PO_Master.PurchasingGroup = 'Z14' then 'Sugar Godown'
      //        when PO_Master.PurchasingGroup = 'Z15' then 'Agriculture Dept.'
      //        when PO_Master.PurchasingGroup = 'Z16' then 'Cane - Yard'
      //        when PO_Master.PurchasingGroup = 'Z17' then 'Time Office Dept'
      //        when PO_Master.PurchasingGroup = 'Z18' then 'Security Dept.'
      //        when PO_Master.PurchasingGroup = 'Z19' then 'Vehicle Dept'
      //        when PO_Master.PurchasingGroup = 'Z20' then 'Distillery Dept.'
      //        when PO_Master.PurchasingGroup = 'Z21' then 'Co-gen Department'
      //        when PO_Master.PurchasingGroup = 'Z22' then 'WTP Department'
      //        when PO_Master.PurchasingGroup = 'Z23' then 'Petrol Pump'
      //        when PO_Master.PurchasingGroup = 'Z24' then 'ETP Department'
      //        when PO_Master.PurchasingGroup = 'Z25' then 'OHC / Medical Dept'
      //        when PO_Master.PurchasingGroup = 'Z26' then 'Sanitation Dept'
      //        when PO_Master.PurchasingGroup = 'Z27' then 'HR Dept.'
      //        end                                             as DepartmentDescreption,
      //      PO_Master.PurchaseOrderItemMaterial               as MaterialCode,
      //      PO_Master.PurchaseOrderItemText                   as MaterialDescription,
      //      PO_Master.BaseUnit                                as UOM,
      //      PO_Master.ConsumptionTaxCtrlCode                  as HSNCode,
      //      PO_Master.PurchaseOrderDate                       as PurchaseOrderDate,
      //      JournalItem.PurchasingDocument                    as PurchasingDocument,
      //      JournalItem.PurchasingDocumentItem                as PurchasingDocumentItem,
      //      @Semantics.quantity.unitOfMeasure: 'UOM'
      //      PO_Master.OrderQuantity                           as POrderQuantity,
      //      @Semantics.quantity.unitOfMeasure: 'UOM'
      //      PO_Master.QuantityInPurchaseOrderUnit             as QuantityInPurchaseOrderUnit,
      //      PO_Master.DocumentCurrency                        as DocumentCurrency,
      //      @Semantics.amount.currencyCode: 'DocumentCurrency'
      //      PO_Master.NetPriceAmount                          as Rate,
      //      @Semantics.amount.currencyCode: 'DocumentCurrency'
      //      POItemPricing.ConditionAmount                     as BaseAmount,
      //      case
      //        when Discount.divis < 1 then ((1-Discount.divis)*100)
      //        end                                             as Discount,
      //      PO_Master.TaxCode                                 as TaxCode,
      //      fltp_to_dec (  PO_Master.SGST as abap.dec(16,4))  as SGST,
      //      fltp_to_dec (  PO_Master.CGST as abap.dec(16,4))  as CGST,
      //      fltp_to_dec (  PO_Master.IGST as abap.dec(16,4))  as IGST,
      //      fltp_to_dec (  PO_Master.RCGST as abap.dec(16,4)) as RCGST,
      //      fltp_to_dec (  PO_Master.RSGST as abap.dec(16,4)) as RSGST,
      //      fltp_to_dec (  PO_Master.RIGST as abap.dec(16,4)) as RIGST,
      //      @Semantics.amount.currencyCode: 'DocumentCurrency'
      //      PO_Master.SupplierInvoiceItemAmount               as NetInvoiceAmount,
      JournalItem.AccountingDocument     as AccountingDocument,
      //      PO_Master.ReferenceDocument                       as ReferenceDocumentMIGO,
      //      JournalItem.FiscalYear                            as FiscalYear,
      //      JournalItem.DebitCreditCode                       as DebitCreditCode,
      JournalItem.AccountingDocumentType as AccountingDocumentType
      //      POItemPricing.ConditionRateValue                  as ConditionRateValue
}

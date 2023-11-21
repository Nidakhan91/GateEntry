@AbapCatalog.sqlViewName: 'ZIRNTESTFR'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SALES REGISTER REPORT'
@Metadata.ignorePropagatedAnnotations: true
//@Analytics.dataCategory: #CUBE
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view  ZIRN_TEST_FR as select distinct from I_BillingDocumentItemBasic as billingitem

association [0..1] to I_BillingDocumentBasic as BillingHeader
on BillingHeader.BillingDocument = billingitem.BillingDocument 
and   BillingHeader.AccountingPostingStatus = 'C'
//and ( BillingHeader.SDDocumentCategory <>  'U' or BillingHeader.SDDocumentCategory <> 'N'  
//    or BillingHeader.BillingDocumentIsCancelled <> 'X' )




association [0..1] to I_BillingDocumentTypeText as documenttype
on documenttype.BillingDocumentType = billingitem.BillingDocumentType 
and documenttype.Language = 'E'

association [0..1] to ZI_PREC_INV_NO as PrecInv
//on PrecInv.SubsequentDocument = billingitem.SalesDocument
//and billingitem.BillingDocumentItem = PrecInv.SubsequentDocumentItem
on PrecInv.BillingDocument = billingitem.BillingDocument


//association [0..1] to I_SalesOrderItmSubsqntProcFlow as itemflow
//on billingitem.SalesDocument = itemflow.SubsequentDocument 
//and billingitem.BillingDocumentItem = itemflow.SubsequentDocumentItem
//and itemflow.SubsequentDocumentCategory = 'M' 
// and
// itemflow.SubsqntDocItmPrecdgDocCategory = 'M'
   
//association [0..1] to I_BillingDocumentBasic as BillingHeader
//on BillingHeader.BillingDocument = billingitem.BillingDocument 
//and   BillingHeader.AccountingPostingStatus = 'C'
//and ( BillingHeader.SDDocumentCategory <>  'U' or BillingHeader.SDDocumentCategory <> 'N' )  
//and BillingHeader.BillingDocumentIsCancelled <> 'X'

association [0..1] to  I_DistributionChannelText as Distchannel
on Distchannel.DistributionChannel = billingitem.DistributionChannel
and Distchannel.Language = 'E'

association [0..1] to I_DivisionText as Division
on Division.Division = billingitem.Division
and Division.Language = 'E'

association [0..1] to I_BillingDocumentItemBasic as billingitem1
 on billingitem1.BillingDocument = billingitem.BillingDocument
 and billingitem1.BillingDocumentItem = billingitem.BillingDocumentItem
 //and billingitem1.BillingQuantity    not ' '
 //and billingitem1.

association [0..1] to   ZI_Customer_Details as customer
on customer.Billiing_Doc = billingitem.BillingDocument

//24,
association [0..1] to  I_SalesOrderItmPrecdgProcFlow as itemflow1
on billingitem.SalesDocument = itemflow1.SalesOrder and
billingitem.SalesDocumentItem = itemflow1.SalesOrderItem and
 itemflow1.PrecedingDocumentCategory = 'G' 

//26,27,28,29
association [0..1] to  I_SalesOrder as salesdetails
on salesdetails.SalesOrder  = billingitem.SalesDocument 


//30,31
//association [0..1] to I_SalesOrderItmSubsqntProcFlow as salesflow
// on billingitem.SalesDocument = salesflow.SalesOrder 
// and billingitem.SalesDocumentItem = salesflow.SalesOrderItem
// and salesflow.SubsequentDocumentCategory = 'J'

association [0..1] to I_DeliveryDocument as Delivery
 on Delivery.DeliveryDocument = billingitem.ReferenceSDDocument

 
 //32
 association [0..1] to  I_AdditionalMaterialGroup1Text as Mattext
 on Mattext.AdditionalMaterialGroup1 = billingitem.AdditionalMaterialGroup1
 
 //36
 association [0..1] to  I_ProductPlantBasic as HSNcode
  on HSNcode.Product = billingitem.Product and
     HSNcode.Plant   = billingitem.Plant
 
 association [0..1] to I_AdditionalCustomerGroup1Text as Custgrp
 on Custgrp.AdditionalCustomerGroup1 = billingitem.CustomerGroup
 and Custgrp.Language = 'E'
 
 
 //37,38,39,40
// association [0..1] to I_Batch as Batchdetails
//  on Batchdetails.Batch = billingitem.Batch 
association [0..1] to I_DeliveryDocumentItem as batchdetails
 on batchdetails.DeliveryDocument = billingitem.ReferenceSDDocument
 and batchdetails.HigherLvlItmOfBatSpltItm = billingitem.ReferenceSDDocumentItem
 and batchdetails.Product = billingitem.Product 
  //41,42
 // association [0..1] to 
//  
// //43,44,45,46
 association [0..1] to  I_BillingDocItemPrcgElmntBasic as Itemprcg
  on Itemprcg.BillingDocument = billingitem.BillingDocument and
     Itemprcg.BillingDocumentItem = billingitem.BillingDocumentItem and
     Itemprcg.ConditionRateAmount <> 0 and
     Itemprcg.ConditionType   = 'PPR0'
 //44    
 association [0..1] to  I_BillingDocItemPrcgElmntBasic as Itemprcg1
  on Itemprcg1.BillingDocument = billingitem.BillingDocument and
       Itemprcg1.BillingDocumentItem = billingitem.BillingDocumentItem and
     Itemprcg1.ConditionType   = 'YBHD'
 //45    
     association [0..1] to  I_BillingDocItemPrcgElmntBasic as Itemprcg2
  on Itemprcg2.BillingDocument = billingitem.BillingDocument and
       Itemprcg2.BillingDocumentItem = billingitem.BillingDocumentItem and
     Itemprcg2.ConditionType   = 'FIN1'
 //46    
     association [0..1] to  I_BillingDocItemPrcgElmntBasic as Itemprcg3
  on Itemprcg3.BillingDocument = billingitem.BillingDocument and
       Itemprcg3.BillingDocumentItem = billingitem.BillingDocumentItem and
     Itemprcg3.ConditionType   = 'FPA1'
//50-61                                                                       START  //GST Details
 association [0..1] to I_BillingDocItemPrcgElmntBasic as CGSTdetails
  on CGSTdetails.BillingDocument = billingitem.BillingDocument and
     CGSTdetails.BillingDocumentItem = billingitem.BillingDocumentItem and
     CGSTdetails.ConditionType = 'JOCG'
     
  association [0..1] to I_BillingDocItemPrcgElmntBasic as SGSTdetails
  on SGSTdetails.BillingDocument = billingitem.BillingDocument and
     SGSTdetails.BillingDocumentItem = billingitem.BillingDocumentItem and
     SGSTdetails.ConditionType = 'JOSG'
     
  association [0..1] to I_BillingDocItemPrcgElmntBasic as IGSTdetails
  on IGSTdetails.BillingDocument = billingitem.BillingDocument and
     IGSTdetails.BillingDocumentItem = billingitem.BillingDocumentItem and
     IGSTdetails.ConditionType = 'JOIG'
     
  association [0..1] to I_BillingDocItemPrcgElmntBasic as TGSTdetails
  on TGSTdetails.BillingDocument = billingitem.BillingDocument and
     TGSTdetails.BillingDocumentItem = billingitem.BillingDocumentItem and
     TGSTdetails.ConditionType = 'JTC1'
     
   association [0..1] to I_BillingDocItemPrcgElmntBasic as VGSTdetails
  on VGSTdetails.BillingDocument = billingitem.BillingDocument and
     VGSTdetails.BillingDocumentItem = billingitem.BillingDocumentItem and
     VGSTdetails.ConditionType = 'ZVAT'
     
   association [0..1] to I_BillingDocItemPrcgElmntBasic as CSTdetails
  on CSTdetails.BillingDocument = billingitem.BillingDocument and
     CSTdetails.BillingDocumentItem = billingitem.BillingDocumentItem and
     CSTdetails.ConditionType = 'ZCST'             
     
                                                                              //  END  //GST Details
 //Total Tax
 association [0..1] to I_BillingDocItemPrcgElmntBasic as Total
  on Total.BillingDocument = billingitem.BillingDocument 
 
 
 //64
// association [0..1] to  I_FrtCostAllocItm as PONo
// on PONo.SettlmtSourceDoc = billingitem.SalesDocument
 //65
 association [0..1] to  I_BillingDocumentPartner as Vendordetails
 on Vendordetails.BillingDocument = billingitem.BillingDocument and
    Vendordetails.PartnerFunction = 'U3'
 
 //69
// association [0..1] to  I_FrtCostAllocItm as Freightexp
// on Freightexp.SettlmtSourceDoc = billingitem.SalesDocument and
//    Freightexp.SettlmtSourceDocItem = billingitem.BillingDocumentItem and
//    Freightexp.FrtCostAllocItemNetAmount >= 0 
//ADDED ON 11.10.2023
association [0..1] to ZI_PUR_AND_FREIGHT as FREIGHTEXP
on FREIGHTEXP.SettlmtSourceDoc = billingitem.SalesDocument and
    FREIGHTEXP.SettlmtSourceDocItem = billingitem.BillingDocumentItem and
    FREIGHTEXP.FrtCostAllocItemNetAmount >= 0
//ADDED ON 11.10.2023

//70
association [0..1] to  ZI_Customer_Details_R1 as Broker
on Broker.Billiing_Doc = billingitem.BillingDocument

// 74
//association [0..1] to  I_JournalEntryItem as GLAcc
association [0..1] to  ZI_JournalEntry as GLAcc

on GLAcc.BillingDocument = billingitem.BillingDocument and
   GLAcc.PostingKey   = '50' and
   GLAcc.DebitCreditCode = 'H'
//
////75
//association [0..1] to I_GLAccountTextRawData as GLName
//on GLName.GLAccount = 

association [0..1] to ZI_TRANS_DETAILS as Trans
on  Trans.BillingDocument = billingitem.BillingDocument
and Trans.PartnerFunction = 'U3' 

//association [0..1] to ZF4HELP_TEST as F4HELP on billingitem.BillingDocumentType = F4HELP.BILLING_TYPE
association [0..1] to Z_I_BILLING_F4HELP as _HELP on $projection.Billing_Type = _HELP.BillingDocumentType
association [0..1] to Z_I_DIVISION_VH as _DIV_HELP on $projection.Billing_Type = _DIV_HELP.Division

{ 
   @Consumption.valueHelpDefinition: [{entity: {element: 'Billing_Doc_No' , name: 'Z_I_BILLING_F4HELP'}}]
  key 
//  Billing_Doc_No

  ltrim(billingitem.BillingDocument,'0')           as Billing_Doc_No,            //1
 // @Semantics.calendar.yearMonth: true
//  cast( cast( billingitem.BillingDocumentDate  as abap.char(12)) as abap.dats)          as billingdate,         //2
//// cast( 
////      concat(
////        concat(
////          concat(substring(billingitem.BillingDocumentDate, 7, 2), '.' ),
////          concat(substring(billingitem.BillingDocumentDate, 5, 2), '.' )
////        ),
////        substring(billingitem.BillingDocumentDate, 1, 4)        
////      )
////    as char10 preserving type) as Billing_date,
billingitem.BillingDocumentDate as Billing_date,
  billingitem.BillingDocumentType           as Billing_Type,         //3
  //billingitem.SalesDocument as Sales_Doc,
//  BillingHeader.AccountingPostingStatus as posting_status,
//  BillingHeader.BillingDocumentIsCancelled as cancelled,
  documenttype.BillingDocumentTypeName      as Billing_Description,         //4
 ltrim(PrecInv.SubsequentDocument,'0')      as Preceding_Invoice_No,
  case PrecInv.CreationDate
  
  when '0000-00-00' then ' '
  else
//  PrecInv.CreationDate as Preceding_Invoice_date,
  cast( 
      concat(
        concat(
          concat(substring(PrecInv.CreationDate, 7, 2), '.' ),
          concat(substring(PrecInv.CreationDate, 5, 2), '.' )
        ),
        substring(PrecInv.CreationDate, 1, 4)        
      )
    as char10 preserving type) end as Preceding_Invoice_date,
  
  
//  itemflow.SalesOrder      as Preceding_Invoice_No,         //5
//  billingitem.BillingDocumentDate           as billingDocumentDate,         //6
  BillingHeader.DocumentReferenceID         as GST_Invoice_No,         //7
  BillingHeader.AccountingDocument          as Accounting_Doc_No,         //8
  billingitem.SalesOrderDistributionChannel as Distribution_Channel,         //9
  Distchannel.DistributionChannelName       as Dist_Channel_Desc,         //10
  billingitem.Division                      as Division,         //11
  Division.DivisionName                     as Division_Desc,         //12
  billingitem.SalesOrderCustomerPriceGroup  as Price_Group,
  billingitem.CustomerGroup                 as Customer_Group,         //16
  Custgrp.AdditionalCustomerGroup1Name      as Customer_Group_Desc,
  ltrim(BillingHeader.PayerParty,'0')                 as Customer_No,               //17
  
  //case billingitem.BillingQuantity not null
  
  ltrim(billingitem.BillingDocumentItem,'0')           as Item_No,                   //33
  ltrim(billingitem1.Product,'0')                      as Material_COde,            //34
  billingitem1.BillingDocumentItemText                 as Material_Description,      //35
  customer.CustomerName                                as Customer_Name,         //18
  customer.TaxNumber3                                  as Customer_GSTIN_No,         //19
  //customer.OrganizationBPName1             as Customer_Pan,         //20
  customer.Customer_Pan                                as Customer_Pan,
  customer.TaxNumber2                                  as Customer_Tin,         //21
  customer.Region                                      as Region,                           //22
   
  ltrim(itemflow1.PrecedingDocument,'0')               as Sales_Contract_No,
  ltrim(billingitem.SalesDocument,'0')                 as sales_order_no,
  salesdetails.PurchaseOrderByCustomer                 as Customer_PO_No,     // 26
  //salesdetails.CustomerPurchaseOrderDate as Customer_PO_Date,  // 27
   cast( 
      concat(
        concat(
          concat(substring(salesdetails.CustomerPurchaseOrderDate, 7, 2), '.' ),
          concat(substring(salesdetails.CustomerPurchaseOrderDate, 5, 2), '.' )
        ),
        substring(salesdetails.CustomerPurchaseOrderDate, 1, 4)        
      )
    as char10 preserving type)                        as Customer_PO_Date,
  //salesdetails.ReferenceSDDocument                as Sales_Order_No,     // 28
  
//  salesdetails.CreationDate                       as Sales_Order_Date,   // 29
 cast( 
      concat(
        concat(
          concat(substring(salesdetails.CreationDate, 7, 2), '.' ),
          concat(substring(salesdetails.CreationDate, 5, 2), '.' )
        ),
        substring(salesdetails.CreationDate, 1, 4)        
      )
    as char10 preserving type)                           as Sales_Order_Date,
//  ltrim(salesflow.SubsequentDocument,'0')                    as Delivery_No,        //30
    ltrim(billingitem.ReferenceSDDocument,'0')           as Delivery_No,
     cast( 
      concat(
        concat(
          concat(substring(Delivery.CreationDate, 7, 2), '.' ),
          concat(substring(Delivery.CreationDate, 5, 2), '.' )
        ),
        substring(Delivery.CreationDate, 1, 4)        
      )
    as char10 preserving type)                            as Delivery_Date,
  Mattext.AdditionalMaterialGroup1Name                    as Material_Group,     //32
  HSNcode.ConsumptionTaxCtrlCode                          as HSN_Code,           //36
  ltrim(batchdetails.Batch,'0')                           as Batch_NO,          //37
 // batchdetails.ManufactureDate                     as Manufacturing_Date,  //38
   cast( 
      concat(
        concat(
          concat(substring(batchdetails.ManufactureDate, 7, 2), '.' ),
          concat(substring(batchdetails.ManufactureDate, 5, 2), '.' )
        ),
        substring(batchdetails.ManufactureDate, 1, 4)        
      )
    as char10 preserving type)                           as Manufacturing_Date,
  //batchdetails.ShelfLifeExpirationDate            as Expiry_Date,        //39
   cast( 
      concat(
        concat(
          concat(substring(batchdetails.ShelfLifeExpirationDate, 7, 2), '.' ),
          concat(substring(batchdetails.ShelfLifeExpirationDate, 5, 2), '.' )
        ),
        substring(batchdetails.ShelfLifeExpirationDate, 1, 4)        
      )
    as char10 preserving type)                           as Expiry_Date,
  @Semantics.quantity.unitOfMeasure: 'Unit'
//floor(billingitem.BillingQuantity)                    as Invoice_Qty ,       //40
  billingitem.BillingQuantity                            as Invoice_Qty ,       //40
//  @Consumption.hidden: true
 billingitem.BillingQuantityUnit                         as      Unit,
  case billingitem.SalesDocumentItemCategory 
    when 'TANN' then floor(billingitem.BillingQuantity) 
  //  else '000000'
    end as Free_Quantity,
    
  case billingitem.BillingQuantityUnit 
    when 'ZQT' then 'QTL'
    else billingitem.BillingQuantityUnit
    end as UOM ,               
  
  cast((Itemprcg.ConditionRateAmount) as abap.dec(15,2)) as Unit_Rate,   //43
  @DefaultAggregation:#NONE
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  Itemprcg1.ConditionAmount                              as Freight_Amount,//44
Itemprcg1.TransactionCurrency,
  Itemprcg2.ConditionAmount                              as Insurance_Amount,  //45
  Itemprcg3.ConditionAmount                              as Packaging_Cost ,  //46
  //                                                       
  cast((Itemprcg.ConditionRateAmount * billingitem.BillingQuantity) as abap.dec(15,2)) as Basic_Amount,
  billingitem.NetAmount                                  as Taxable_Value_In_RS,  //48
  
 cast((CGSTdetails.ConditionRateValue) as abap.dec(5,2)) as CGST_RATE ,
  CGSTdetails.ConditionAmount                            as CGST,           //51
cast((SGSTdetails.ConditionRateValue) as abap.dec(5,2))  as SGST_Rate,  //52
   SGSTdetails.ConditionAmount                           as SGST,                          //53
cast((IGSTdetails.ConditionRateValue) as abap.dec(5,2))  as IGST_Rate, //54
   IGSTdetails.ConditionAmount                           as IGST,                           //55
cast((TGSTdetails.ConditionRateValue) as abap.dec(5,2))  as TCS_Rate, //56
   TGSTdetails.ConditionAmount                           as TCS,                             //57
cast((VGSTdetails.ConditionRateValue) as abap.dec(5,2))  as VAT_Rate,  //58
   VGSTdetails.ConditionAmount                           as VAT,                               //59
cast((CSTdetails.ConditionRateValue) as abap.dec(5,2))   as CST_Rate,  //60
   CSTdetails.ConditionAmount                            as CST,                                //61
cast((CGSTdetails.ConditionRateValue
                +
       SGSTdetails.ConditionRateValue 
                +
       IGSTdetails.ConditionRateValue  ) as abap.dec(5,2)) as GST_RATE ,
   
   billingitem.TaxAmount                               as Totaltax,                                   //62
   billingitem.TaxAmount + billingitem.NetAmount       as Gross_Value,       //63
   
   
//   PONo.SettlmtItemReltdPurgDoc as Transporter_Purchase_Doc_No,        //64
      FREIGHTEXP.PurchaseOrder as Transporter_Purchase_Doc_No,        //64
   
    ltrim(Vendordetails.Supplier, '0')                 as Freight_vendor,                     //65
   
  FREIGHTEXP.FrtCostAllocItemNetAmount                 as Freight_Exp,         //69
   //@DefaultAggregation: #SUM
   case when ( FREIGHTEXP.FrtCostAllocItemNetAmount is null and Itemprcg1.ConditionAmount is not null ) then Itemprcg1.ConditionAmount
    
   else
   Itemprcg1.ConditionAmount - FREIGHTEXP.FrtCostAllocItemNetAmount end as Freight_Margin,
   billingitem.YY1_Season_BDI                         as Sales_Season,
   ltrim(BillingHeader.SoldToParty,'0')               as Broker_Code,                           //72
   Broker.CustomerName                                as Broker_Name,                    //73
   Trans.SupplierName                                 as Transporter_Name,
//   F4HELP.BILLING_TYPE as BILL_TYPE_HELP, 
   _HELP,
   _DIV_HELP
   
   }  where billingitem.BillingQuantity is not initial 
and BillingHeader.AccountingPostingStatus = 'C' 
and BillingHeader.BillingDocumentIsCancelled <> 'X'
and BillingHeader.BillingDocumentType <> 'S1'
 and BillingHeader.BillingDocumentType <> 'S2' 
 //and Freightexp.FrtCostAllocItemNetAmount >= 0      //To restrict negative amount
       
       
       
       
       
       
       
       
       
       
       
       

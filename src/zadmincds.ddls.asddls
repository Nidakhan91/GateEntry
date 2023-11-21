@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Admin CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zadmincds
  as select from    zadmin                     as a
    left outer join I_SupplierAccountGroupText as b on  a.fieldvalue = b.SupplierAccountGroup
                                                    and b.Language   = 'E'
                                                    and a.fieldkey   = 'VEND'
    left outer join I_CustomerAccountGroupText as c on  a.fieldvalue = c.CustomerAccountGroup
                                                    and c.Language   = 'E'
                                                    and a.fieldkey   = 'CUST'
    left outer join I_ProductTypeText_2          as d on  a.fieldvalue = d.ProductType
                                                    and d.Language   = 'E'
                                                    and a.fieldkey   = 'MTYPE'
     left outer join I_SalesDocumentTypeText as e on a.fieldvalue = e.SalesDocumentType and e.Language = 'E' and a.fieldkey = 'SDOC'
     left outer join I_BillingDocumentTypeText as f on a.fieldvalue = f.BillingDocumentType and f.Language = 'E' and a.fieldkey = 'BDOC' 
     
     left outer join I_DeliveryDocumentTypeText as g on a.fieldvalue = g.DeliveryDocumentType and g.Language = 'E' and a.fieldkey = 'DDOC'  
     left outer join I_GoodsMovementTypeT as h on a.fieldvalue = h.GoodsMovementType and h.Language = 'E' and a.fieldkey = 'MOVE'                                               
{
  key a.fieldkey   as Fieldkey,
  key a.fieldvalue as Fieldvalue,
      case when a.fieldkey = 'VEND' then b.AccountGroupName
      when a.fieldkey = 'CUST' then c.AccountGroupName
      when a.fieldkey = 'MTYPE' then d.ProductTypeName 
      when a.fieldkey = 'SDOC' then e.SalesDocumentTypeName
      when a.fieldkey = 'BDOC' then f.BillingDocumentTypeName
      when a.fieldkey = 'DDOC' then g.DeliveryDocumentTypeName
      when a.fieldkey = 'MOVE' then h.GoodsMovementTypeName
      else ' '
      end          as field_desciption
}

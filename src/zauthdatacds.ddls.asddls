@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Auth Data'
define view entity zauthdatacds
  as select from    zauthdata                  as item
  //composition of target_data_source_name as _association_name
    left outer join I_SupplierAccountGroupText as b on  item.fieldval = b.SupplierAccountGroup
                                                    and b.Language    = 'E'
                                                    and item.fieldkey = 'VEND'
    left outer join I_CustomerAccountGroupText as c on  item.fieldval = c.CustomerAccountGroup
                                                    and c.Language    = 'E'
                                                    and item.fieldkey = 'CUST'
    left outer join I_ProductTypeText_2        as d on  item.fieldval = d.ProductType
                                                    and d.Language    = 'E'
                                                    and item.fieldkey = 'MTYPE'
    left outer join I_SalesDocumentTypeText    as e on  item.fieldval = e.SalesDocumentType
                                                    and e.Language    = 'E'
                                                    and item.fieldkey = 'SDOC'
    left outer join I_BillingDocumentTypeText  as f on  item.fieldval = f.BillingDocumentType
                                                    and f.Language    = 'E'
                                                    and item.fieldkey = 'BDOC'

    left outer join I_DeliveryDocumentTypeText as g on  item.fieldval = g.DeliveryDocumentType
                                                    and g.Language    = 'E'
                                                    and item.fieldkey = 'DDOC'

  association to parent zauthusercds as head

  on  $projection.Username = head.Username
  and $projection.Menu     = head.Menu

  and $projection.Role = head.Role

{
  key item.username as Username,
  key item.menu     as Menu,
  key item.role     as Role,
  key item.fieldkey as Fieldkey,
  key item.fieldval as Fieldval,
      case when item.fieldkey = 'VEND' then b.AccountGroupName
        when item.fieldkey = 'CUST' then c.AccountGroupName
        when item.fieldkey = 'MTYPE' then d.ProductTypeName
        when item.fieldkey = 'SDOC' then e.SalesDocumentTypeName
        when item.fieldkey = 'BDOC' then f.BillingDocumentTypeName
        when item.fieldkey = 'DDOC' then g.DeliveryDocumentTypeName
        else ' '
        end         as field_desciption,
        item.active,
      head
      //    _association_name // Make association public
}

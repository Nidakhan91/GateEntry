@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'User Auth CDS'
define root view entity zgeauthcds
  as select from    zgeuserauth                as a
    left outer join I_SupplierAccountGroupText as b on  a.role     = b.SupplierAccountGroup
                                                    and b.Language = 'E'
                                                    and a.menu     = 'VEND'
    left outer join I_CustomerAccountGroupText as c on  a.role     = c.CustomerAccountGroup
                                                    and c.Language = 'E'
                                                    and a.menu     = 'CUST'
    left outer join I_ProductTypeText_2        as d on  a.role     = d.ProductType
                                                    and d.Language = 'E'
                                                    and a.menu     = 'MTYPE'
    left outer join I_SalesDocumentTypeText    as e on  a.role     = e.SalesDocumentType
                                                    and e.Language = 'E'
                                                    and a.menu     = 'SDOC'
    left outer join I_BillingDocumentTypeText  as f on  a.role     = f.BillingDocumentType
                                                    and f.Language = 'E'
                                                    and a.menu     = 'BDOC'

    left outer join I_DeliveryDocumentTypeText as g on  a.role     = g.DeliveryDocumentType
                                                    and g.Language = 'E'
                                                    and a.menu     = 'DDOC'
  //composition of target_data_source_name as _association_name
{
  key    a.username as Username,
  key    a.menu     as Roletype,
  key    a.role     as Role,
         case when a.role = 'VEND' then b.AccountGroupName
           when a.menu = 'CUST' then c.AccountGroupName
           when a.menu = 'MTYPE' then d.ProductTypeName
           when a.menu = 'SDOC' then e.SalesDocumentTypeName
           when a.menu = 'BDOC' then f.BillingDocumentTypeName
           when a.menu = 'DDOC' then g.DeliveryDocumentTypeName
           else ' '
           end      as Role_desciption
         //    _association_name // Make association public
}

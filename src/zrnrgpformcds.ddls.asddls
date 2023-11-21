@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RNRGP Form CDS'
define root view entity zrnrgpformcds
  as select from    zrnrgpcds                  as head
    left outer join I_Supplier                 as supp  on head.Supplier = ltrim(
      supp.Supplier, '0'
    )
    left outer join I_Businesspartnertaxnumber as stax  on  head.Supplier  = ltrim(
      stax.BusinessPartner, '0'
    )
                                                        and stax.BPTaxType = 'IN3'
    left outer join I_Customer                 as cust  on head.Customer = ltrim(
      cust.Customer, '0'
    )
    left outer join I_Businesspartnertaxnumber as ctax  on  head.Supplier  = ltrim(
      ctax.BusinessPartner, '0'
    )
                                                        and ctax.BPTaxType = 'IN3'

    left outer join I_Plant                    as plant on head.Plant = plant.Plant
  composition [0..*] of zrgnrgpformitemcds as item
{
  key head.Gatepasstype,
  key head.Gatepassnumber,
  key head.Gatepassyear,
  key head.Plant,
      plant.PlantName,
      plant._OrganizationAddress.Building,
      plant._OrganizationAddress.StreetName,
      plant._OrganizationAddress.CityName,
      plant._OrganizationAddress._Region._RegionText[ Language = 'E' ].RegionName,
      plant._OrganizationAddress._Country._Text[ Language = 'E' ].CountryName,
      plant._OrganizationAddress.PostalCode,
      ''                                         as plantgst,
      ''                                         as plantpan,
      //plant.
      head.purchasematerialdoc,
      head.Requester,
      head.Valueininr,
      head.Remark,
      head.Transportmode,
      head.Vehicalnumber,

      case when head.Customer is not initial then head.Customer
      when head.Supplier is not initial then head.Supplier
      end                                        as party_code,

      case when head.Customer is not initial then
      cust.CustomerName
      when head.Supplier is not initial then
      supp.SupplierName end                      as party_name,

      case when head.Customer is not initial then
      cust._AddressRepresentation.Street
      when head.Supplier is not initial then
      supp._AddressRepresentation.Street end     as party_street,
      case when head.Customer is not initial then
      cust._AddressRepresentation.CityName //as cust_city,
      when head.Supplier is not initial then
      supp._AddressRepresentation.CityName end   as party_city,

      case when head.Customer is not initial then

      cust._AddressRepresentation._Region._RegionText[ Language = 'E' ].RegionName  //as cust_region,
      when head.Supplier is not initial then
      supp._AddressRepresentation._Region._RegionText[ Language = 'E' ].RegionName end as party_region,

      case when head.Customer is not initial then
      cust._AddressRepresentation._Country._Text[ Language = 'E' ].CountryName //as cust_country,
      when head.Supplier is not initial then
      supp._AddressRepresentation._Country._Text[ Language = 'E' ].CountryName end    as party_country,

      case when head.Customer is not initial then
      cust._AddressRepresentation.PostalCode //as cust_post,
      when head.Supplier is not initial then
      supp._AddressRepresentation.PostalCode end as party_postcode,

      case when head.Customer is not initial then
      ctax.BPTaxNumber //as cust_gst,
      when head.Supplier is not initial then
      stax.BPTaxNumber end                       as party_gst,
      //cust.TaxNumber3 as cust_gst,
      case when head.Customer is not initial then
      substring( ctax.BPTaxNumber ,3,10 ) //as cust_pan,
      when head.Supplier is not initial then
      substring( stax.BPTaxNumber ,3,10 ) end    as party_pan,
      //head.Supplier,

      //supp.SupplierName as supp_name,
      //supp._AddressRepresentation.Street as supp_street,
      //supp._AddressRepresentation.CityName as supp_city,
      //supp._AddressRepresentation.Region as supp_region,
      //supp._AddressRepresentation.Country as supp_country,
      //supp._AddressRepresentation.PostalCode as supp_post,
      //supp.TaxNumber3 as supp_gst,
      //stax.BPTaxNumber                           as supp_gst,
      //substring( stax.BPTaxNumber ,3,10 )        as supp_pan,
      head.Deletionind,
      head.Deletedby,
      head.Approvalstatus,
      head.Approvedby,
      head.Createdby,
      head.Createdon,
      head.createdat,
      head.changedby,
      head.changedon,
      head.changetime,
      /* Associations */
      item
      //_association_name // Make association public
}

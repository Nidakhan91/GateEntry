@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gate Outward Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zgateoutwardreport
  as select from    zgateoutward as a
    left outer join I_Plant         as b on a.plant = b.Plant
    left outer join I_Supplier      as c on a.transporter = ltrim(
      c.Supplier, '0'
    )
    left outer join I_Supplier      as d on a.suppliercode = ltrim(
      d.Supplier, '0'
    )
    left outer join I_Customer      as e on a.customer = ltrim(
      e.Customer, '0'
    )
{
  key a.gateentrynumber as Gateentrynumber,
  key a.gateentrydate as Gateentrydate , //+6(2) , concat( '.', Gateentrydate+4 ),//'.',Gateentrydate+0(4) ) ,
      a.plant as Plant,
      b.PlantName                                       as plantname,
      a.customer as Customer,
      a.deliverydocument as Deliverydocument,
      cast( ' ' as abap.sstring( 10 ))                  as BILLINGDOCUMENT,
      case when a.entrytype = 'VRET' then 'VRET' else cast( 'S/STO' as abap.sstring( 50 ) ) end as gateentrytype,
      a.customertype as Customertype,
      a.customername as Customername,
      e.CityName                                        as customercity,
      a.suppliertype as suppliertype,
      a.suppliercode,
      a.suppliername,
      d.CityName                                        as suppliercity,
      a.vehicaltype as Vehicaltype,
      a.vehicalno as Vehicalno,
      a.deliverydocumentgrosswt as Deliverydocumentgrosswt,
      a.tarewt as Tarewt,
      a.weightdate as Weightdate,
      a.weighttime as Weighttime,
      a.grosswt as Grosswt,
      a.netwt as Netwt,
      a.remark as Remark,
      cast( ' ' as abap.sstring( 20 )) as Noofpackages,
      cast( ' ' as abap.sstring( 20 )) as transportmode, 
      a.transporter as Transporter,
      c.SupplierName                                    as transportername,
      c.CityName                                        as transportercity,
      a.entrytype,
      a.isclosed,
      a.closedate,
      a.closetime,
      a.cancelledind,
      a.cancelledby,
      a.cancelledon,
      a.cancelledtime,
      concat( substring( a.entrytime,1,2 ) ,
      concat( ':',concat( substring( a.entrytime,2,2 ),
      concat( ':' ,substring( a.entrytime,4,2 ) ) ) ) ) as entrytime,
      a.createdby,
      case when a.isclosed = 'X'
      then 'Closed' else 'Open' end                     as status,

      cast( ' ' as abap.sstring( 10 ))                                               as Materialdocument,
      cast( ' ' as abap.sstring( 10 ))                                               as Materialdocumentyear,
      cast( ' ' as abap.sstring( 10 ))                                               as Materialdocumentlineitem,
      cast( ' ' as abap.sstring( 20 ))                                               as Material,
      cast( ' ' as abap.sstring( 40 ))                                               as Materialdescription,
      cast( ' ' as abap.sstring( 10 ))                                               as Materialtype,
      //    b.plant as Plant,
      cast( ' ' as abap.sstring( 10 ))                                               as Qty,
      cast( ' ' as abap.sstring( 10 ))                                               as Openquantity,
      cast( ' ' as abap.sstring( 10 ))                                               as Quantityinge,
      ' ' as Recvqty
}
union all select from zemptyvehicle       as a
  left outer join     I_Plant         as b on a.plant = b.Plant
  left outer join     I_Supplier      as c on a.transporter = ltrim(
    c.Supplier, '0'
  )
  left outer join   zgateoutward as d on  a.gateentryno   = d.gateentrynumber 
  left outer join   zsubcontracting as e on  a.gateentryno   = e.gateentrynumber 
  left outer join   zchallanheader as f on  a.gateentryno   = f.gateentrynumber 
//                                           and a.gateentrydate = d.gateentrydate
//left outer join I_Supplier as d on a.suppliercode = ltrim( d.Supplier)
{
  key a.gateentryno                               as Gateentrynumber,
  key a.gateentrydate                             as Gateentrydate,
      a.plant                                     as Plant,
      b.PlantName                                 as plantname,
      ' '                                         as Customer,
      ' '                                         as Deliverydocument,
      ''                                          as BILLINGDOCUMENT,
      'EVGE'                                      as gateentrytype,
      ' '                                         as Customertype,
      ' '                                         as Customername,
      ''                                          as customercity,
      ' '                                         as suppliertype,
      ' '                                         as suppliercode,
      ' '                                         as suppliername,
      ' '                                         as suppliercity,
      a.vehicletype                               as Vehicaltype,
      a.vehicalno                                 as Vehicalno,
      '  '                                        as Deliverydocumentgrosswt,
      a.tarewt                                    as Tarewt,
      a.weightdate                                as Weightdate,
      a.weighttime                                as Weighttime,
      ' '                                         as grosswt,
      ' '                                         as netwt,
      a.remark                                    as Remark,
      cast( ' ' as abap.sstring( 20 )) as Noofpackages,
      '' as transportmode, 
      a.transporter                               as Transporter,
      c.SupplierName                              as transportername,
      c.CityName                                  as transportercity,
      ' '                                         as entrytype,
      ' '                                         as isclosed,
      ''                                          as closedate,
      ''                                          as closetime,
      a.cancelledind,
      a.cancelledby,
      a.cancelledon,
      a.cancelledtime,
      concat( substring( a.entrytime,1,2 ) ,
      concat( ':',concat( substring
      ( a.entrytime,2,2 ),concat
      ( ':' ,substring( a.entrytime,4,2 ) ) ) ) ) as entrytime,
      a.createdby,
      case when d.isclosed = 'X'
      then 'Closed' when e.isclosed = 'X' then 'Closed' when f.isclosed = 'X' then 'Closed' else 'Open' end                as status,
      ' '                                         as Materialdocument,
      ' '                                         as Materialdocumentyear,
      ' '                                         as Materialdocumentlineitem,
      ' '                                         as Material,
      ' '                                         as Materialdescription,
      ' '                                         as Materialtype,
      //    b.plant as Plant,
      ' '                                         as Qty,
      ' '                                         as Openquantity,
      ' '                                         as Quantityinge,
      ' ' as Recvqty

}
union all select from zsubcontracting as a

  left outer join     I_Plant         as b on a.plant = b.Plant
  left outer join     I_Supplier      as c on a.transporter = ltrim(
    c.Supplier, '0'
  )

  left outer join     I_Supplier      as d on a.supplier = ltrim(
    d.Supplier, '0'
  )

{
  key a.gateentrynumber                    as Gateentrynumber,
  key a.gateentrydate                      as Gateentrydate,
      a.plant                              as Plant,
      b.PlantName                          as plantname,
      ' '                                  as Customer,
      ' '                                  as Deliverydocument,
      a.billingdocument                    as Billingdocument,
      'SUBC'                              as gateentrytype,
      ' '                                  as Customertype,
      ' '                                  as Customername,
      ''                                   as customercity,

      a.suppliertype                       as Suppliertype,
      a.supplier                           as Suppliercode,
      a.suppliername                       as Suppliername,
      d.CityName                           as suppliercity,
      a.vehicaltype                        as Vehicaltype,
      a.vehicalno                          as Vehicalno,
      '  '                                 as Deliverydocumentgrosswt,
      a.tarewt                             as Tarewt,
      a.weightdate                         as Weightdate,
      a.weighttime                         as Weighttime,
      a.grosswt                            as Grosswt,
      a.netwt                              as Netwt,
      a.remark                             as Remark,
      cast( ' ' as abap.sstring( 20 )) as Noofpackages,
      '' as transportmode, 
      a.transporter                        as Transporter,

      c.SupplierName                       as transportername,
      c.CityName                           as transportercity,
      ' '                                  as entrytype,
      a.isclosed,
      ''                                   as closedate,
      ''                                   as closetime,
      a.cancelledind,
      a.cancelledby,
      a.cancelledon,
      a.cancelledtime,
      concat( substring( a.entrytime,1,2 ) ,concat( ':',
      concat( substring( a.entrytime,2,2 ),concat( ':' ,
      substring( a.entrytime,4,2 ) ) ) ) ) as entrytime,
      a.createdby,
      case when a.isclosed = 'X'
      then 'Closed'  else 'Open' end                as status,

      ' '                                  as Materialdocument,
      ' '                                  as Materialdocumentyear,
      ' '                                  as Materialdocumentlineitem,
      ' '                                  as Material,
      ' '                                  as Materialdescription,
      ' '                                  as Materialtype,
      //    b.plant as Plant,
      ' '                                  as Qty,
      ' '                                  as Openquantity,
      ' '                                  as Quantityinge,
      ' ' as Recvqty
}
union all select from zchallanheader as a
  inner join          zchallanitem   as b on  a.gateentrynumber      = b.gateentrynumber
                                          and a.gateentrydate        = b.gateentrydate
                                          and a.materialdocument     = b.materialdocument
                                          and a.materialdocumentyear = b.materialdocumentyear

  left outer join     I_Plant        as c on c.Plant = a.plant
  left outer join     I_Supplier     as d on a.supplier = ltrim(
    d.Supplier, '0'
  )
  left outer join I_ProductDescription as e on b.material = ltrim( e.Product,'0') and e.Language = 'E'
{
  key a.gateentrynumber          as Gateentrynumber,
  key a.gateentrydate            as Gateentrydate,

      a.plant                    as Plant,
      c.PlantName                as plantname,
      ' '                        as Customer,
      ' '                        as Deliverydocument,
      ' '                        as Billingdocument,
      a.gateentrytype            as gateentrytype,
      ' '                        as Customertype,
      ' '                        as Customername,
      ''                         as customercity,

      ' '                        as Suppliertype,
      a.supplier                 as Suppliercode,
      d.SupplierName             as Suppliername,
      d.CityName                 as suppliercity,
      a.vehicaltype              as Vehicaltype,
      a.vehicalnumber            as Vehicalno,
      '  '                       as Deliverydocumentgrosswt,
      ' '                        as Tarewt,
      ' '                        as Weightdate,
      ' '                        as Weighttime,
      a.grosswt                  as Grosswt,
      a.netwt                    as Netwt,
      a.remark                   as Remark,
      a.noofpackages,
      a.transportmode, 
      a.transporter              as Transporter,

      a.transportername          as transportername,
      ''                         as transportercity,
      ' '                        as entrytype,
      a.isclosed,
      a.closedate,
      a.closetime,
      a.cancelledind,
      a.cancelledby,
      a.cancelledon,
      a.cancelledtime,
      ' '                        as entrytime,
      a.createdby,
      case when a.isclosed = 'X'
      then 'Closed'  else 'Open' end                as status,

      b.materialdocument         as Materialdocument,
      b.materialdocumentyear     as Materialdocumentyear,
      b.materialdocumentlineitem as Materialdocumentlineitem,
      b.material                 as Material,
      e.ProductDescription       as Materialdescription,
      b.materialtype             as Materialtype,
      //    b.plant as Plant,
      b.qty                      as Qty,
      b.openquantity             as Openquantity,
      b.quantityinge             as Quantityinge,
      b.recvqty as Recvqty

}

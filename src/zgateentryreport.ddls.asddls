@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gate Entry Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zgateentryreport

  //with parameters wplant : abap.char( 5 )
  as select from    zgenpoheader as a
    inner join      zgenpurchase as b on  a.gateentryno = b.gateentryno
                                      and a.supplier    = b.supplier
                                      and a.podocno     = b.podocno
                                      and a.plant       = b.plant

    left outer join I_Supplier   as c on a.supplier = ltrim(
      c.Supplier, '0'
    )
    left outer join I_Supplier   as d on a.transporter = ltrim(
      d.Supplier, '0'
    )
    left outer join I_Customer   as e on a.customercode = ltrim(
      e.Customer, '0'
    )
    left outer join I_Plant      as f on a.plant = f.Plant
  //    left outer join I_MaterialDocumentItemTP  as g on a.gateentryno = g.YY1_Gateentrynumber_MMI and a.podocno = g.PurchaseOrder
  //    and ltrim( b.poitem ,'0' ) = ltrim( g.PurchaseOrderItem ,'0' )
{
  key a.plant,
  key a.gateentryno,
  key a.gateentrydate,

      f.PlantName                    as plantname,
      'GENPO'                        as gateentrytype,
      a.supplier,
      c.SupplierFullName             as suppliername,
      c.CityName                     as suppliercity,
      ' '                            as Deliverydocument,
      a.podocno,
      a.invoiceno,
      a.invoicedate,
      a.suppliertype,
      a.ewaybill,
      a.vendorname,
      a.noofpackages,        //: abap.sstring(25);
      a.vehicleno,           //: abap.sstring(25);
      a.vehicletype,         //: abap.sstring(25);
      a.binsyesno,           //: abap.sstring(25);
      a.noofbins,            //: abap.sstring(25);
      a.transporter,         //: abap.sstring(25);
      d.SupplierFullName             as transportername,
      a.transportmode,       //: abap.sstring(25);
      d.CityName                     as transportercity,
      a.lrno,                //: abap.sstring(25);
      a.approvervendor,      //: abap.sstring(25);
      ''                             as Customertype,
      a.customercode,        //: abap.sstring(12);
      a.customername,        //: abap.sstring(50);
      e.CityName                     as customercity,
      a.lrdate,              //: abap.sstring(25);
      a.gateentryactualdate, //: abap.sstring(25);
      a.grossqty                     as grosswt, //: abap.sstring(25);
      a.tolorane, //: abap.sstring(25);
      a.tareqty                      as tarewt, //: abap.sstring(25);
      a.netqty                       as netwt, //: abap.sstring(25);
      a.weighttime, //: abap.sstring(25);
      a.weighdate, //: abap.sstring(25);
      a.remark, //: abap.sstring(25);
      a.isclose,
      a.iscancelled,
      a.cancelreason,
      a.creationtime,
      a.createdby,
      a.closedon,
      a.closedtime,
      a.cancelledon,
      a.cancelledby,
      a.cancelledtime,
      case when  a.isclose = 'X' //cast( b.poqty as abap.char( 20 ) ) - cast( b.geqty as abap.char(20) )  = 0
       then 'Close' 
       when a.iscancelled = 'X' then 'Cancelled' else 'Open'  end as status,
      b.podoctype,
      b.poitem,
      b.suppliermatdesc,
      b.material,
      b.materialdesc,
      ''                             as Batch,
      b.poqty,
      b.openqty,
      b.geqty
}

union all select from zsalesreturn as a
  left outer join     I_Plant      as f on a.plant = f.Plant

{
  key a.plant            as plant,
  key a.gateentrynumber  as gateentryno,
  key a.gateentrydate    as gateentrydate,

      f.PlantName        as plantname,
      'SRGE'             as gateentrytype,
      ' '                as supplier,
      ' '                as suppliername,
      ' '                as suppliercity,
      a.deliverydocument as Deliverydocument,
      ' '                as podocno,
      ' '                as invoiceno,
      ' '                as invoicedate,
      ' '                as suppliertype,
      ' '                as ewaybill,
      ' '                as vendorname,
      ' '                as noofpackages,
      a.vehicalno        as vehicleno,
      a.vehicaltype      as vehicletype,
      ' '                as binsyesno,     //: abap.sstring(25);
      ' '                as noofbins,
      a.transporter      as transporter,
      ' '                as transportername,
      ' '                as transportmode, //: abap.sstring(25);
      ' '                as transportercity,
      ' '                as lrno,          //: abap.sstring(25);
      ' '                as approvervendor,
      a.customertype     as Customertype,
      a.customer         as customercode,
      a.customername     as customername,
      ' '                as customercity,
      ' '                as lrdate,        //: abap.sstring(25);
      ' '                as gateentryactualdate,
      a.grosswt          as grosswt,
      ' '                as tolorane, //: abap.sstring(25);
      ' '                as tarewt, // as tarewt,
      a.netwt            as netwt,
      a.weighttime       as weighttime,
      a.weightdate       as weighdate,
      a.remark           as remark,
      ' '                as isclose,
      a.cancelledind                as iscancelled,

      a.cancelreason,
      '' as creationtime,
      '' as createdby,
      '' as closedon,
      '' as closedtime,
      ' '                as cancelledon,
      a.cancelledby,
      a.cancelledtime,
      case when a.cancelledind = 'X'  then 'Cancelled' else 'Open'   end as status,
      ' '                as podoctype,
      ' '                as poitem,
      ' '                as suppliermatdesc,
      ' '                as material,
      ' '                as materialdesc,
      ' '                as batch,
      ' '                as poqty,
      ' '                as openqty,
      ' '                as geqty
}

//@AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Gen Purchase'
//@Metadata.ignorePropagatedAnnotations: true
//@OData.publish: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zgenpurchasecds
  as select from zgenpurchase
  //association to Parent ZGENPOCDS  as b
  // on $projection.gateentryno = b.gateentryno and
  //       $projection.plant = b.plant and
  //       $projection.supplier = b.Supplier and
  //       $projection.podocno = b.podocno
{
      //key client as client,

  key gateentryno,
  key gateentrydate,
  key plant               as plant,
  key supplier            as Supplier,
      //key invoiceno as Invoiceno,
      //key invoicedate as Invoicedate,

  key podocno             as podocno,
  key podoctype           as podoctype,
  key poitem              as poitem,
      suppliertype        as suppliertype,

      suppliermatdesc     as Suppliermatdesc,
      material            as material,
      materialdesc        as materialdesc,
      poqty               as poqty,
      openqty             as openqty,
      ewaybill            as Ewaybill,
      vendorname          as Vendorname,
      noofpackages        as Noofpackages,
      vehicleno           as Vehicleno,
      vehicletype         as Vehicletype,
      binsyesno           as Binsyesno,
      noofbins            as Noofbins,
      transporter         as Transporter,
      transportmode       as Transportmode,
      lrno                as Lrno,
      approvervendor      as Approvervendor,
      customercode        as customercode,
      customername        as Customername,
      lrdate              as Lrdate,
      gateentryactualdate as Gateentryactualdate,
      grossqty            as Grossqty,
      tolorane            as Tolorane,
      tareqty             as Tareqty,
      netqty              as Netqty,
      weighttime          as Weighttime,
      weighdate           as Weighdate,
      remark              as Remark
}

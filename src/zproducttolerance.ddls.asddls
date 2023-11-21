//@AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Product Tolerance'
//@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zproducttolerance as select from zgenpurchase as a inner join
I_PurchaseOrderItemAPI01 as b on a.podocno = b.PurchaseOrder
//left outer join I_PURGVALKEY as c on b.p = c.ekwsl
{
    a.gateentryno as Gateentryno,
    a.gateentrydate as Gateentrydate,
    a.plant as Plant,
    a.supplier as Supplier,
    a.podocno as Podocno,
    a.podoctype as Podoctype,
    a.poitem as Poitem,
    a.material as Material,
    a.materialdesc as Materialdesc,
    b.OverdelivTolrtdLmtRatioInPct as overdel
    //b.GrossWeight as grossweight
//    b.
    //c.uebto
    //b._ESHProductPlant.OverDelivToleranceLimit
}

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Tolerance'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ztolerance as select from zgenpurchasecds1 as a 
left outer join I_PurchaseOrderItemAPI01 as c on  a.Podocno = ltrim(c.PurchaseOrder,'0') and c.PurchaseOrderItem = cast( a.Poitem as abap.char( 5 ) )

left outer join I_Product as b on c.Material = b.Product
{
    key a.Gateentryno,
    
    sum( cast( b.GrossWeight * c.OrderQuantity +  ( c.OverdelivTolrtdLmtRatioInPct  / 100 ) * ( b.GrossWeight * c.OrderQuantity )   as abap.dec( 12, 2 ) ) ) 
    as overnetwt,
    sum( cast( b.GrossWeight * c.OrderQuantity +  ( c.UnderdelivTolrtdLmtRatioInPct  / 100 ) * b.GrossWeight * c.OrderQuantity  as abap.dec( 12, 2 ) ) ) 
    as undernetwt
    
    
} group by a.Gateentryno

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RGP/NRGP Item CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zrnrgpitemcds as select from zrnrgpitem as item 
//left outer join I_ProductPlantBasic as plnt on item.material = ltrim( plnt.Product ,'0' )
association to parent zrnrgpcds as head on
$projection.Gatepasstype = head.Gatepasstype and 
$projection.Gatepassyear = head.Gatepassyear and 
$projection.Gatepassnumber = head.Gatepassnumber and 
$projection.Plant = head.Plant


{
    key item.gatepasstype as Gatepasstype,
    key item.gatepassnumber as Gatepassnumber,
    key item.gatepassyear as Gatepassyear,
    key item.plant as Plant,
    key item.lineitem as Lineitem,
    
    key item.remqty as remQty,
    item.material as Material,
    //plnt.ConsumptionTaxCtrlCode as hsncode,
    item.materialdesc as Materialdesc,
    item.qty as Qty,
    item.recqty as recQty,
    item.unit as Unit,
    item.duedate as Duedate,
    item.value as Value,
    item.remark as Remark,
    item.hide,
    head
}

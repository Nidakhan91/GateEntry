@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'For mitem CDS'
define view entity zrgnrgpformitemcds
  as select from zrnrgpitemcds as item //as a left outer join I_Product as pro on a.Material = ltrim( pro.Product,'0')
  
  left outer join I_ProductPlantBasic as plnt on item.Material = ltrim( plnt.Product ,'0' )
  association to parent zrnrgpformcds as head on  $projection.Gatepasstype   = head.Gatepasstype
                                              and $projection.Gatepassyear   = head.Gatepassyear
                                              and $projection.Gatepassnumber = head.Gatepassnumber
                                              and $projection.Plant          = head.Plant 
                                              
 
{
  key item.Gatepasstype,
  key item.Gatepassnumber,
  key item.Gatepassyear,
  key item.Plant,
  key item.Lineitem,
  key item.remQty,
      item.Material,
      plnt.ConsumptionTaxCtrlCode as hsncode,
      item.Materialdesc,
      item.Qty,
      item.recQty,
      item.Unit,
      item.Duedate,
      item.Value,
      item.Remark,
      item.hide,
      /* Associations */
      head
      //head // Make association public
}

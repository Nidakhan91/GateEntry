
define view entity zchallanitemcds as select from zchallanitem as item
association to parent zchallanheadcds as head on

$projection.Gateentrynumber = head.Gateentrynumber and 
$projection.Gateentrydate = head.Gateentrydate and 
$projection.Materialdocument = head.Materialdocument and
$projection.Materialdocumentyear = head.Materialdocumentyear 
//$projection.Gateentrytype = head.Gateentrytype
{

    key gateentrynumber as Gateentrynumber,
    key gateentrydate as Gateentrydate,
    key materialdocument as Materialdocument,
    key materialdocumentyear as Materialdocumentyear,
    key materialdocumentlineitem as Materialdocumentlineitem,
    material as Material,
    materialdescription as Materialdescription,
    materialtype as Materialtype,
    plant as Plant,
    qty as Qty,
    openquantity as Openquantity,
    quantityinge as Quantityinge,
    recvqty as Recvqty,
    head
}

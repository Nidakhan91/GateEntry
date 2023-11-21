//@AbapCatalog.sqlViewName: 'ZDEL'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Del 2'
//@Metadata.allowExtensions: true
define root view entity zdelivery2 as select from zdelivery
{   


  
 @UI: {
  lineItem:       [ { position: 10, importance: #HIGH }                          
                    ,{ type: #FOR_ACTION, dataAction: 'post', label: 'Post to Raintree' } 
                    //,{ type: #FOR_ACTION, dataAction: 'acceptTravel', label: 'Accept Travel' }
                    //,{ type: #FOR_ACTION, dataAction: 'rejectTravel', label: 'Reject Travel' }
       ],
  identification: [ { position: 10 }                          
                   ,{ type: #FOR_ACTION, dataAction: 'post', label: 'Post to Raintree' } 
                   //,{ type: #FOR_ACTION, dataAction: 'acceptTravel', label: 'Accept Travel' }
                   //,{ type: #FOR_ACTION, dataAction: 'rejectTravel', label: 'Reject Travel' }
       ],
    textArrangement: #TEXT_ONLY
  }
@UI.selectionField: [{ position : 10 }]
//@UI.lineItem: [{ position  : 100 }]
    key DeliveryDocument,
    @UI.lineItem: [{ position  : 10 }]
    DeliveryDocumentType,
    @UI.lineItem: [{ position  : 20 }]
    HeaderGrossWeight,
    @UI.lineItem: [{ position  : 30 }]
    HeaderNetWeight,
    @UI.lineItem: [{ position  : 40 }]
    HeaderWeightUnit,
    @UI.lineItem: [{ position  : 50 }]
    customercode,
    @UI.lineItem: [{ position  : 60 }]
    accountgroup,
    @UI.lineItem: [{ position  : 70 }]
    customername,
    @UI.lineItem: [{ position  : 80 }]
    Plant,
    @UI.lineItem: [{ position  : 90 }]
    Supplier,
    Supplieraccountgroup
    

}

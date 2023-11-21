@EndUserText.label: 'Excise Report'
@ObjectModel: {
    query: {
        implementedBy: 'ABAP:ZCL_EXCISE_REP'
    }
}
define custom entity ZI_EXCISE_REP
{

      @UI                  :{lineItem: [{ position: 10 }],
       identification      : [{ position: 10,label: 'Material Document Year' }]}
      @UI.hidden           : true
  key MaterialDocumentYear : mjahr;


      @UI                  :{lineItem: [{ position: 20 }],
       identification      : [{ position: 20,label: 'Material Document' }]}
      @UI.hidden           : true
  key MaterialDocument     : mblnr;

      @UI                  :{lineItem: [{ position: 30 }],
       identification      : [{ position: 30,label: 'Material Document Item' }]}
      @UI.hidden           : true
  key MaterialDocumentItem : mblpo;

      @UI                  :{lineItem: [{ position: 40, label: 'Material No' }],
       identification      : [{ position: 40,label: 'Material No' }]}
      @UI.selectionField   : [{position: 10}]
      @Consumption.filter.mandatory: true
  key Material             : matnr;


      @UI                  :{lineItem: [{ position: 50,label: 'Material Description' }]}
      ProductDescription   : abap.char( 80 );

      @UI                  :{lineItem: [{ position: 60 }],
       identification      : [{ position: 60,label: 'Goods Movement Type' }]}
      @UI.hidden           : true
      GoodsMovementType    : abap.char( 3 );

      @UI                  :{lineItem: [{ position: 70,label: 'Unit'  }],
       identification      : [{ position: 70,label: 'Unit' }]}
      EntryUnit            : abap.char( 4 );

      @UI                  :{lineItem: [{ position: 80,label: 'Today' }],
       identification      : [{ position: 80,label: 'Today' }]}
      fromdate             : abap.char( 10 );

      @UI                  :{lineItem: [{ position: 90,label: 'Month' }],
       identification      : [{ position: 90,label: 'Month' }]}
      monthly              : abap.char( 10 );

      @UI                  :{lineItem: [{ position: 100,label: 'To Date' }],
       identification      : [{ position: 100,label: 'To Date' }]}
      todate               : abap.char( 10 );

      @UI                  :{//lineItem: [{ position: 100,label: 'Posting Date' }],
      identification       : [{ position: 110,label: 'Posting Date' }]}
      @UI.selectionField   : [{position: 20}]
      @Consumption.filter.mandatory: true
      @Consumption.filter  :{ selectionType: #INTERVAL,multipleSelections: false }
      PostingDate          : abap.dats;


      @UI.selectionField   : [{position: 30} ]
      @Consumption.filter.mandatory: true
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_EXCISE_REPTYPE', element: 'Value' } }]
      Reporttype           : zexcise_reptype ;
  
}

@EndUserText.label: 'DMR Report'
@ObjectModel: {
    query: {
        implementedBy: 'ABAP:ZCL_ZI_DMR_REP'
    }
}
define root custom entity ZI_DMR_REP

{
        @UI                          :{lineItem: [{ position: 10,label: 'SNo' }]}
  key sno                          : abap.int8;

      @UI.selectionField           : [{position: 20}]
      @Consumption.filter.mandatory: true
      @EndUserText.label           : 'Inspection Lot'
      inspectionlot                : abap.numc( 12 );


      @UI                          :{lineItem: [{ position: 30,label: 'Particular' }]}
      inspectionCharacteristicText : abap.char( 40 );


      @UI                          :{lineItem: [{ position: 40,label: 'Today' }]}
      today                        : abap.dec( 16, 3 );


      @UI                          :{lineItem: [{ position: 50,label: 'Todate' }]}
      todate                       : abap.dec( 16, 3 );
  
}

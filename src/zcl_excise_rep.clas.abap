CLASS zcl_excise_rep DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
     INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EXCISE_REP IMPLEMENTATION.


 METHOD if_rap_query_provider~select.
    IF io_request->is_data_requested( ).
      TYPES: BEGIN OF ty_final,
               materialdocumentyear TYPE mjahr,
               materialdocumentitem TYPE mblpo,
               material             TYPE matnr,
               productdescription   TYPE char80,
               goodsmovementtype    TYPE char3,
               entryunit            TYPE char4,
               fromdate             TYPE char20,
               monthly              TYPE char20,
               todate               TYPE char20,
               postingdate          TYPE char10,
             END OF ty_final.

      TYPES: BEGIN OF ty_high_matcollect,
               material           TYPE matnr,
               entryunit          TYPE char4,
               quantityinbaseunit TYPE menge_d,
             END OF ty_high_matcollect.

      DATA: it_final           TYPE TABLE OF ty_final,
            wa_final           TYPE          ty_final,
            lv_fromdate        TYPE char20,
            lv_monthly         TYPE char20,
            lv_todate          TYPE char20,
            lv_inp             TYPE char100,
            lv_qty             TYPE p DECIMALS 2,
            lv_temp_condition  TYPE char200,
            it_high_matcollect TYPE TABLE OF ty_high_matcollect,
            wa_high_matcollect TYPE            ty_high_matcollect.


      DATA(lv_top)     = io_request->get_paging( )->get_page_size( ).
      IF lv_top < 0.
        lv_top = 1.
      ENDIF.
      DATA(lv_skip)    = io_request->get_paging( )->get_offset( ).
      DATA(lt_sort)    = io_request->get_sort_elements( ).
      DATA : lv_orderby TYPE string.
      DATA(lv_conditions) =  io_request->get_filter( )->get_as_sql_string( ).
      DATA(it_input) =  io_request->get_filter(  )->get_as_ranges( ).
      READ TABLE it_input INTO DATA(wa_input) INDEX 2.
      DATA(it_date) = wa_input-range.
      READ TABLE it_date INTO DATA(wa_date) INDEX 1.
      DATA(lv_date_low) = wa_date-low.
      DATA(lv_date_high) = wa_date-high.

      READ TABLE it_input INTO wa_input INDEX 1.
      DATA(it_material) = wa_input-range.
      READ TABLE it_material INTO DATA(wa_material) INDEX 1.
      DATA(lv_material_low) = wa_material-low.
      DATA(lv_material_high) = wa_material-high.

      READ TABLE it_input INTO wa_input INDEX 3.
      DATA(it_reporttype) = wa_input-range.
      READ TABLE it_reporttype INTO DATA(wa_reporttype) INDEX 1.
      DATA(lv_reporttype_low) = wa_reporttype-low.
      DATA(lv_reporttype_high) = wa_reporttype-high.


      TYPES: BEGIN OF r_matnr,
               sign   TYPE char1,
               option TYPE char2,
               low    TYPE matnr,
               high   TYPE matnr,
             END OF r_matnr.


      TYPES: BEGIN OF r_date,
               sign   TYPE char1,
               option TYPE char2,
               low    TYPE char8,
               high   TYPE char8,
             END OF r_date.

      DATA: r_matnr  TYPE TABLE OF r_matnr,
            w_matnr  TYPE          r_matnr,
            r_today  TYPE TABLE OF r_date,
            w_today  TYPE          r_date,
            r_month  TYPE TABLE OF r_date,
            w_month  TYPE          r_date,
            r_todate TYPE TABLE OF r_date,
            w_todate TYPE          r_date.


      DATA(lv_rows) = lines( it_material ).


      LOOP AT it_material INTO DATA(wa_material_selection).
        MOVE-CORRESPONDING wa_material_selection TO w_matnr.
        APPEND w_matnr TO r_matnr.
        CLEAR: w_matnr.
      ENDLOOP.

      LOOP AT it_date INTO DATA(wa_date_selection).
        MOVE-CORRESPONDING wa_date_selection TO w_todate.
        MOVE-CORRESPONDING wa_date_selection TO w_month.
        w_todate-low = '20200101'.
        APPEND w_todate TO r_todate.
        APPEND w_month TO r_month.
      ENDLOOP.


      IF lv_reporttype_low = 'PURCHASE'.

        SELECT      materialdocumentyear,
                    materialdocument,
                    materialdocumentitem,
                    material,
                    entryunit,
                    quantityinbaseunit,
                    postingdate,
                    goodsmovementtype
        FROM i_materialdocumentitem_2
                                        WHERE material IN @r_matnr AND
                                              postingdate IN @r_todate AND
                                              goodsmovementtype IN ( '101','102','311','312' )
                                        INTO  TABLE @DATA(it_high_materials).

        LOOP AT it_high_materials INTO DATA(wa_high_materials).
          MOVE-CORRESPONDING wa_high_materials TO wa_high_matcollect.

          IF wa_high_materials-goodsmovementtype = '102' OR
             wa_high_materials-goodsmovementtype = '312'.

            wa_high_matcollect-quantityinbaseunit = wa_high_materials-quantityinbaseunit * -1.

          ENDIF.

          COLLECT wa_high_matcollect INTO it_high_matcollect.
        ENDLOOP.


        IF it_high_matcollect IS NOT INITIAL.
          SELECT product,
                 productdescription
           FROM i_productdescription
                     FOR ALL ENTRIES IN @it_high_matcollect
                     WHERE product EQ @it_high_matcollect-material
                     INTO TABLE @DATA(it_productdesc).

        ENDIF.

        SELECT    materialdocumentyear,
                  materialdocument,
                  materialdocumentitem,
                  material,
                  entryunit,
                  quantityinbaseunit,
                  postingdate,
                  goodsmovementtype
                  FROM i_materialdocumentitem_2
                                     WHERE material     IN @r_matnr AND
                                           postingdate  IN @r_month AND
                                           goodsmovementtype IN ( '101','102','311','312' )
                                      INTO  TABLE @DATA(it_materials).



        DATA(it_materials_101) = it_materials.
        DELETE it_materials_101 WHERE goodsmovementtype = '102'.
        DELETE it_materials_101 WHERE goodsmovementtype = '312'.

        LOOP AT it_high_matcollect INTO wa_high_matcollect.
          LOOP AT it_materials INTO DATA(wa_materials) WHERE material = wa_high_matcollect-material.
            IF wa_materials-postingdate EQ lv_date_high.
              IF wa_materials-goodsmovementtype = '102' OR
                 wa_materials-goodsmovementtype = '312'.
                lv_fromdate = lv_fromdate + (  wa_materials-quantityinbaseunit * -1 ).
              ELSE.
                lv_fromdate = lv_fromdate + wa_materials-quantityinbaseunit.
              ENDIF.
            ENDIF.

            IF wa_materials-goodsmovementtype = '102' OR
               wa_materials-goodsmovementtype = '312'.

              lv_monthly = lv_monthly +  ( wa_materials-quantityinbaseunit * -1 ).
            ELSE.
              lv_monthly = lv_monthly + wa_materials-quantityinbaseunit.
            ENDIF.

          ENDLOOP.

          READ TABLE it_productdesc INTO DATA(wa_productdesc) WITH KEY product = wa_high_matcollect-material.
          IF sy-subrc = 0.
            wa_final-productdescription = wa_productdesc-productdescription.
          ENDIF.

          MOVE-CORRESPONDING wa_high_matcollect TO wa_final.
          wa_final-fromdate = lv_fromdate.
          wa_final-monthly = lv_monthly.
          wa_final-todate = wa_high_matcollect-quantityinbaseunit.
          CONDENSE: wa_final-todate, wa_final-fromdate, wa_final-monthly.
          APPEND wa_final TO it_final.
          CLEAR: wa_final,lv_fromdate,lv_monthly,lv_todate.
        ENDLOOP.


      ELSEIF lv_reporttype_low = 'PRODUCTION'.

        SELECT      materialdocumentyear,
                    materialdocument,
                    materialdocumentitem,
                    material,
                    entryunit,
                    quantityinbaseunit,
                    postingdate,
                    goodsmovementtype
        FROM i_materialdocumentitem_2
                                        WHERE material IN @r_matnr AND
                                              postingdate IN @r_todate AND
                                              goodsmovementtype IN ( '101','102' ,'531','532' )
                                        INTO  TABLE @it_high_materials.


        LOOP AT it_high_materials INTO wa_high_materials.
          MOVE-CORRESPONDING wa_high_materials TO wa_high_matcollect.

          IF wa_high_materials-goodsmovementtype = '102' OR
             wa_high_materials-goodsmovementtype = '532'.

            wa_high_matcollect-quantityinbaseunit = wa_high_materials-quantityinbaseunit * -1.
          ENDIF.

          COLLECT wa_high_matcollect INTO it_high_matcollect.
        ENDLOOP.


        IF it_high_matcollect IS NOT INITIAL.
          SELECT product,
                 productdescription
           FROM i_productdescription
                     FOR ALL ENTRIES IN @it_high_matcollect
                     WHERE product EQ @it_high_matcollect-material
                     INTO TABLE @it_productdesc.

        ENDIF.

        SELECT    materialdocumentyear,
                  materialdocument,
                  materialdocumentitem,
                  material,
                  entryunit,
                  quantityinbaseunit,
                  postingdate,
                  goodsmovementtype
                  FROM i_materialdocumentitem_2
                                     WHERE material IN @r_matnr AND
                                           postingdate IN @r_month AND
                                           goodsmovementtype IN ( '101','102','531','532' )
                                      INTO  TABLE @it_materials.


        it_materials_101 = it_materials.
        DELETE it_materials_101 WHERE goodsmovementtype = '102'.
        DELETE it_materials_101 WHERE goodsmovementtype = '532'.

        LOOP AT it_high_matcollect INTO wa_high_matcollect.
          LOOP AT it_materials INTO wa_materials WHERE material = wa_high_matcollect-material.
            IF wa_materials-postingdate EQ lv_date_high.
              IF wa_materials-goodsmovementtype = '102' OR wa_materials-goodsmovementtype = '532'.
                lv_fromdate = lv_fromdate + (  wa_materials-quantityinbaseunit * -1 ).
              ELSE.
                lv_fromdate = lv_fromdate + wa_materials-quantityinbaseunit.
              ENDIF.
            ENDIF.

            IF wa_materials-goodsmovementtype = '102' OR wa_materials-goodsmovementtype = '532'.
              lv_monthly = lv_monthly +  ( wa_materials-quantityinbaseunit * -1 ).
            ELSE.
              lv_monthly = lv_monthly + wa_materials-quantityinbaseunit.
            ENDIF.

          ENDLOOP.

          READ TABLE it_productdesc INTO wa_productdesc WITH KEY product = wa_high_matcollect-material.
          IF sy-subrc = 0.
            wa_final-productdescription = wa_productdesc-productdescription.
          ENDIF.

          MOVE-CORRESPONDING wa_high_matcollect TO wa_final.
          wa_final-fromdate = lv_fromdate.
          wa_final-monthly = lv_monthly.
          wa_final-todate = wa_high_matcollect-quantityinbaseunit.
          CONDENSE: wa_final-todate, wa_final-fromdate, wa_final-monthly.
          APPEND wa_final TO it_final.
          CLEAR: wa_final,lv_fromdate,lv_monthly,lv_todate.
        ENDLOOP.



      ELSEIF lv_reporttype_low = 'CONSUMPTIO'.

        SELECT      materialdocumentyear,
                    materialdocument,
                    materialdocumentitem,
                    material,
                    entryunit,
                    quantityinbaseunit,
                    postingdate,
                    goodsmovementtype
        FROM i_materialdocumentitem_2
                                        WHERE material IN @r_matnr AND
                                              postingdate IN @r_todate AND
                                              goodsmovementtype IN ( '261','262' )
                                        INTO  TABLE @it_high_materials.


        LOOP AT it_high_materials INTO wa_high_materials.
          MOVE-CORRESPONDING wa_high_materials TO wa_high_matcollect.

          IF wa_high_materials-goodsmovementtype = '262'.
            wa_high_matcollect-quantityinbaseunit = wa_high_materials-quantityinbaseunit * -1.
          ENDIF.

          COLLECT wa_high_matcollect INTO it_high_matcollect.
        ENDLOOP.


        IF it_high_matcollect IS NOT INITIAL.
          SELECT product,
                 productdescription
           FROM i_productdescription
                     FOR ALL ENTRIES IN @it_high_matcollect
                     WHERE product EQ @it_high_matcollect-material
                     INTO TABLE @it_productdesc.

        ENDIF.

        SELECT    materialdocumentyear,
                  materialdocument,
                  materialdocumentitem,
                  material,
                  entryunit,
                  quantityinbaseunit,
                  postingdate,
                  goodsmovementtype
                  FROM i_materialdocumentitem_2
                                     WHERE material IN @r_matnr AND
                                           postingdate IN @r_month AND
                                           goodsmovementtype IN ( '261','262'  )
                                      INTO  TABLE @it_materials.


        it_materials_101 = it_materials.
        DELETE it_materials_101 WHERE goodsmovementtype = '262'.

        LOOP AT it_high_matcollect INTO wa_high_matcollect.
          LOOP AT it_materials INTO wa_materials WHERE material = wa_high_matcollect-material.
            IF wa_materials-postingdate EQ lv_date_high.
              IF wa_materials-goodsmovementtype = '262'.
                lv_fromdate = lv_fromdate + (  wa_materials-quantityinbaseunit * -1 ).
              ELSE.
                lv_fromdate = lv_fromdate + wa_materials-quantityinbaseunit.
              ENDIF.
            ENDIF.

            IF wa_materials-goodsmovementtype = '262'.
              lv_monthly = lv_monthly +  ( wa_materials-quantityinbaseunit * -1 ).
            ELSE.
              lv_monthly = lv_monthly + wa_materials-quantityinbaseunit.
            ENDIF.

          ENDLOOP.

          READ TABLE it_productdesc INTO wa_productdesc WITH KEY product = wa_high_matcollect-material.
          IF sy-subrc = 0.
            wa_final-productdescription = wa_productdesc-productdescription.
          ENDIF.

          MOVE-CORRESPONDING wa_high_matcollect TO wa_final.
          wa_final-fromdate = lv_fromdate.
          wa_final-monthly = lv_monthly.
          wa_final-todate = wa_high_matcollect-quantityinbaseunit.
          APPEND wa_final TO it_final.
          CONDENSE: wa_final-todate, wa_final-fromdate, wa_final-monthly.
          CLEAR: wa_final,lv_fromdate,lv_monthly,lv_todate.
        ENDLOOP.



      ELSEIF lv_reporttype_low = 'SALE'.

        SELECT      materialdocumentyear,
                    materialdocument,
                    materialdocumentitem,
                    material,
                    entryunit,
                    quantityinbaseunit,
                    postingdate,
                    goodsmovementtype
        FROM i_materialdocumentitem_2
                                        WHERE material      IN @r_matnr AND
                                              postingdate   IN @r_todate AND
                                              goodsmovementtype IN ( '601','602' )
                                        INTO  TABLE @it_high_materials.


        LOOP AT it_high_materials INTO wa_high_materials.
          MOVE-CORRESPONDING wa_high_materials TO wa_high_matcollect.

          IF wa_high_materials-goodsmovementtype = '602'.
            wa_high_matcollect-quantityinbaseunit = wa_high_materials-quantityinbaseunit * -1.
          ENDIF.

          COLLECT wa_high_matcollect INTO it_high_matcollect.
        ENDLOOP.


        IF it_high_matcollect IS NOT INITIAL.
          SELECT product,
                 productdescription
           FROM i_productdescription
                     FOR ALL ENTRIES IN @it_high_matcollect
                     WHERE product EQ @it_high_matcollect-material
                     INTO TABLE @it_productdesc.

        ENDIF.

        SELECT    materialdocumentyear,
                  materialdocument,
                  materialdocumentitem,
                  material,
                  entryunit,
                  quantityinbaseunit,
                  postingdate,
                  goodsmovementtype
                  FROM i_materialdocumentitem_2
                                     WHERE material     IN @r_matnr AND
                                           postingdate  IN @r_month AND
                                           goodsmovementtype IN ( '601','602'  )
                                      INTO  TABLE @it_materials.



        it_materials_101 = it_materials.
        DELETE it_materials_101 WHERE goodsmovementtype = '602'.

        LOOP AT it_high_matcollect INTO wa_high_matcollect.
          LOOP AT it_materials INTO wa_materials WHERE material = wa_high_matcollect-material.
            IF wa_materials-postingdate EQ lv_date_high.
              IF wa_materials-goodsmovementtype = '602'.
                lv_fromdate = lv_fromdate + (  wa_materials-quantityinbaseunit * -1 ).
              ELSE.
                lv_fromdate = lv_fromdate + wa_materials-quantityinbaseunit.
              ENDIF.
            ENDIF.

            IF wa_materials-goodsmovementtype = '602'.
              lv_monthly = lv_monthly +  ( wa_materials-quantityinbaseunit * -1 ).
            ELSE.
              lv_monthly = lv_monthly + wa_materials-quantityinbaseunit.
            ENDIF.

          ENDLOOP.

          READ TABLE it_productdesc INTO wa_productdesc WITH KEY product = wa_high_matcollect-material.
          IF sy-subrc = 0.
            wa_final-productdescription = wa_productdesc-productdescription.
          ENDIF.

          MOVE-CORRESPONDING wa_high_matcollect TO wa_final.
          wa_final-fromdate = lv_fromdate.
          wa_final-monthly = lv_monthly.
          wa_final-todate = wa_high_matcollect-quantityinbaseunit.
          APPEND wa_final TO it_final.
          CONDENSE: wa_final-todate, wa_final-fromdate, wa_final-monthly.
          CLEAR: wa_final,lv_fromdate,lv_monthly,lv_todate.
        ENDLOOP.


      ELSEIF lv_reporttype_low = 'R.S. FEED'.

        SELECT      materialdocumentyear,
                    materialdocument,
                    materialdocumentitem,
                    material,
                    entryunit,
                    quantityinbaseunit,
                    postingdate,
                    goodsmovementtype
        FROM i_materialdocumentitem_2
                                        WHERE material IN @r_matnr AND
                                              postingdate IN @r_todate AND
                                              goodsmovementtype IN ( '261','262' )
                                        INTO  TABLE @it_high_materials.


        LOOP AT it_high_materials INTO wa_high_materials.
          MOVE-CORRESPONDING wa_high_materials TO wa_high_matcollect.

          IF wa_high_materials-goodsmovementtype = '262'.
            wa_high_matcollect-quantityinbaseunit = wa_high_materials-quantityinbaseunit * -1.
          ENDIF.

          COLLECT wa_high_matcollect INTO it_high_matcollect.
        ENDLOOP.


        IF it_high_matcollect IS NOT INITIAL.
          SELECT product,
                 productdescription
           FROM i_productdescription
                     FOR ALL ENTRIES IN @it_high_matcollect
                     WHERE product EQ @it_high_matcollect-material
                     INTO TABLE @it_productdesc.

        ENDIF.

        SELECT    materialdocumentyear,
                  materialdocument,
                  materialdocumentitem,
                  material,
                  entryunit,
                  quantityinbaseunit,
                  postingdate,
                  goodsmovementtype
                  FROM i_materialdocumentitem_2
                                     WHERE material IN @r_matnr AND
                                           postingdate IN @r_month AND
                                           goodsmovementtype IN ( '261','262'  )
                                      INTO  TABLE @it_materials.



        it_materials_101 = it_materials.
        DELETE it_materials_101 WHERE goodsmovementtype = '262'.

        LOOP AT it_high_matcollect INTO wa_high_matcollect.
          LOOP AT it_materials INTO wa_materials WHERE material = wa_high_matcollect-material.
            IF wa_materials-postingdate EQ lv_date_high.
              IF wa_materials-goodsmovementtype = '262'.
                lv_fromdate = lv_fromdate + (  wa_materials-quantityinbaseunit * -1 ).
              ELSE.
                lv_fromdate = lv_fromdate + wa_materials-quantityinbaseunit.
              ENDIF.
            ENDIF.

            IF wa_materials-goodsmovementtype = '262'.
              lv_monthly = lv_monthly +  ( wa_materials-quantityinbaseunit * -1 ).
            ELSE.
              lv_monthly = lv_monthly + wa_materials-quantityinbaseunit.
            ENDIF.

          ENDLOOP.

          READ TABLE it_productdesc INTO wa_productdesc WITH KEY product = wa_high_matcollect-material.
          IF sy-subrc = 0.
            wa_final-productdescription = wa_productdesc-productdescription.
          ENDIF.

          MOVE-CORRESPONDING wa_high_matcollect TO wa_final.
          wa_final-fromdate = lv_fromdate.
          wa_final-monthly = lv_monthly.
          wa_final-todate = wa_high_matcollect-quantityinbaseunit.
          CONDENSE: wa_final-todate, wa_final-fromdate, wa_final-monthly.
          APPEND wa_final TO it_final.
          CLEAR: wa_final,lv_fromdate,lv_monthly,lv_todate.
        ENDLOOP.




      ELSEIF lv_reporttype_low = 'LOSSES'.


        SELECT      materialdocumentyear,
                    materialdocument,
                    materialdocumentitem,
                    material,
                    entryunit,
                    quantityinbaseunit,
                    postingdate,
                    goodsmovementtype
        FROM i_materialdocumentitem_2
                                        WHERE material IN @r_matnr AND
                                              postingdate IN @r_todate AND
                                              goodsmovementtype IN ( '701','702' )
                                        INTO  TABLE @it_high_materials.

        LOOP AT it_high_materials INTO wa_high_materials.
          MOVE-CORRESPONDING wa_high_materials TO wa_high_matcollect.

          IF wa_high_materials-goodsmovementtype = '702'.
            wa_high_matcollect-quantityinbaseunit = wa_high_materials-quantityinbaseunit * -1.
          ENDIF.

          COLLECT wa_high_matcollect INTO it_high_matcollect.
        ENDLOOP.


        IF it_high_matcollect IS NOT INITIAL.
          SELECT product,
                 productdescription
           FROM i_productdescription
                     FOR ALL ENTRIES IN @it_high_matcollect
                     WHERE product EQ @it_high_matcollect-material
                     INTO TABLE @it_productdesc.

        ENDIF.

        SELECT    materialdocumentyear,
                  materialdocument,
                  materialdocumentitem,
                  material,
                  entryunit,
                  quantityinbaseunit,
                  postingdate,
                  goodsmovementtype
                  FROM i_materialdocumentitem_2
                                     WHERE material IN @r_matnr AND
                                           postingdate IN @r_month AND
                                           goodsmovementtype IN ( '701','702'  )
                                      INTO  TABLE @it_materials.



        it_materials_101 = it_materials.
        DELETE it_materials_101 WHERE goodsmovementtype = '702'.

        LOOP AT it_high_matcollect INTO wa_high_matcollect.
          LOOP AT it_materials INTO wa_materials WHERE material = wa_high_matcollect-material.
            IF wa_materials-postingdate EQ lv_date_high.
              IF wa_materials-goodsmovementtype = '702'.
                lv_fromdate = lv_fromdate + (  wa_materials-quantityinbaseunit * -1 ).
              ELSE.
                lv_fromdate = lv_fromdate + wa_materials-quantityinbaseunit.
              ENDIF.
            ENDIF.

            IF wa_materials-goodsmovementtype = '702'.
              lv_monthly = lv_monthly +  ( wa_materials-quantityinbaseunit * -1 ).
            ELSE.
              lv_monthly = lv_monthly + wa_materials-quantityinbaseunit.
            ENDIF.

          ENDLOOP.

          READ TABLE it_productdesc INTO wa_productdesc WITH KEY product = wa_high_matcollect-material.
          IF sy-subrc = 0.
            wa_final-productdescription = wa_productdesc-productdescription.
          ENDIF.

          MOVE-CORRESPONDING wa_high_matcollect TO wa_final.
          wa_final-fromdate = lv_fromdate.
          wa_final-monthly = lv_monthly.
          wa_final-todate = wa_high_matcollect-quantityinbaseunit.
          CONDENSE: wa_final-todate, wa_final-fromdate, wa_final-monthly.
          APPEND wa_final TO it_final.
          CLEAR: wa_final,lv_fromdate,lv_monthly,lv_todate.
        ENDLOOP.


      ELSEIF lv_reporttype_low = 'OPENING ST'.

        TYPES: BEGIN OF ty_matcollect_today,
                 material           TYPE matnr,
                 entryunit          TYPE char4,
                 quantityinbaseunit TYPE menge_d,
               END OF ty_matcollect_today.

        DATA: it_matcollect_today  TYPE TABLE OF ty_matcollect_today,
              wa_matcollect_today  TYPE          ty_matcollect_today,
              it_matcollect_todate TYPE TABLE OF ty_matcollect_today,
              wa_matcollect_todate TYPE          ty_matcollect_today.

        LOOP AT it_date INTO wa_date_selection.
          MOVE-CORRESPONDING wa_date_selection TO w_today.
          w_today-low = '20200101'.
          w_today-high = w_today-high - 1.
          APPEND w_today TO r_today.
        ENDLOOP.

        SELECT      materialdocumentyear,
                    materialdocument,
                    materialdocumentitem,
                    material,
                    entryunit,
                    quantityinbaseunit,
                    postingdate,
                    goodsmovementtype,
                    debitcreditcode,
                    isautomaticallycreated
        FROM i_materialdocumentitem_2
                                        WHERE material IN @r_matnr AND
                                              postingdate IN @r_today
                                        INTO  TABLE @DATA(it_material_today).


        DELETE it_material_today WHERE isautomaticallycreated = 'X'.
        DELETE it_material_today WHERE goodsmovementtype = '103'.

        LOOP AT it_material_today INTO DATA(wa_material_today).
          MOVE-CORRESPONDING wa_material_today TO wa_matcollect_today.

          IF wa_material_today-debitcreditcode = 'H'.
            wa_matcollect_today-quantityinbaseunit = wa_material_today-quantityinbaseunit * -1.
          ENDIF.

          COLLECT wa_matcollect_today INTO it_matcollect_today.
          CLEAR:  wa_matcollect_today.
        ENDLOOP.


        SELECT      materialdocumentyear,
                    materialdocument,
                    materialdocumentitem,
                    material,
                    entryunit,
                    quantityinbaseunit,
                    postingdate,
                    goodsmovementtype,
                    debitcreditcode,
                    isautomaticallycreated
        FROM i_materialdocumentitem_2
                                        WHERE material IN @r_matnr AND
                                              postingdate IN @r_todate
                                        INTO  TABLE @DATA(it_material_todate).

        DELETE it_material_todate WHERE isautomaticallycreated = 'X'.
        DELETE it_material_todate WHERE goodsmovementtype = '103'.

        LOOP AT it_material_todate INTO DATA(wa_material_todate).
          MOVE-CORRESPONDING wa_material_todate TO wa_matcollect_todate.

          IF wa_material_todate-debitcreditcode = 'H'.
            wa_matcollect_todate-quantityinbaseunit = wa_material_todate-quantityinbaseunit * -1.
          ENDIF.

          COLLECT wa_matcollect_todate INTO it_matcollect_todate.
          CLEAR: wa_matcollect_todate.
        ENDLOOP.

        IF it_matcollect_todate IS NOT INITIAL.
          SELECT product,
                 productdescription
           FROM i_productdescription
                     FOR ALL ENTRIES IN @it_matcollect_todate
                     WHERE product EQ @it_matcollect_todate-material
                     INTO TABLE @it_productdesc.

        ENDIF.


        LOOP AT it_matcollect_todate INTO wa_matcollect_todate.
          MOVE-CORRESPONDING wa_matcollect_todate TO wa_final.
          wa_final-todate = wa_matcollect_todate-quantityinbaseunit.

          READ TABLE it_matcollect_today INTO wa_matcollect_today WITH KEY material = wa_matcollect_todate-material.
          IF sy-subrc = 0.
            wa_final-fromdate = wa_matcollect_today-quantityinbaseunit.
          ENDIF.

          READ TABLE it_productdesc INTO wa_productdesc WITH KEY product = wa_matcollect_todate-material.
          IF sy-subrc = 0.
            wa_final-productdescription = wa_productdesc-productdescription.
          ENDIF.

          CONDENSE: wa_final-todate, wa_final-fromdate, wa_final-monthly.

          APPEND wa_final TO it_final.
          CLEAR: wa_final,lv_fromdate,lv_monthly,lv_todate.
        ENDLOOP.

      ENDIF.


      DELETE ADJACENT DUPLICATES FROM  it_final COMPARING material.

      IF io_request->is_total_numb_of_rec_requested(  ).
        io_response->set_total_number_of_records( lines( it_final ) ).
        io_response->set_data( it_final ).
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

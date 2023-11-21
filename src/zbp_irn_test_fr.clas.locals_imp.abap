CLASS lhc_zirntest DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zirntest RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zirntest.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zirntest.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zirntest.

    METHODS read FOR READ
      IMPORTING keys FOR READ zirntest RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zirntest.

ENDCLASS.

CLASS lhc_zirntest IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.
    DATA: lv_url TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf'.
    DATA: lo_http_client TYPE REF TO if_web_http_client.
    DATA(lo_request) = lo_http_client->get_http_request( ).
  DATA: LT_MATCHES  TYPE MATCH_RESULT_TAB,
        LT_MATCHES1 TYPE MATCH_RESULT_TAB,

        LT_FIELDS   TYPE TIHTTPNVP,
        LS_FIELDS   like line of LT_FIELDS .


    lo_http_client = cl_web_http_client_manager=>create_by_http_destination(
                     i_destination = cl_http_destination_provider=>create_by_url( lv_url ) ).

                        lo_request->set_header_fields(  VALUE #(
               (  name = 'Content-Type' Value = 'application/json')
               (  name = 'Accept' Value = 'application/json')
               (  name = '~request_uri' Value = '/irisgst/mgmt/login')
                )  ).





  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zirn_test_fr DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zirn_test_fr IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

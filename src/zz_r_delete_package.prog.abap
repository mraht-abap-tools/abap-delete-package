*&---------------------------------------------------------------------*
*& Report zz_r_delete_package
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zz_r_delete_package.

INCLUDE zz_r_delete_package_i00.
INCLUDE zz_r_delete_package_i01.
INCLUDE zz_r_delete_package_i02.

##TODO " Support handling of transport requests

PARAMETERS: p_pckg TYPE devclass,
            p_subs AS CHECKBOX DEFAULT abap_true.

START-OF-SELECTION.
  DATA: lv_pckg_parent TYPE parentcl,
        lt_package     TYPE tt_package,
        lt_package_tmp TYPE tt_package,
        lt_object      TYPE tt_object.

  ziot_cl_bs_log=>get_instance( )->init(
    EXPORTING
      iv_subobject = 'BASIS'
      iv_extnumber = 'Delete Package'
      iv_lgnum     = zwmgc_lgnum ).

  CHECK p_pckg CN ' _0'.

  lcl_program_manager=>get_instance( )->init( iv_pckg = p_pckg
                                              iv_subs = p_subs ).

  lcl_program_manager=>get_instance( )->determine_packages( ).

  lcl_program_manager=>get_instance( )->determine_objects( ).

  lcl_program_manager=>get_instance( )->delete_objects( ).

  lcl_program_manager=>get_instance( )->delete_packages( ).

  lcl_program_manager=>get_instance( )->update_index( ).

  ziot_cl_bs_log=>get_instance( )->save( ).
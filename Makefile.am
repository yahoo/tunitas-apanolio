# This is a GNU -*- Makefile -*- fragment that is included by Automake
# Copyright Yahoo Inc. 2021
# Licensed under the terms of the Apache-2.0 license.
# For terms, see the LICENSE file at https://github.com/yahoo/tunitas-apanolio/blob/master/LICENSE
# For terms, see the LICENSE file at https://git.tunitas.technology/all/services/apanolio/tree/LICENSE

# silent-rules has no effect, see configure.ac
# no can do:  -Wall -Werror
AUTOMAKE_OPTIONS = no-define subdir-objects foreign
ACLOCAL_AMFLAGS = -I m4

LOCAL_ServerRoot = ./httpd

default:
include tests/Makefrag.am
include @temerarious_flagship_datadir@/am/build.am
#
# configure.ac:  HGTW_CONFIG_SUBMODULES([submodules], [ ...list...])
# Makefile.am    SUBDIRS = @subdirs@

#
# Reminder: these variables are needed for on-site development use only
#           they are not needed for a "simple" build.
# They must match one-for-one the TF_WITH_MODULE(...) declarations in configure.ac
# configure.ac: TF_WITH_MODULE(name), TF_WITH_NONSTD(name, ...etc...)
# Makefile.am:  DEVELOPMENT_AREAS, TESTING_AREAS, INSTALLATION_AREAS
#
DEVELOPMENT_AREAS = \
  $(apache_httpd_api_prefix) \
  $(hyperledger_prefix) \
  $(hyperledger_fabric_prefix) \
  $(hyperledger_fabric_ca_prefix) \
  $(hyperledger_fabric_db_prefix) \
  $(module_cli_core_prefix) \
  $(module_cli_shell_prefix) \
  $(module_langu_prefix) \
  $(module_level_prefix) \
  $(module_json_prefix) \
  $(module_mysql_prefix) \
  $(module_nonstd_prefix) \
  $(module_pgsql_prefix) \
  $(module_rabinpoly_prefix) \
  $(module_ramcloud_prefix) \
  $(module_sqlite_prefix) \
  $(module_sys_prefix) \
  $(tunitas_basics_prefix) \
  $(tunitas_butano_prefix) \
  $(tunitas_scarpet_prefix) \
  $(deprecated_DEVELOPMENT_AREAS) \
  $(end)
TESTING_AREAS = \
  $(module_cppunit_prefix) \
  $(module_rigging_prefix) \
  $(deprecated_TESTING_AREAS) \
  $(end)
INSTALLATION_AREAS = \
  $(nonstd_boost_prefix) \
  $(nonstd_cppunit_prefix) \
  $(nonstd_gcc_prefix) \
  $(nonstd_sqlite_prefix) \
  $(std_scold_prefix) \
  $(deprecated_INSTALLATION_AREAS) \
  $(end)

include lib/libmod_apanolio.am
include noinst/lib/libmod_apanolio.am

include lib/libtunitas-apanolio.am
include noinst/lib/libtunitas-apanolio.am
include noinst/lib/libtunitas-apanolio-resting.am
include noinst/lib/libtunitas-apanolio-schema.am
include noinst/lib/libtunitas-apanolio-storage.am
include check/bin/unit.am

include noinst/lib/libwant.am
include noinst/lib/libautotools-autoconf+tunitas-apanolio.am

INSTALL_MODULES = \
  $(noinst_lib_libautotools_autoconf_tunitas_apanolio_la_MODULES) \
  $(noinst_lib_libmod_apanolio_la_MODULES) \
  $(noinst_lib_libtunitas_apanolio_la_MODULES) \
  $(noinst_lib_libtunitas_apanolio_resting_la_MODULES) \
  $(noinst_lib_libtunitas_apanolio_schema_la_MODULES) \
  $(noinst_lib_libtunitas_apanolio_storage_la_MODULES) \
  $(noinst_lib_libwant_la_MODULES) \
  $(end)

bin_PROGRAMS = \
  $(end)
noinst_LTLIBRARIES = \
  noinst/lib/libtunitas-apanolio.la \
  noinst/lib/libtunitas-apanolio-resting.la \
  noinst/lib/libtunitas-apanolio-schema.la \
  noinst/lib/libtunitas-apanolio-storage.la \
  noinst/lib/libautotools-autoconf+tunitas-apanolio.la \
  noinst/lib/libmod_apanolio.la \
  noinst/lib/libwant.la \
  $(end)
# WATCHOUT - these MUST be listed in this order so that the sequential install rule will allow the linker to process them.
#            libtool linking of libmod_apanolio.la MUST see the installed libtunitas-apanolio.la in order to be "finished"
lib_LTLIBRARIES = \
  lib/libtunitas-apanolio.la \
  lib/libmod_apanolio.la \
  $(end)
check_PROGRAMS = \
  check/bin/unit \
  $(end)
check_LTLIBRARIES = \
  $(end)

# NOPE ... you can't say install depends upon check because
# then automake assesses that this is *the* install rule.
#install: check
default: all

# [[REMOVEWHEN]] hypogeal-twilight has work that subsumes this, think hypogeal-twilight >= 0.47.0 (or when the sun grows cold)
Makefile_nonstd_PACKAGE_CPPFLAGS_SET = @nonstd_boost_CPPFLAGS@ @nonstd_gcc_CPPFLAGS@ @nonstd_leveldb_CPPFLAGS@ @nonstd_sqlite_CPPFLAGS@
Makefile_nonstd_PACKAGE_CFLAGS_SET   = @nonstd_boost_CFLAGS@   @nonstd_gcc_CFLAGS@   @nonstd_leveldb_CFLAGS@   @nonstd_sqlite_CFLAGS@
Makefile_nonstd_PACKAGE_CXXFLAGS_SET = @nonstd_boost_CXXFLAGS@ @nonstd_gcc_CXXFLAGS@ @nonstd_leveldb_CXXFLAGS@ @nonstd_sqlite_CXXFLAGS@
Makefile_nonstd_PACKAGE_LDFLAGS_SET  = @nonstd_boost_LDFLAGS@  @nonstd_gcc_LDFLAGS@  @nonstd_leveldb_LDFLAGS@  @nonstd_sqlite_LDFLAGS@
Makefile_nonstd_CHECK_CPPFLAGS_SET   = @nonstd_cppunit_CPPFLAGS@
Makefile_nonstd_CHECK_CFLAGS_SET     = @nonstd_cppunit_CFLAGS@
Makefile_nonstd_CHECK_CXXFLAGS_SET   = @nonstd_cppunit_CXXFLAGS@
Makefile_nonstd_CHECK_LDFLAGS_SET    = @nonstd_cppunit_LDFLAGS@

Makefile_COMPILER_CPPFLAGS_SET = @CPPFLAGS_gcc@ 
Makefile_COMPILER_CFLAGS_SET   =   @CFLAGS_gcc@   @CFLAGS_gdb@
Makefile_COMPILER_CXXFLAGS_SET = @CXXFLAGS_gcc@ @CXXFLAGS_gdb@ -pthread
Makefile_COMPILER_LDFLAGS_SET  =  @LDFLAGS_gcc@  @LDFLAGS_gdb@ -lpthread @libstd_filesystem@

Makefile_PACKAGE_CPPFLAGS_SET  = @CPPFLAGS_httpd@ @CPPFLAGS_apr@ @CPPFLAGS_apreq@ @CPPFLAGS_leveldb@ @CPPFLAGS_sqlite@ @CPPFLAGS_uuid@
Makefile_PACKAGE_CFLAGS_SET    =   @CFLAGS_httpd@   @CFLAGS_apr@   @CFLAGS_apreq@   @CFLAGS_leveldb@   @CFLAGS_sqlite@   @CFLAGS_uuid@
Makefile_PACKAGE_CXXFLAGS_SET  = @CXXFLAGS_httpd@ @CXXFLAGS_apr@ @CXXFLAGS_apreq@ @CXXFLAGS_leveldb@ @CXXFLAGS_sqlite@ @CXXFLAGS_uuid@
Makefile_PACKAGE_LDFLAGS_SET   =  @LDFLAGS_httpd@  @LDFLAGS_apr@  @LDFLAGS_apreq@  @LDFLAGS_leveldb@  @LDFLAGS_sqlite@  @LDFLAGS_uuid@

#                                                  if    did not substitute away                      then use this
#                                                  |           |                                      |            else use the substitution
#                                                  |           |              @CPPFLAGS_no_install@   |            |
#                                                  |           |              |                       |            |
#                                                  |           |              |                       |            |
#                                                  v           v              v                       v            v
Makefile_CHECK_CPPFLAGS_SET = @CPPFLAGS_cppunit@ $(if $(filter %_no_install@, @CPPFLAGS_no_install@), $(empty),    @CPPFLAGS_no_install@)
Makefile_CHECK_CFLAGS_SET   =   @CFLAGS_cppunit@ $(if $(filter %_no_install@, @CFLAGS_no_install@),   $(empty),    @CFLAGS_no_install@)
Makefile_CHECK_CXXFLAGS_SET = @CXXFLAGS_cppunit@ $(if $(filter %_no_install@, @CXXFLAGS_no_install@), $(empty),    @CXXFLAGS_no_install@)
Makefile_CHECK_LDFLAGS_SET  =  @LDFLAGS_cppunit@ $(if $(filter %_no_install@, @LDFLAGS_no_install@),  -no-install, @LDFLAGS_no_install@)

# See the 'Usage' statement in @hypogeal_twilight_datadir@/mk/toolflags.mk
# See the definitions and expected usage of
#    PACKAGE_${TOOL}FLAGS_SET
#    CHECK_${TOOL}FLAGS_SET
#    AND_CHECK_${TOOL}FLAGS_SET
AM_CPPFLAGS = $(PACKAGE_CPPFLAGS_SET)
AM_CFLAGS   = $(PACKAGE_CFLAGS_SET)
AM_CXXFLAGS = $(PACKAGE_CXXFLAGS_SET)
AM_LDFLAGS  = $(warning AM_LDFLAGS is not used by automake Makefile final-link invocations) $(PACKAGE_LDFLAGS_SET)

deprecated_DEVELOPMENT_AREAS = \
  $(module_boost_prefix) \
  $(module_c_prefix) \
  $(module_cli_prefix) \
  $(module_format_prefix) \
  $(module_leveldb_prefix) \
  $(module_options_prefix) \
  $(module_posix_prefix) \
  $(module_rabinpoly_prefix) \
  $(module_shell_prefix) \
  $(module_std_prefix) \
  $(module_slurp_prefix) \
  $(module_string_prefix) \
  $(module_uuid_prefix) \
  $(end)
deprecated_TESTING_AREAS = \
  $(module_cppunit_prefix) \
  $(module_rigging_prefix) \
  $(end)
deprecated_INSTALLATION_AREAS = \
  $(nonstd_boost_prefix) \
  $(nonstd_cppunit_prefix) \
  $(end)


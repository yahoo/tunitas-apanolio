# This is a GNU -*- Makefile -*- fragment that is included by Automake
# Copyright 2019-2019, Oath Inc.
# Licensed under the terms of the Apache-2.0 license.
# See the LICENSE file in https://github.com/yahoo/tunitas-apanolio/blob/master/LICENSE for terms.

# silent-rules has no effect, see configure.ac
# no can do:  -Wall -Werror
AUTOMAKE_OPTIONS = no-define subdir-objects foreign
ACLOCAL_AMFLAGS = -I m4

LOCAL_ServerRoot = ./httpd

default:
include @temerarious_flagship_datadir@/am/build.am
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
  $(module_boost_prefix) \
  $(module_c_prefix) \
  $(module_format_prefix) \
  $(module_leveldb_prefix) \
  $(module_mysql_prefix) \
  $(module_nonstd_prefix) \
  $(module_options_prefix) \
  $(module_posix_prefix) \
  $(module_pgsql_prefix) \
  $(module_rabinpoly_prefix) \
  $(module_ramcloud_prefix) \
  $(module_sqlite_prefix) \
  $(module_std_prefix) \
  $(module_slurp_prefix) \
  $(module_sqlite_prefix) \
  $(module_string_prefix) \
  $(module_sys_prefix) \
  $(module_uuid_prefix) \
  $(tunitas_basics_prefix) \
  $(tunitas_butano_prefix) \
  $(tunitas_scarpet_prefix) \
  $(end)
TESTING_AREAS = \
  $(module_cppunit_prefix) \
  $(module_rigging_prefix) \
  $(end)
INSTALLATION_AREAS = \
  $(nonstd_boost_prefix) \
  $(nonstd_cppunit_prefix) \
  $(nonstd_gcc_prefix) \
  $(nonstd_sqlite_prefix) \
  $(std_scold_prefix) \
  $(end)

include src/autotools/autoconf/Makefrag.am
include src/mod/apanolio/Makefrag.am
include src/tunitas/apanolio/Makefrag.am
include src/tunitas/apanolio/resting/Makefrag.am
include src/tunitas/apanolio/storage/Makefrag.am
include src/want/Makefrag.am
include src/tests/unit/Makefrag.am

#
# The following three definitions must be consistent
#
# Makefile.am module_SOURCE_SET    (future)         the modules (cut & paste header files)
# Makefile.am module_BB_SOURCE_SET (deprecating)    them.
# Makefile.am lib_LTLIBRARIES      (current)        the DSO & static libraries
# tunitas-apanolio.spec the '%files devel' stanza must list the 
#
# [[FIXTHIS]] the plurality here is problematic ... done multiple ways
lib_libtunitas_apanolio_la_MODULE_SOURCES_SET = \
  $(lib_libautotools_autoconf_la_SOURCES) \
  $(lib_libmod_apanolio_la_SOURCES) \
  $(lib_libtunitas_apanolio_la_SOURCES) \
  $(lib_libwant_la_SOURCES) \
  $(end)
# [[FIXTHIS]] module_BB_SOURCE_SET should be deprecating real soon now, move to use module_SOURCE_SET, whenever it is ready)
module_BB_SOURCE_SET = \
  $(lib_libtunitas_apanolio_la_MODULE_SOURCES_SET) \
  $(end)
module_SOURCE_SET = # NO NOT READY YET ---> $(lib_libtunitas_scarpet_la_MODULE_SOURCES_SET)

bin_PROGRAMS = \
  $(end)
noinst_LTLIBRARIES = \
  $(lib_libautotools_autoconf_la) \
  $(lib_libtunitas_apanolio_resting_la) \
  $(lib_libtunitas_apanolio_storage_la) \
  $(lib_libwant_la) \
  $(end)
# WATCHOUT - these MUST be listed in this order so that the sequential install rule will allow the linker to process them.
#            libtool linking of libmod_apanolio.la MUST see the installed libtunitas-apanolio.la in order to be "finished"
lib_LTLIBRARIES = \
  $(lib_libtunitas_apanolio_la) \
  $(lib_libmod_apanolio_la) \
  $(end)
check_PROGRAMS = \
  $(check_bin_unit) \
  $(end)
check_LTLIBRARIES = \
  $(end)

include tests/unit/Makefrag.am

if ENABLE_SERVER_TESTS
ENABLED_SERVER_TESTS = \
  tests/start-contact-stop.test \
  $(end)
else
ENABLED_SERVER_TESTS = 
endif

XFAIL_TESTS = \
  $(tests_unit_XFAIL_TESTS) \
  $(ENABLED_SERVER_XFAIL_TESTS)
  $(end)
TESTS = \
  $(tests_unit_TESTS) \
  $(ENABLED_SERVER_TESTS)
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
Makefile_CHECK_CPPFLAGS_SET    = @CPPFLAGS_cppunit@
Makefile_CHECK_CFLAGS_SET      =   @CFLAGS_cppunit@
Makefile_CHECK_CXXFLAGS_SET    = @CXXFLAGS_cppunit@
Makefile_CHECK_LDFLAGS_SET     =  @LDFLAGS_cppunit@ -no-install $(comment is the default in hypogeal-twilight >= 0:0.45)

# See the 'Usage' statement in @hypogeal_twilight_datadir@/mk/toolflags.mk
# See the definitions and expected usage of
#    PACKAGE_${TOOL}FLAGS_SET
#    CHECK_${TOOL}FLAGS_SET
#    AND_CHECK_${TOOL}FLAGS_SET
AM_CPPFLAGS = $(PACKAGE_CPPFLAGS_SET)
AM_CFLAGS   = $(PACKAGE_CFLAGS_SET)
AM_CXXFLAGS = $(PACKAGE_CXXFLAGS_SET)
AM_LDFLAGS  = $(warning AM_LDFLAGS is not used by automake Makefile final-link invocations) $(PACKAGE_LDFLAGS_SET)
# end

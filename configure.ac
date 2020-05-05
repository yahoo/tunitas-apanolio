dnl This is a GNU -*- autoconf -*- specification that is processed by Autoconf.
dnl Copyright 2019, Oath Inc.; Copyright 2020, Verizon Media
dnl Licensed under the terms of the Apache-2.0 license.
dnl For terms, see the LICENSE file at https://github.com/yahoo/tunitas-apanolio/blob/master/LICENSE
dnl For terms, see the LICENSE file at https://git.tunitas.technology/all/services/apanolio/tree/LICENSE

AC_INIT([apanolio], [0.1.0], [tunitas@verizonmedia.com])
TF_INIT(AC_PACKAGE_NAME, AC_PACKAGE_VERSION, AC_PACKAGE_BUGREPORT)

TF_COMPONENT_METADIRECTORY_TIERS
TF_ENABLE_CONFIGURE_VERBOSE dnl first so that TF_MSG_VERBOSE works
TF_ENABLE_GCC
TF_ENABLE_GDB
TF_ENABLE_GNU
TF_ENABLE_MOCK_BUILD

TF_WITH_STD([scold])
TF_WITH_STD([tunitas])

TF_WITH_SUBSYSTEM([temerarious-flagship], [], [The Tunitas Build System])
TF_WITH_SUBSYSTEM([tunitas-basics], [], [The Tunitas Basics])
TF_WITH_SUBSYSTEM([butano], [], [The Tunitas TCF Components])
TF_WITH_SUBSYSTEM([scarpet], [], [The Tunitas DID Resolver])

TF_MSG_VERBOSE([development subsystems (Apache)])
TF_WITH_SUBSYSTEM([apache-httpd-api], [apache_httpd_api], [Apache HTTPd API])

TF_MSG_VERBOSE([development subsystems (Hyperledger Fabric)])
dnl TF_WITH_SUBSYSTEM([hyperledger], [hyperledger], [Hyperledger API])
dnl TF_WITH_SUBSYSTEM([hyperledger-fabric], [hyperledger_fabric], [Hyperledger Fabric CA C++ API])
TF_WITH_SUBSYSTEM([hyperledger-fabric-ca], [hyperledger_fabric_ca], [Hyperledger Fabric CA C++ API])
TF_WITH_SUBSYSTEM([hyperledger-fabric-db], [hyperledger_fabric_db], [Hyperledger Fabric DB C++ API])

TF_MSG_VERBOSE([development subsystems (S.C.O.L.D.)])
TF_WITH_MODULE([boost])
TF_WITH_MODULE([c])
TF_WITH_MODULE([format])
TF_WITH_MODULE([leveldb])
TF_WITH_MODULE([half]) dnl mentioned in module-nonstd but you will not need it
TF_WITH_MODULE([json])
TF_WITH_MODULE([mysql])
TF_WITH_MODULE([nonstd])
TF_WITH_MODULE([options])
TF_WITH_MODULE([pgsql])
TF_WITH_MODULE([posix])
TF_WITH_MODULE([rabinpoly])
TF_WITH_MODULE([ramcloud])
TF_WITH_MODULE([slurp])
TF_WITH_MODULE([sqlite])
TF_WITH_MODULE([std])
TF_WITH_MODULE([string])
TF_WITH_MODULE([sys])
TF_WITH_MODULE([uuid])

dnl Storage systems
dnl [[FIXTHIS]] tie these to an --enable-engine=STORAGE type choice and require only what is really really needed.
m4_include([ac/with-storage.m4])
APANOLIO_WITH_STORAGE([leveldb])
APANOLIO_WITH_STORAGE([sqlite])
APANOLIO_WITH_STORAGE([mysql], [mysql++])
APANOLIO_WITH_STORAGE([pgsql], [pgsql++])

TF_MSG_VERBOSE([testing subsystems (alphabetical)])
TF_WITH_MODULE([cppunit])
TF_WITH_MODULE([rigging])

TF_MSG_VERBOSE([compiler-specific subsystems (alphabetical)])
dnl --with-std-scold is entailed above
dnl reminder ... boost & module-boost is unused herein, but module-curl will require it if you use that.
TF_WITH_NONSTD([boost], [boost], [a non-standard Boost])
TF_WITH_NONSTD([cppunit], [cppunit], [a non-standard CppUnit])
TF_WITH_NONSTD([gcc], [gcc], [a non-standard gcc, e.g. modernized gcc for C++11, C++14, C++17 and on unto C++2a])

TF_MSG_VERBOSE([system-side subsystems (alphabetical)])
TF_WITH_HYPOGEAL_TWILIGHT
dnl NOT YET -----> TF_WITH_INCENDIARY_SOPHIST

m4_include([ac/test-server.m4])
APANOLIO_ENABLE_TEST_SET([server])

AC_CONFIG_SRCDIR([src/tunitas/apanolio/namespace.xcpp])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_FILES([Makefile])
AC_CONFIG_HEADER([config.h]) dnl via autoheader via ./buildconf

# not in alphabetical order,
# ... rather in the cryptic "you just have to know" order in which they have to be built
dnl configure.ac:  TF_CONFIG_SUBMODULES([submodules], [ ...list...])
dnl Makefile.am    SUBDIRS = @subdirs@

AC_PREREQ([2.69])
AM_PROG_AR             dnl first
AC_PROG_LIBTOOL
AC_PROG_CXX
TF_PROG_DC
LT_PREREQ([2.4.2])
LT_INIT                dnl second
AC_LANG([C++])
# Checks for tools
TF_CHECK_GCC
 # Checks for packages
TF_CHECK_CPPUNIT
TF_CHECK_APACHE_HTTPD
TF_CHECK_BOOST
TF_CHECK_CPPUNIT
TF_CHECK_LEVELDB
TF_CHECK_SQLITE
TF_CHECK_UUID
# Checks for libraries.
TF_CHECK_STD_FILESYSTEM
# Checks for header files.
# Checks for typedefs, structures, and compiler characteristics.
# Checks for library functions.

TF_PACKAGE_VARIABLES

#
# Apache HTTPd Configuration file availability
#
#    <Location /apanolio>
#         SetHandler mod_apanolio <-------- MODULE_NAME in Apache HTTPd culture traditionally begins with "mod_"
#    </Location>
#
# S.C.O.L.D C++ availability in autotools::autoconf::Config<CONFIG>
#
#    char const *const HANDLER_NAME = autotools::autoconf::Config<CONFIG>::module_name();
#
AC_DEFINE_UNQUOTED([MODULE_NAME], "mod_${PACKAGE_NAME}", [The Apache HTTPd module name as seen from the handler])

AC_ARG_ENABLE([storage-directory],
              AS_HELP_STRING([--enable-storage-directory=DIRECTORY],
                             [Choose the storage directory for mod_apanolio]),
              [if test xno = x$enable_storage_directory; then
                  AC_MSG_ERROR([--disable-storage-directory is not meaningful, for mod_apanolio])
               fi],
              [
               enable_storage_directory="${t_prefix}/var"])
eval storagedir="${enable_storage_directory}"
eval storagedir="${storagedir}"
eval storagedir="${storagedir}"
eval storagedir="${storagedir}"
TF_MSG_VERBOSE([STORAGE_DIRECTORY=$storagedir])
AC_DEFINE_UNQUOTED([STORAGE_DIRECTORY], "$storagedir", [Default storage directory for the host-local database])

TF_FINALIZE

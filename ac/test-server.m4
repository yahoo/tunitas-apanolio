dnl This is a GNU -*- autoconf -*- specification that is processed by Autoconf.
dnl Copyright 2019-2019, Oath Inc.
dnl Licensed under the terms of the Apache-2.0 license.
dnl See the LICENSE file in https://github.com/yahoo/tunitas-apanolio/blob/master/LICENSE for terms.
dnl
dnl prefixed as "APANOLIO_" for "tunitas-apanolio"

dnl
dnl APANOLIO_ENABLE_ALL_TESTS     (no arguments)
dnl
dnl Enable or disable all tests
dnl The default is to do nothing, each test acquires its own signal
dnl
dnl put this in the library of ./ac, when possible.
AC_DEFUN([APANOLIO_ENABLE_ALL_TESTS], [
    AC_REQUIRE([TF_ENABLE_CONFIGURE_VERBOSE])
    AC_ARG_ENABLE([tests-requiring-a-running-server],
                  [AS_HELP_STRING([--disable-tests-requiring-a-running-server],
                                  [Disable the all tests that require a live server])],
                  [ : enableval ],
                  [ enableval=unspecified ])
    case $enableval in
    ( yes | no )
        TF_MSG_VERBOSE([setting enabled=$enableval for all tests requiring a database connection])
        enable_server_tests=$enableval
        : enable_this_tests=$enableval
        : enable_that_tests=$enableval
        : ...etc... 
        ;;
    ( unspecified | * )
        : nothing
        ;;
    esac
])

dnl APANOLIO_ENABLE_NAMED_TEST_SET(name_dashes, name_underscores)
dnl and a '-tests' suffix is appended.
dnl
dnl  name_dashes is a name with dashes in it; e.g. 'this-that'
dnl  name_underscores is an optional name with underscores, e.g. 'this_that'
dnl
dnl     --enable-server-tests        (default)
dnl     --disable-server-tests       no connection to a MySQL (MariaDB) is needed
dnl
dnl Examples:
dnl
dnl     APANOLIO_ENABLE_NAMED_TEST_SET(server)
dnl     APANOLIO_ENABLE_NAMED_TEST_SET(um_what_other_tests)
dnl
dnl https://www.gnu.org/software/autoconf/manual/autoconf-2.68/html_node/Text-processing-Macros.html#Text-processing-Macros
AC_DEFUN([APANOLIO_ENABLE_TEST_SET], [
    AC_REQUIRE([APANOLIO_ENABLE_ALL_TESTS])
    APANOLIO_ENABLE__NAMED__TEST_SET([$1-tests],
                                 m4_bpatsubst(ifelse([$2], [], [$1-tests], [$2-tests]),
                                              m4_changequote([{], [}]){[^a-zA-Z0-9_]}m4_changequote({[}, {]}),
                                              [_]),
                                 m4_toupper(m4_bpatsubst(ifelse([$2], [], [$1-tests], [$2-tests]),
                                                         m4_changequote([{], [}]){[^a-zA-Z0-9_]}m4_changequote({[}, {]}),
                                                         [_])))
])

dnl $1 is, e.g., 'server-tests'
dnl $2 is, e.g., 'server_tests'
dnl $3 is, e.g., 'SERVER_TESTS'
AC_DEFUN([APANOLIO_ENABLE__NAMED__TEST_SET], [
    AC_REQUIRE([TF_ENABLE_CONFIGURE_VERBOSE])
    AC_ARG_ENABLE([$1],
                  [AS_HELP_STRING([--disable-$1],
                                  [Disable the HTTPd $1 tests, they require a live Apache HTTPd server])],
                  [
                      test_how="is set"
                  ], [
                      # Policy decision: testing is on by default, because testing is good for you.
                      enable_$2=yes
                      test_how="defaults"
                      TF_MSG_VERBOSE([an omitted --disable-$1 behaves as --enable-$1=${enable_$2?}])
                  ])
    case "${enable_$2?}" in
    (yes) test_value=1; test_word="enabled";;
    (no)  test_value=0; test_word="disabled";;
    (*)
        AC_MSG_ERROR([bad value ${enable_$2?} for --enable-$1])
        ;;
    esac
    AC_MSG_NOTICE([$1 ${test_how?} to ${test_word?}.])
    AM_CONDITIONAL([ENABLE_$3], [test x${test_value?} = x1])
    dnl use HT_MSG_DEBUG, when available
    TF_MSG_VERBOSE([enable_$2=${enable_$2:-(unset)}])
    AM_COND_IF([ENABLE_$3], [: ok ])
])

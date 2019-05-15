dnl This is a GNU -*- autoconf -*- specification that is processed by Autoconf.
dnl Copyright 2019-2019, Oath Inc.
dnl Licensed under the terms of the Apache-2.0 license.
dnl See the LICENSE file in https://github.com/yahoo/tunitas-apanolio/blob/master/LICENSE for terms.

dnl APANOLIO_WITH_STORAGE(module)
dnl APANOLIO_WITH_STORAGE(module, nonstd)
dnl APANOLIO_WITH_STORAGE(module, nonstd, description)
dnl
dnl Known storage engines and their nonstd counterparts
dnl
dnl Whereas in the modern age patches are always required to get past CVE and also because ... reasons...
dnl we gang the MODULE and the NONSTD together.
dnl
dnl APANOLIO_WITH_STORAGE(module, nonstd)        S.C.O.L.D. Module     Non-Standard        Regular Package, "C API"
dnl ---------------------------------------      -----------------     ------------        ------------------------
dnl APANOLIO_WITH_STORAGE([leveldb])             module-leveldb        nonstd-leveldb      leveldb-devel-1.20-3.fc29.x86_64
dnl APANOLIO_WITH_STORAGE([sqlite])              module-sqlite         nonstd-sqlite       sqlite-3.28, but sqlite-devel-3.26.0-1.fc29.x86_64
dnl APANOLIO_WITH_STORAGE([mysql], [mysql++])    module-mysql          nonstd-mysql++      maria or mysql, one of those
dnl APANOLIO_WITH_STORAGE([pgsql], [mysql++])    module-pgsql          nonstd-pgsql++      libpq++, something like that
dnl APANOLIO_WITH_STORAGE([ramcloud])            module-ramcloud       nonstd-ramcloud     ...maybe...
dnl
dnl It's a natural programmer error to add the++ for mysql++ and pgsql++
dnl But a quirk of the module database naming convention is that the++ is not there.
dnl Try to fix up some basic sloppiness, to make it work.
dnl
dnl [[FIXTHIS]] build the correctives and remediations for common mistakes as is found hypogeal-twilight >= 0.44
dnl
AC_DEFUN([APANOLIO_WITH_STORAGE], [
    ifelse([$1-$2], [leveldb-], [
        APANOLIOinternal_WITH_STORAGE_AND_WARNING_VALIDATED_ARGUMENTS([$1], [$2], [$3])
    ], [ifelse([$1-$2], [leveldb-leveldb], [
        APANOLIOinternal_WITH_STORAGE_AND_WARNING_VALIDATED_ARGUMENTS([$1], [$2], [$3])
    ], [ifelse([$1-$2], [sqlite-], [
        APANOLIOinternal_WITH_STORAGE_AND_WARNING_VALIDATED_ARGUMENTS([$1], [$2], [$3])
    ], [ifelse([$1-$2], [sqlite-sqlite], [
        APANOLIOinternal_WITH_STORAGE_AND_WARNING_VALIDATED_ARGUMENTS([$1], [$2], [$3])
    ], [ifelse([$1-$2], [mysql-mysql++], [
        APANOLIOinternal_WITH_STORAGE_AND_WARNING_VALIDATED_ARGUMENTS([$1], [$2], [$3])
    ], [ifelse([$1-$2], [pgsql-pgsql++], [
        APANOLIOinternal_WITH_STORAGE_AND_WARNING_VALIDATED_ARGUMENTS([$1], [$2], [$3])
    ], [ifelse([$1-$2], [ramcloud-ramcloud], [
        APANOLIOinternal_WITH_STORAGE_AND_WARNING_VALIDATED_ARGUMENTS([$1], [$2], [$3])
    ], [
        TF_MSG_WARNING([[APANOLIO]_[WITH]_[STORAGE](m4_changequote([{], [}])[$1], [$2], [$3]m4_changequote({[}, {]}))])
        TF_MSG_WARNING([the argument parings in this [APANOLIO]_[WITH]_[STORAGE] statement are probably not valid])
        TF_MSG_WARNING([the corrective code that follows will attempt to remediate the problem])
        TF_MSG_WARNING([but you may experience cryptic errors])
        TF_MSG_WARNING([continuing anyway])
        TF_MSG_WARNING([you should fix this, see the commentariat in with-storage.m4])
        TF_MSG_WARNING([good luck])
        APANOLIOinternal_WITH_STORAGE_AND_WARNING_VALIDATED_ARGUMENTS([$1], [$2], [$3])
    ]) ]) ]) ]) ]) ]) ])
])

AC_DEFUN([APANOLIOinternal_WITH_STORAGE_AND_WARNING_VALIDATED_ARGUMENTS], [
  TF_WITH_MODULE([$1])
  TF_WITH_NONSTD([$1],
                 m4_bpatsubst(ifelse([$2], [], [$1], [$2]),
                               m4_changequote([{], [}]){++$}m4_changequote({[}, {]}),
                               []),
                 [That Certain Non-Standard (patched, enhanced, re-invigorated) ifelse([$3], [], [$1], [$3])])
])

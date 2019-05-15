# source ${0%/*}/rigging.sh || exit 70
f=${0##*/}
b=${f%.test}
name=$b
path=/${name?}
exe=unit
__topdir="${0%/*}/../.."
export PATH="${__topdir}/check/bin:${__topdir}/bin:$PATH"

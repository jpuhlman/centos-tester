#!/bin/bash
RELEASE=c6-10-mv
COMMON=http://gitcentos.mvista.com/cgit/upstream/utils/common-build.git/plain/

curl -s $COMMON/conf/centos-updates.cfg?h=$RELEASE | sed /#Base/,/#End/p -n  | sed /^baseurl=/d | sed s,^#baseurl=,baseurl=, > sig.repo

curl -s $COMMON/base.list?h=$RELEASE | sort -u | while read REPO A; do
    if [ "x$A" != "x" ] ; then
    srpm=$(basename $A)
    len=$(echo $srpm | sed s,-,\ ,g | wc -w)
    NAME=$(echo -n $srpm | cut -d "-" -f 1-$(($len - 1)))
    echo $NAME
    fi
done > pkgs

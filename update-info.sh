#!/bin/bash
RELEASE=c7-8-mv
COMMON=http://gitcentos.mvista.com/cgit/upstream/utils/common-build.git/plain

curl -s $COMMON/conf/centos-updates.cfg?h=$RELEASE | sed /#Base/,/#End/p -n  | sed /^baseurl=/d | sed s,^#baseurl=,baseurl=, > sig.repo

curl -s $COMMON/base.list?h=$RELEASE | sort -u | while read REPO A; do
    if [ "x$A" != "x" ] ; then
    srpm=$(basename $A)
    len=$(echo $srpm | sed s,-,\ ,g | wc -w)
    NVR=$(echo $srpm | sed s,.src.rpm$,,)
    NAME=$(echo -n $NVR | cut -f 1-$(($len - 2)) -d -)
    VERSION=$(echo -n $NVR | cut -f $(($len - 1)) -d -)
    RELEASE=$(echo -n $NVR | cut -f $(($len)) -d -)
    echo $NAME
    fi
done > app.list

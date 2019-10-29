#!/bin/bash
RELEASE=c7-5-mv
COMMON=git://gitcentos.mvista.com/centos/upstream/utils/common-build
REPO=$(basename $COMMON)
if [ ! -e $(basename $REPO) ] ; then
    git clone -b $RELEASE $COMMON
else
    pushd $REPO
    git pull
    popd
fi
cat $REPO/conf/centos-updates.cfg | sed /#Base/,/#End/p -n  | sed /^baseurl=/d | sed s,^#baseurl=,baseurl=, > sig.repos
$REPO/gen-pkgs.sh | sort > pkgs

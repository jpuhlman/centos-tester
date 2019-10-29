#!/bin/bash
if [ ! -e /etc/centos-release.current ] ; then
   cp /etc/centos-release /etc/centos-release.current
fi
TEMPFILE=$(mktemp)
yum install -y yum-utils
yum update -y centos-release
RELEASE="$(cat /etc/centos-release.current | while read A B C D E; do echo $D; done)"
releasedRepos="$(yum repolist -q | grep -v "repo id" | cut -d / -f 1)"
for repo in $releasedRepos; do
    yum-config-manager --enable C$RELEASE-$repo > $TEMPFILE
    if [ -n "$(grep C$RELEASE-$repo $TEMPFILE)" ] ; then
        yum-config-manager --disable $repo
    fi
done
yum downgrade -y centos-release yum-utils
rm -f $TEMPFILE

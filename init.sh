#!/bin/bash

if [ -e /etc/yum.repos.d-overlay ] ; then
   if [ ! -L /etc/yum.repos.d ] ; then
        mv /etc/yum.repos.d /etc/yum.repos.d-save
        mkdir -p /etc/yum.repos.d
        cp /etc/yum.repos.d-overlay/* /etc/yum.repos.d
   fi
fi
if [ -d local-repos ] ; then
    for repo in /local-repos/*; do
        REPONAME=$(basename $repo)
        cat > /etc/yum.repos.d/local-$REPONAME.repo << EOF
[localrepo-$REPONAME]
name=Local repo $REPONAME
failovermethod=priority
enabled=1
gpgcheck=0
baseurl=file://$repo
EOF
    done
fi

if [ -n "$EXTRA_REPOS" ] ; then
    for repo in $EXTRA_REPOS; do 
        REPONAME=$(echo $repo | sed s,\",,g | cut -d "/" -f 4- | sed s,/,_,g | sed s,_$,,)

cat > /etc/yum.repos.d/$REPONAME.repo << EOF
[$REPONAME]
name=$REPONAME
failovermethod=priority
enabled=1
gpgcheck=0
baseurl=$repo
EOF

    done
fi
if [ -e /run.sh ] ; then
   chmod 755 /run.sh
   /run.sh
elif [ -n "$SYSTEMD" ] ; then
    exec /sbin/init
else
    exec /bin/bash
fi

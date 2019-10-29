#!/bin/bash


if [ -d /repo ] ; then
cat > /etc/yum.repos.d/local.repo << EOF
[localrepo]
name=Local repo
failovermethod=priority
enabled=1
gpgcheck=0
baseurl=file:///repo/
EOF
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

exec /bin/bash

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

exec /bin/bash

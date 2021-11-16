FROM centos:8.4.2105
RUN echo 8.4.2105 > /etc/yum/vars/releasever
RUN if [ -n "$(curl https://vault.centos.org/centos/8.4.2105/AppStream/x86_64/os/repodata/repomd.xml | grep xml)" ] ; then \
      for each in $(ls /etc/yum.repos.d); do \
        cat /etc/yum.repos.d/$each; \
        sed -i  /etc/yum.repos.d/$each -e "s,#baseurl=http://mirror.centos.org,baseurl=http://vault.centos.org,"; \
        sed -i  /etc/yum.repos.d/$each -e "/^mirrorlist=/d"; \
        cat /etc/yum.repos.d/$each; \
      done; \
    fi
RUN if [ -z "$(curl https://vault.centos.org/centos/8.4.2105/AppStream/x86_64/os/repodata/repomd.xml | grep xml)" ] ; then \
      for each in $(ls /etc/yum.repos.d); do \
        cat /etc/yum.repos.d/$each; \
        sed -i  /etc/yum.repos.d/$each -e "s,#baseurl=,baseurl=,"; \
        sed -i  /etc/yum.repos.d/$each -e "/^mirrorlist=/d"; \
        cat /etc/yum.repos.d/$each; \
      done; \
    fi
RUN dnf update -y
COPY init.sh /
RUN chmod 755 /init.sh
CMD /init.sh


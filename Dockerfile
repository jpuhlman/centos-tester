FROM centos:8.2.2004
RUN echo 8.2.2004 > /etc/yum/vars/releasever
RUN echo "" > /etc/yum/vars/contentdir
RUN ls /etc/yum.repos.d/
RUN for each in $(ls /etc/yum.repos.d); do \
    cat /etc/yum.repos.d/$each; \
    sed -i  /etc/yum.repos.d/$each -e "s,#baseurl=http://mirror.centos.org,baseurl=http://vault.centos.org,"; \
    sed -i  /etc/yum.repos.d/$each -e "/^mirrorlist=/d"; \
    cat /etc/yum.repos.d/$each; \
    done
RUN dnf update -y
COPY init.sh /
RUN chmod 755 /init.sh
CMD /init.sh


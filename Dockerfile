FROM centos:centos8
#COPY switch-to-vault.sh /
RUN touch /etc/yum.repos.d/local.repo
RUN cd /etc/yum.repos.d/ ; \
    sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* ; \
    sed -e "s|#baseurl=http://mirror|baseurl=http://vault|" -i *.repo ; \
    yum update -y ; \
    dnf install centos-release-stream -y ; \
    dnf swap centos-{linux,stream}-repos -y ; \
    dnf distro-sync -y   
#RUN chmod 755 /switch-to-vault.sh; /switch-to-vault.sh; rm -f /switch-to-vault.sh
#COPY sig.repo /etc/yum.repos.d/sig.repo
#COPY app.list /
#RUN  yum install -y $(cat /app.list); rm -f /app.list
#RUN yum update -y 
COPY init.sh /
RUN chmod 755 /init.sh
CMD /init.sh


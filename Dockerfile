FROM centos:6.10
RUN sed -i /etc/yum.repos.d/CentOS-Base.repo \
    -e "s,#baseurl,baseurl," \
    -e "s,mirrorlist,#mirrorlist," \
    -e "s,mirror.centos.org,vault.centos.org,"
COPY switch-to-vault.sh /
RUN touch /etc/yum.repos.d/local.repo
RUN chmod 755 /switch-to-vault.sh; /switch-to-vault.sh; rm -f /switch-to-vault.sh
COPY sig.repos /etc/yum.repos.d/sig.repo
COPY pkgs /
RUN  yum install -y $(cat /pkgs); rm -f /pkgs
RUN yum update -y 
COPY init.sh /
RUN chmod 755 /init.sh
CMD /init.sh


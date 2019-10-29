FROM centos:7.5.1804
COPY switch-to-vault.sh /
RUN touch /etc/yum.repos.d/local.repo
RUN chmod 755 /switch-to-vault.sh; /switch-to-vault.sh; rm -f /swtich-to-valut.sh
RUN yum update -y 
COPY init.sh /
RUN chmod 755 /init.sh
CMD /init.sh


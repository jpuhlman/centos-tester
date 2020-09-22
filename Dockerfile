FROM centos:7.8.2003
COPY switch-to-vault.sh /
RUN touch /etc/yum.repos.d/local.repo
RUN chmod 755 /switch-to-vault.sh; /switch-to-vault.sh; rm -f /switch-to-vault.sh
COPY sig.repo /etc/yum.repos.d/sig.repo
COPY app.list /
RUN  yum install -y $(cat /app.list); rm -f /app.list
RUN yum update -y 
COPY init.sh /
RUN chmod 755 /init.sh
CMD /init.sh


FROM jpuhlman/centos-base:5.11
RUN yum install -y createrepo bzip2-libs bash
COPY init.sh /
RUN chmod 755 /init.sh
CMD /init.sh


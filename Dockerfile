FROM jpuhlman/centos-base:5.11
CMD yum install -y createrepo
COPY init.sh /
RUN chmod 755 /init.sh
CMD /init.sh


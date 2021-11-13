FROM jpuhlman/centos-base:5.11
COPY init.sh /
RUN chmod 755 /init.sh
CMD /init.sh


#
FROM ubuntu:20.04
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY sources.list /etc/apt/sources.list
RUN apt -y  update && apt -y  upgrade
RUN apt -y install \
       git \
       apt-utils \
       devscripts \
       build-essential \
       fakeroot \
       debhelper \
       dh-autoreconf \
       dh-apparmor \
       cdbs \
       ssl-cert \ 
       squid-langpack \
       libcppunit-dev \
       logrotate \
    libsasl2-dev \
    libxml2-dev \
    libkrb5-dev \
    libdb-dev \
    libnetfilter-conntrack-dev \
    libexpat1-dev \
    libcap2-dev \
    libldap2-dev \
    libpam0g-dev \
    libgnutls28-dev \
    libdbi-perl \
    libecap3 \
    libecap3-dev \
    libsystemd-dev      



RUN mkdir /usr/src/squid &&  chown _apt:root /usr/src/squid
RUN cd /usr/src/squid && apt -y source squid && apt -y build-dep squid
COPY rules /usr/src/squid/squid-4.10/debian/rules
RUN cd /usr/src/squid/squid-4.10 && debuild -d -uc -us
RUN cd /usr/src/squid && dpkg -i squid_4.10-1ubuntu1.6_amd64.deb squid-common_4.10-1ubuntu1.6_all.deb squidclient_4.10-1ubuntu1.6_amd64.deb && apt -y --fix-broken install && apt-mark hold squid squidclient squid-common
RUN cd /usr/src/squid/squid-4.10 && apt -y install -f
COPY squid-entrypoint.sh /usr/sbin/squid-entrypoint.sh
RUN chmod 755 /sbin/squid-entrypoint.sh
EXPOSE 3128
ENTRYPOINT ["/sbin/squid-entrypoint.sh"]

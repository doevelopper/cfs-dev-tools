#        cfs-com/src/main/resources/docker/amd64/rti/Dockerfile
#
#               Copyright (c) 2014-2018 A.H.L
#
#        Permission is hereby granted, free of charge, to any person obtaining
#        a copy of this software and associated documentation files (the
#        "Software"), to deal in the Software without restriction, including
#        without limitation the rights to use, copy, modify, merge, publish,
#        distribute, sublicense, and/or sell copies of the Software, and to
#        permit persons to whom the Software is furnished to do so, subject to
#        the following conditions:
#
#        The above copyright notice and this permission notice shall be
#        included in all copies or substantial portions of the Software.
#
#        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#        EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#        MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#        NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
#        LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
#        OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
#

ARG BASE_IMAGE=amd64/ubuntu:18.04
FROM $BASE_IMAGE

ARG PROXY
ARG MAKEFLAGS
ARG NOPROXY
ARG http_proxy=$PROXY
ARG https_proxy=$PROXY
ARG no_proxy=$NOPROXY
ARG HTTP_PROXY=$PROXY
ARG HTTPS_PROXY=$PROXY
ARG NO_PROXY=$NOPROXY
ARG PROXY_HOST
ARG PROXY_PORT
ARG PROXY=${PROXY_HOST}:${PROXY_PORT}


ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN Time="$(date +%s)" \
    && apt-get -qq -o Acquire::Check-Valid-Until="false" update --assume-yes \
    && apt-get -qq install --assume-yes --no-install-recommends \
      ca-certificates apt-transport-https \
      wget curl openssh-server openssh-client \
      gawk vim python3-dev xvfb xauth libx11-xcb1 libfontconfig1 libfontconfig1-dev libdbus-1-3 libgl1-mesa-dev \
      libperl-dev perl perl-base perl-modules apt-utils gettext \
      xotcl-dev tcl-expect-dev tcl-dev docbook2x dos2unix \
      libcrypto++-dev libgcrypt20-dev libpcap-dev \
      iptables jq htop most lsof hxtools \
    && apt-get clean --assume-yes \
    && apt-get --assume-yes --quiet clean \
    && apt-get --assume-yes --quiet autoremove \
    && rm -rvf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/* \
    && rm -rf /usr/share/man/ \
    && Time="$(($(date +%s)-Time))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((Time/86400))" "$((Time/3600%24))" "$((Time/60%60))" "$((Time%60))"

RUN echo 'Building Container with HTTP Proxy: '$HTTP_PROXY

# Set wget/curl proxies
RUN [ -n "$http_proxy" ] && printf "use_proxy=yes\nhttp_proxy=$http_proxy\nhttps_proxy=$https_proxy\nno_proxy=$no_proxy" > /root/.wgetrc; exit 0
RUN [ -n "$http_proxy" ] && printf "proxy=$http_proxy" >> /root/.curlrc; exit 0

##setting up the apt so it will run through the proxy
# RUN [ -n "$http_proxy" ] && echo "Acquire::http::proxy \"$http_proxy\";" > /etc/apt/apt.conf; \
    # [ -n "$https_proxy" ] && echo "Acquire::https::proxy \"$https_proxy\";" >> /etc/apt/apt.conf; \
    # [ -f /etc/apt/apt.conf ] && cat /etc/apt/apt.conf; exit 0

RUN echo -e '\033[36;1m ******* Differents builds tools installation ******** \033[0m'

RUN  cd /tmp \
#  http://enos.itcollege.ee/~jpoial/allalaadimised/jdk8/jdk-8u212-linux-x64.tar.gz
   && curl -L -O -k https://github.com/frekele/oracle-java/releases/download/8u212-b10/jdk-8u212-linux-x64.tar.gz \
   && tar -xzf jdk-8u212-linux-x64.tar.gz -C /opt/ \
   && rm jdk-8u212-linux-x64.tar.gz

ENV JAVA_HOME /opt/jdk1.8.0_212
ENV JRE_HOME /opt/jdk1.8.0_212/jre
ENV PATH $PATH:/opt/jdk1.8.0_212/bin:/opt/jdk1.8.0_212/jre/bin

RUN echo -e '\033[36;1m ******* RTI PACKAGES Installation ******** \033[0m'


ARG RTI_DDS_VERSION=6.0.0

COPY packages/rti_license.dat /opt/rti_connext_dds-${RTI_DDS_VERSION}/
COPY packages/*.rtipkg  /tmp/
COPY packages/rti_connext_dds-${RTI_DDS_VERSION}-pro-host-x64Linux.run /tmp/

RUN cd /tmp/ \
      && chmod +x /tmp/rti_connext_dds-${RTI_DDS_VERSION}-pro-host-x64Linux.run \
      && ./rti_connext_dds-${RTI_DDS_VERSION}-pro-host-x64Linux.run  --mode unattended --prefix /opt --disable_copy_examples true \
      && rm -rvf /tmp/rti_connext_dds-${RTI_DDS_VERSION}-pro-host-x64Linux.run

ARG AMD_PREFIX=x64Linux3gcc5.4.0
ARG AMD_PREFIX_7.4=x64Linux3gcc7.4.0
ENV NDDSHOME=/opt/rti_connext_dds-${RTI_DDS_VERSION}
ENV PATH="${PATH}:${NDDSHOME}/bin"
ENV LD_LIBRARY_PATH=/opt/rti_connext_dds-${RTI_DDS_VERSION}/lib/:${LD_LIBRARY_PATH}

#RUN cd /tmp/ \
    #&& rtipkginstall -unattended rti_connext_dds-6.0.0-pro-target-x64Linux4gcc7.3.0.rtipkg \
    #&& rtipkginstall -unattended rti_limited_bandwidth_plugins-6.0.0-x64Linux4gcc7.3.0.rtipkg \
    #&& rtipkginstall -unattended rti_security_plugins-6.0.0-target-x64Linux4gcc7.3.0.rtipkg \
    #&& rtipkginstall -unattended rti_tls_support-6.0.0-x64Linux4gcc7.3.0.rtipkg \
    #&& rtipkginstall -unattended rti_secure_wan-6.0.0-x64Linux4gcc7.3.0.rtipkg \
    #&& rtipkginstall -unattended rti_limited_bandwidth_plugins_host-6.0.0-x64Linux.rtipkg \
    #&& rtipkginstall -unattended rti_web_integration_service-6.0.0-x64Linux.rtipkg \
    #&& rtipkginstall -unattended rti_security_plugins-6.0.0-host-x64Linux.rtipkg \
    #&& rtipkginstall -unattended rti_database_integration-6.0.0-x64Linux.rtipkg \
    #&& rtipkginstall -unattended rti_tls_host_support-6.0.0-x64Linux.rtipkg \
    #&& rtipkginstall -unattended openssl-1.0.2o-6.0.0-host-x64Linux.rtipkg \
    #&& rtipkginstall -unattended rti_secure_wan_host-6.0.0-x64Linux.rtipkg \
    #&& rtipkginstall -unattended rti_queuing_service-6.0.0-x64Linux.rtipkg \
    #&& rtipkginstall -unattended rti_connext_dds_micro-3.0.0-Unix.rtipkg \
    #&& rm -rvf /tmp/*.rtipkg

#COPY packages/*.tar.gz /tmp/
#COPY packages/*.zip /tmp/

#RUN cd /tmp/ \
    #&& mkdir -pv /opt/rti_connext_openssl/target-x64Linux4gcc7.3.0 \
    #&& tar -zvxf openssl-1.0.2o-target-x64Linux4gcc7.3.0.tar.gz -C /opt/rti_connext_openssl/target-x64Linux4gcc7.3.0 --strip-components=1 \
    #&& mkdir -pv /opt/rti_routing_service/ \
    #&& unzip rti_routing_service-${RTI_DDS_VERSION}-src.zip -d /opt/rti_routing_service \
    #&& rm -rvf /tmp/*.tar.gz  /tmp/*.zip

ARG DK_USER_ACCOUNT=happyman
RUN adduser --system --home /home/${DK_USER_ACCOUNT} --shell /bin/bash \
	--gecos GECOS --group --disabled-password --quiet ${DK_USER_ACCOUNT}
WORKDIR /home/$DK_USER_ACCOUNT
USER $DK_USER_ACCOUNT
CMD ["/bin/bash"]


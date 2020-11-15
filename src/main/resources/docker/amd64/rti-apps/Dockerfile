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
      xz-utils unzip wget curl openssh-server openssh-client \
      gawk vim vim-nox python3 xvfb xauth libx11-xcb1 libfontconfig1 libfontconfig1-dev libdbus-1-3 libgl1-mesa-dev \
      perl perl-base perl-modules apt-utils tcl dos2unix \
      iptables jq htop most lsof hxtools afl-cov \
    && apt-get clean --assume-yes \
    && apt-get --assume-yes --quiet clean \
    && apt-get --assume-yes --quiet autoremove \
    && rm -rvf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/* \
    && rm -rf /usr/share/man/ \
    && Time="$(($(date +%s)-Time))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((Time/86400))" "$((Time/3600%24))" "$((Time/60%60))" "$((Time%60))"

RUN  cd /tmp \
#  http://enos.itcollege.ee/~jpoial/allalaadimised/jdk8/jdk-8u212-linux-x64.tar.gz
   && curl -L -O -k https://github.com/frekele/oracle-java/releases/download/8u212-b10/jdk-8u212-linux-x64.tar.gz \
   && tar -xzf jdk-8u212-linux-x64.tar.gz -C /opt/ \
   && rm jdk-8u212-linux-x64.tar.gz

ENV JAVA_HOME /opt/jdk1.8.0_212
ENV JRE_HOME /opt/jdk1.8.0_212/jre
ENV PATH $PATH:/opt/jdk1.8.0_212/bin:/opt/jdk1.8.0_212/jre/bin


ARG DK_USER_ACCOUNT=developer
RUN adduser --system --home /home/${DK_USER_ACCOUNT} --shell /bin/bash \
	--gecos GECOS --group --disabled-password --quiet ${DK_USER_ACCOUNT}
WORKDIR /home/$DK_USER_ACCOUNT
USER $DK_USER_ACCOUNT
CMD ["/bin/bash"]

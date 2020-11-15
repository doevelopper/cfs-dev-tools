#        cfs-dev-tools/src/main/resources/docker/amd64/adlinktech-apps/Dockerfile
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

ARG DDS_DEV_IMAGE=docker.io/doevelopper/cfs-dev-tools-adlinktech:0.0.1
FROM $DDS_DEV_IMAGE  AS appsbuilder

FROM amd64/ubuntu:19.10
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN apt-get -qq -o Acquire::Check-Valid-Until="false" update --assume-yes \
    && apt-get -qq install --assume-yes --no-install-recommends \
		ca-certificates apt-transport-https \
		xz-utils unzip wget curl openssh-server openssh-client \
		vim python3 hxtools perl xotcl tcl-expect tcl dos2unix \
		libsqlite3-0 iptables jq htop most lsof \
        gawk vim tmux vim-nox python3 perl perl-base xotcl tcl-expect tcl fortunes lsb-release gnutls-bin \
    && apt-get clean --assume-yes \
    && apt-get --assume-yes --quiet clean \
    && apt-get --assume-yes --quiet autoremove \
    && rm -rvf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/* \
    && rm -rf /usr/share/man/

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && curl -sL https://deb.nodesource.com/setup_13.x | bash - \
    && apt-get -qq install --assume-yes --no-install-recommends nodejs \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

COPY --from=appsbuilder /opt/jdk1.8.0_212/ /opt/jdk1.8.0_212/
COPY --from=appsbuilder /usr/local/lib/*.so /usr/local/lib/
COPY --from=appsbuilder /opt/Qt/5.13.2/gcc_64/lib/libQt*.so /usr/local/lib/
COPY --from=appsbuilder /opt/RTS/ /opt/RTS/

ARG ACCOUNT=${ACCOUNT:-developer}
RUN adduser --system --home /home/${ACCOUNT} --shell /bin/bash \
    --gecos GECOS --group --disabled-password --quiet ${ACCOUNT}
USER $ACCOUNT
WORKDIR /home/$ACCOUNT
CMD ["/bin/bash"]

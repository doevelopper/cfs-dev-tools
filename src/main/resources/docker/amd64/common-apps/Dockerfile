# %W% %G% %U%
#        cfs-com/src/main/resources/docker/amd64/common-apps/Dockerfile
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

ARG BASE_IMAGE=amd64/ubuntu:19.10
FROM $BASE_IMAGE as appsbuilder

#docker build --build-arg PROXY=$HTTP_PROXY
ARG PROXY
ARG MAKEFLAGS_OPTIONS
ARG NOPROXY
ARG http_proxy=$PROXY
ARG https_proxy=$PROXY
ARG no_proxy=$NOPROXY
ARG HTTP_PROXY=$PROXY
ARG HTTPS_PROXY=$PROXY
ARG NO_PROXY=$NOPROXY
ARG CMAKE_MAJOR_VERSION=${CMAKE_MAJOR_VERSION:-3.16}
ARG CMAKE_VERSION=${CMAKE_VERSION:-${CMAKE_MAJOR_VERSION}.0}
ARG MVN_VERSION=${MVN_VERSION:-3.6.3}
ARG GRADLE_VERSION=${GRADLE_VERSION:-6.0.1}
ARG BAZEL_VERSION=${BAZEL_VERSION:-1.2.1}
ARG BOOST_VERSION_MAJ=1
ARG BOOST_VERSION_MIN=71
ARG BOOST_VERSION_PATCH=0
ARG BOOST_VERSION=${BOOST_VERSION_MAJ}.${BOOST_VERSION_MIN}.${BOOST_VERSION_PATCH}
ARG BOOST_RELEASE=${BOOST_VERSION_MAJ}_${BOOST_VERSION_MIN}_${BOOST_VERSION_PATCH}
ARG APR_VERSION=1.7.0
ARG APU_VERSION=1.6.1
ARG Q_MAJOR_VERSION=${Q_MAJOR_VERSION:-5.13}
ARG Q_VERSION=${Q_VERSION:-${Q_MAJOR_VERSION}.2}
ARG QT_SHA_256=0cd82c80287a783bd5db1339b6184803d57517c9450ffe16f505254853f0a41f
ARG T_MD5=c839aed9d551bdc8411a0a33e5ae46f3

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

ARG STAGING_DIR=/opt/staging

RUN apt-get -qq -o Acquire::Check-Valid-Until="false" update --assume-yes \
    && apt-get -qq install --assume-yes --no-install-recommends \
      ca-certificates apt-transport-https \
      libtool autotools-dev autopoint autoconf automake make autoproject bison flex \
      build-essential git xz-utils unzip wget curl openssh-server openssh-client \
      gawk vim vim-nox texinfo gtk-doc-tools autogen autogen-doc \
      python-pip python-dev python-wheel cython python-setuptools \
      python3-pip python3-dev python3-wheel cython3 python3-setuptools \
      ruby ruby-dev libjpeg-dev libudev-dev libmpfr-dev libccrtp-dev \
      libglib2.0-dev libglib2.0-bin libglib2.0-0 hxtools \
      xvfb xauth libx11-xcb1 libfontconfig1 libfontconfig1-dev libdbus-1-3 libgl1-mesa-dev \
      libperl-dev perl perl-base perl-modules libgd-perl apt-utils gettext \
      yasm nasm xotcl-dev tcl-expect-dev tcl-dev docbook2x dos2unix \
      libpulse-dev libva-dev libxv-dev libelf-dev elfutils libelf1 \
      libavformat-dev libavutil-dev libdlna-dev libavcodec-dev uvcdynctrl \
      libtsan0-dbg libtsan0 valgrind valgrind-dbg mscgen libgraphviz-dev xdot \
      display-dhammapada fortunes lsb-release libpng-dev libghc-graphviz-dev \
      libcrypto++-dev libgcrypt20-dev libpcap-dev libwiretap-dev bittwist tkpng \
      gnutls-bin ntopng pcaputils python-pcapy python-pypcap tcpick tcpspy libgnutls30 \
      gobject-introspection liborc-0.4-dev liborc-0.4-dev-bin libgudev-1.0-dev libgudev3.0-cil-dev \
      libogg-dev liboggz2-dev python-ogg libisocodes-dev gir1.2-isocodes-1.2 libpng++-dev \
      libtheora-dev libtheora-bin libvorbis-dev python-pyvorbis libogg-vorbis-decoder-perl \
      iptables jq htop extra-cmake-modules libmicrohttpd-dev most lsof \
      ccache gcovr lcov node-lcov-parse tmux libsqlite3-dev \
    && apt-get clean --assume-yes \
    && apt-get --assume-yes --quiet clean \
    && apt-get --assume-yes --quiet autoremove \
    && rm -rvf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/* \
    && rm -rf /usr/share/man/

# libavutil-dev libavformat-dev libavcodec-dev libswscale-dev libavdevice-dev
##setting up the apt so it will run through the proxy
# RUN [ -n "$http_proxy" ] && echo "Acquire::http::proxy \"$http_proxy\";" > /etc/apt/apt.conf; \
    # [ -n "$https_proxy" ] && echo "Acquire::https::proxy \"$https_proxy\";" >> /etc/apt/apt.conf; \
    # [ -f /etc/apt/apt.conf ] && cat /etc/apt/apt.conf; exit 0

# RUN apt-get update

# Set wget proxies
RUN [ -n "$http_proxy" ] && printf "use_proxy=yes\nhttp_proxy=$http_proxy\nhttps_proxy=$https_proxy\nno_proxy=$no_proxy" > /root/.wgetrc; exit 0

RUN echo -e '\033[36;1m ******* Differents builds tools installation ******** \033[0m'

RUN cd /tmp \
    && curl -L -O -k https://cmake.org/files/v${CMAKE_MAJOR_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
    && tar -xvf cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz > /dev/null \
    && rm -v cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
    && mv -v cmake-${CMAKE_VERSION}-Linux-x86_64 /opt/cmake

RUN  cd /tmp \
    # && curl -x '${HTTPS_PROXY}' -L -O -k https://github.com/ninja-build/ninja/releases/download/v1.9.0/ninja-linux.zip\
    && curl -L -O -k  https://github.com/ninja-build/ninja/releases/download/v1.9.0/ninja-linux.zip\
    && unzip ninja-linux.zip  \
    && mv ninja /usr/bin/ninja \
    && rm ninja-linux.zip

# COPY [ -f ./jdk-8u212-linux-x64.tar.gz ] && [] jdk-8u212-linux-x64.tar.gz /tmp

RUN  cd /tmp \
#  http://enos.itcollege.ee/~jpoial/allalaadimised/jdk8/jdk-8u212-linux-x64.tar.gz
    && curl -L -O -k https://github.com/frekele/oracle-java/releases/download/8u212-b10/jdk-8u212-linux-x64.tar.gz \
    && tar -xzf jdk-8u212-linux-x64.tar.gz -C /opt/ \
    && rm jdk-8u212-linux-x64.tar.gz

RUN cd /tmp \
    &&  wget --no-check-certificate \
   https://www-eu.apache.org/dist/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz \
    && tar -xzf apache-maven-${MVN_VERSION}-bin.tar.gz > /dev/null 2>&1 \
    && mv apache-maven-${MVN_VERSION}/ /opt/apache-maven \
    && rm -v apache-maven-${MVN_VERSION}-bin.tar.gz

RUN cd /tmp \
    && curl -L -O -k https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip \
    && mkdir -pv /opt/gradle \
    && unzip gradle-${GRADLE_VERSION}-bin.zip  \
    && mv gradle-${GRADLE_VERSION}  /opt/gradle/ \
    && rm -f gradle-${GRADLE_VERSION}-bin.zip

ENV JAVA_HOME /opt/jdk1.8.0_212
ENV JRE_HOME /opt/jdk1.8.0_212/jre
ENV M2_HOME /opt/apache-maven/
ENV M2 $M2_HOME/bin
ENV MAVEN_OPTS "-Dstyle.info=bold,green -Dstyle.project=bold,magenta -Dstyle.warning=bold,yellow \
        -Dstyle.mojo=bold,cyan -Xmx1048m -Xms256m -XX:MaxPermSize=512M"
ENV PATH $PATH:/opt/apache-maven/bin/:/opt/jdk1.8.0_212/bin:/opt/jdk1.8.0_212/jre/bin:/opt/cmake/bin
ENV PATH $PATH:/opt/gradle/gradle-${GRADLE_VERSION}/bin

RUN cd /tmp \
    && curl -L -O -k https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh \
    && chmod +x bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh  \
    && ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh  \
    && rm -f ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh

RUN pip install -q --no-cache-dir conan \
    && pip install --upgrade conan_package_tools \
    && pip install cpplint \
    && pip3 install meson \
    && pip3 install cpplint-junit \
    && pip install cppcheck-junit \
    && pip install semver \
    && pip install semver-tool \
    && pip install lizard \
    && pip install cpp-demangle \
    && pip install polysquare-cmake-linter \
    && pip install -U Sphinx \
    && pip3 install cmakedoc \
    && pip install cpp-coveralls \
    && pip install coverxygen \
    && pip install doxygen-junit \
    && pip3 install cornichon \
    && pip install python-afl \
    && pip install gdb-tools

RUN cmake --version \
    && make --version \
    && gcc --version \
    && java -version \
    && mvn --version \
    && gradle -v \
    && bazel version \
    && conan --version || true

RUN echo -e '\033[36;1m ******* Libraries installation ******** \033[0m'

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && git clone --depth=1 https://github.com/gflags/gflags.git \
    && cd gflags \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=${STAGING_DIR} \
       -DCMAKE_CONFIGURATION_TYPES=Release -DGFLAGS_BUILD_TESTING=OFF \
       -DGFLAGS_BUILD_SHARED_LIBS=ON -DGFLAGS_BUILD_STATIC_LIBS=ON \
    && cmake --build build --target all --clean-first > /dev/null 2>&1 \
    && cmake --build build --target install \
    && cd /tmp \
    && rm -rf gflags \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && git clone --depth=1 https://github.com/google/glog.git \
    && cd glog \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=${STAGING_DIR} \
    && cmake --build build --target all --clean-first > /dev/null 2>&1 \
    && cmake --build build --target install \
    && cd /tmp \
    && rm -rf glog \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && curl -L -O -k https://dl.bintray.com/boostorg/release/${BOOST_VERSION}/source/boost_${BOOST_RELEASE}.tar.gz \
    && tar xzf boost_${BOOST_RELEASE}.tar.gz \
    && cd boost_${BOOST_RELEASE} \
    && ./bootstrap.sh --prefix=${STAGING_DIR} --with-python=python3 \
    && ./b2 --help \
    && ./b2 link=shared threading=multi variant=release address-model=64 > /dev/null 2>&1 \
    && ./b2 install --prefix=${STAGING_DIR} > /dev/null 2>&1 \
    && cd /tmp \
    && rm -rf boost_${BOOST_RELEASE} boost_${BOOST_RELEASE}.tar.gz \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

#sml requires GCC >= 6.0.0
RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && git clone --depth=1 https://github.com/boost-experimental/sml.git \
    && cd sml \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=${STAGING_DIR} -DCMAKE_BUILD_TYPE=Release\
    && cmake --build build --target all --clean-first > /dev/null 2>&1 \
    && cmake --build build --target install \
    && cd /tmp \
    && rm -rf sml \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

# "Building IEEE doubles binary-decimal and decimal-binary ."
RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && git clone --depth=1 https://github.com/google/double-conversion.git  \
    && cd double-conversion \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=ON -DCMAKE_INSTALL_PREFIX=${STAGING_DIR} \
    && cmake --build build --target all --clean-first > /dev/null 2>&1 \
#   - test/cctest/cctest --list | tr -d '<' | xargs test/cctest/cctest \
    && cmake --build build --target install || true \
    && cd /tmp \
    && rm -rf double-conversion \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && GIT_SSL_NO_VERIFY=1 git clone --depth=1 --recurse-submodules https://github.com/openssl/openssl.git  openssl \
    && cd openssl \
    && ./config --prefix=${STAGING_DIR} shared  \
    && make > /dev/null 2>&1 \
    && make install \
    && cd /tmp \
    && rm -rf openssl \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && git clone --depth=1 https://github.com/protocolbuffers/protobuf.git \
    && cd protobuf \
    && ./autogen.sh > /dev/null 2>&1  \
    && ./configure --enable-samples --with-openssl=/usr --with-zlib=/usr --enable-silent-rules --prefix=${STAGING_DIR} \
    && make clean  > /dev/null 2>&1 \
    && make > /dev/null 2>&1 \
    && make install \
    && cd /tmp \
    && rm -rf protobuf \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && curl -L -O -k http://www-us.apache.org/dist//xerces/c/3/sources/xerces-c-3.2.2.tar.gz \
    && tar -xzf xerces-c-3.2.2.tar.gz \
    && cd xerces-c-3.2.2/ \
    && ./configure --prefix=${STAGING_DIR} \
        --enable-static --enable-shared --enable-netaccessor-socket \
        --enable-transcoder-gnuiconv --enable-transcoder-iconv \
        --enable-msgloader-inmemory --enable-xmlch-uint16_t --enable-xmlch-char16_t  \
    && make clean > /dev/null 2>&1 \
    && make > /dev/null 2>&1 \
    && make install > /dev/null 2>&1 \
    && cd /tmp \
    && rm xerces-c-3.2.2.tar.gz \
    && rm -rf xerces-c-3.2.2/ \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && curl -L -O -k https://www-us.apache.org/dist/apr/apr-${APR_VERSION}.tar.gz  \
    && tar -xzf apr-${APR_VERSION}.tar.gz \
    && cd apr-${APR_VERSION} \
    && ./configure --prefix=${STAGING_DIR} --enable-threads --enable-posix-shm \
        --enable-allocator-guard-pages --enable-pool-concurrency-check --enable-other-child  \
    && make clean > /dev/null 2>&1 \
    && make > /dev/null 2>&1 \
    && make install \
    && cd /tmp \
    && rm -rf apr-${APR_VERSION}.tar.gz apr-${APR_VERSION} \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && git clone --depth=1 https://github.com/libexpat/libexpat.git  \
    && cd libexpat/expat  \
    && ./buildconf.sh > /dev/null 2>&1 \
    && ./configure CPPFLAGS=-DXML_LARGE_SIZE --without-docbook --prefix=${STAGING_DIR} \
    && make > /dev/null 2>&1 \
    && make install \
    && cd /tmp \
    && rm -rf libexpat \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && curl -L -O -k https://www-us.apache.org/dist//apr/apr-util-${APU_VERSION}.tar.gz  \
    && tar -xzf apr-util-${APU_VERSION}.tar.gz  \
    && cd apr-util-${APU_VERSION} \
    && ./configure --prefix=${STAGING_DIR} --with-apr=${STAGING_DIR} --with-expat=${STAGING_DIR}  \
    && make clean > /dev/null 2>&1  \
    && make > /dev/null 2>&1 \
    && make install \
    && cd /tmp \
    && rm -rf apr-util-${APU_VERSION}.tar.gz apr-util-${APU_VERSION} \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && GIT_SSL_NO_VERIFY=1 git clone --depth=1 https://gitbox.apache.org/repos/asf/logging-log4cxx.git  \
    && cd logging-log4cxx  \
    && ./autogen.sh \
    && ./configure --prefix=${STAGING_DIR} --with-apr=${STAGING_DIR} --with-apr-util=${STAGING_DIR} \
        --enable-char --enable-wchar_t --with-charset=utf-8 --with-logchar=utf-8  \
    && make clean > /dev/null 2>&1 \
    && make > /dev/null 2>&1 \
    && make install \
    && cd /tmp \
    && rm -rf logging-log4cxx \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && git clone --depth=1 https://github.com/google/breakpad.git \
    && cd breakpad \
    && git clone https://chromium.googlesource.com/linux-syscall-support src/third_party/lss \
    && ./configure --prefix=${STAGING_DIR}  \
    && make > /dev/null 2>&1 \
    && make install \
    && cd /tmp \
    && rm -Rf breakpad \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

COPY qt-installer-script.qs qt-opensource-linux-x64-* /tmp/

#RUN objdump -p ./qt-opensource-linux-x64-${Q_VERSION}.run | grep NEEDED

RUN cd /tmp \
   && TimePoint="$(date +%s)" \
   && if [ ! -f "/tmp/qt-opensource-linux-x64-${Q_VERSION}.run" ]; \
		then \
			curl -k -L -O "http://download.qt.io/official_releases/qt/${Q_MAJOR_VERSION}/${Q_VERSION}/qt-opensource-linux-x64-${Q_VERSION}.run"; \
		fi \
   && chmod +x ./qt-installer-script.qs \
   && chmod +x ./qt-opensource-linux-x64-${Q_VERSION}.run \
   && xvfb-run ./qt-opensource-linux-x64-${Q_VERSION}.run --script ./qt-installer-script.qs --platform minimal --verbose \
   && rm -vf qt-opensource-linux-x64-${Q_VERSION}.run qt-installer-script.qs \
   && TimePoint="$(($(date +%s)-TimePoint))" \
   && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

ENV QT_INSTALL_DIR=/opt/Qt
ENV QTDIR=${QT_INSTALL_DIR}/${Q_VERSION}/gcc_64
ENV PATH="${QTDIR}/bin/:${QT_INSTALL_DIR}/Tools/QtCreator/bin:${PATH}:/opt/depot_tools"
ENV PKG_CONFIG_PATH=${QTDIR}/lib/pkgconfig:$PKG_CONFIG_PATH

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && GIT_SSL_NO_VERIFY=1 git clone https://git.videolan.org/git/x264.git \
    && cd x264 \
    && ./configure --prefix=${STAGING_DIR} --bit-depth=all --chroma-format=all --enable-pic --enable-shared \
    && make > /dev/null 2>&1 \
    && make install \
    && cd /tmp \
    && rm -rf x264 \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && curl -sL https://deb.nodesource.com/setup_13.x | bash - \
    && apt-get -qq install --assume-yes --no-install-recommends nodejs \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && curl -L -O -k https://freefr.dl.sourceforge.net/project/qwt/qwt/6.1.4/qwt-6.1.4.tar.bz2 \
    && tar xjvf qwt-6.1.4.tar.bz2 \
    && cd qwt-6.1.4 \
    && qmake qwt.pro \
    && make > /dev/null 2>&1 \
    && make install DESTDIR=${STAGING_DIR} \
    && cd /tmp \
    && rm -rf qwt-6.1.4.tar.bz2 qwt-6.1.4 \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && curl -L -O -k https://ftp.gnu.org/gnu/gsl/gsl-2.6.tar.gz \
    && tar -xzf gsl-2.6.tar.gz \
    && cd gsl-2.6 \
    && ./autogen.sh \
    && ./configure --enable-maintainer-mode --prefix=${STAGING_DIR} \
    && make -j$(nproc) > /dev/null 2>&1 \
    && make install \
    && cd /tmp \
    && rm -rf gsl-2.6.tar.gz gsl-2.6 \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && git clone --depth=1  https://github.com/ginkgo-project/ginkgo.git \
    && cd ginkgo \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=${STAGING_DIR} \
        -DGINKGO_BUILD_TESTS=OFF -DGINKGO_BUILD_EXAMPLES=OFF \
        -DCMAKE_C_COMPILER=/usr/bin/gcc -DCMAKE_CXX_COMPILER=/usr/bin/g++ \
        -DGINKGO_DEVEL_TOOLS=OFF -DGINKGO_BUILD_REFERENCE=ON \
        -DCMAKE_BUILD_TYPE=Release \
    && cmake --build build --target all --clean-first > /dev/null 2>&1 \
    && cmake --build build --target install \
    && cd /tmp \
    && rm -rf ginkgo \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && git clone --depth=1 https://github.com/CGAL/cgal.git \
    && cd cgal \
    && cmake -E make_directory cgal-build \
    && cmake -E chdir cgal-build cmake -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_CXX_FLAGS="-std=c++14" -DCGAL_HEADER_ONLY=OFF \
      -DCMAKE_CXX_FLAGS_RELEASE=-DCGAL_NDEBUG -DWITH_examples=OFF \
      -DWITH_demos=OFF -DWITH_tests=OFF \
      -DCMAKE_INSTALL_PREFIX=${STAGING_DIR} .. \
    && cmake --build cgal-build --target all --clean-first > /dev/null 2>&1 \
    && cmake --build cgal-build --target install \
    && cd /tmp/ \
    && rm -Rf cgal \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && git clone --depth=1 https://github.com/QuantStack/xsimd.git \
    && cd xsimd \
    && cmake -E make_directory xsimd-build \
    && cmake -E chdir xsimd-build cmake -DCMAKE_BUILD_TYPE=Release \
       -DCMAKE_INSTALL_PREFIX=${STAGING_DIR} .. \
    && cmake --build xsimd-build --target all --clean-first > /dev/null 2>&1 \
    && cmake --build xsimd-build --target install \
    && cd /tmp/ \
    && rm -Rf xsimd \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && git clone --depth=1 https://github.com/google/capture-thread.git \
    && cd capture-thread \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=${STAGING_DIR}  \
    && cmake --build build --target all --clean-first  \
    && cmake --build build --target install \
    && cd /tmp \
    && rm -rf capture-thread \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN echo -e '\033[36;1m ******* Below are commented section to investigate ******** \033[0m'

ARG GST_VERSION=1.16.1

# need libjpeg-dev
RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && git clone --depth=1 https://github.com/Motion-Project/motion.git \
    && cd motion \
    && autoreconf -fiv \
    && ./configure --without-ffmpeg --prefix=${STAGING_DIR} \
    && make clean  \
    && make \
    && make install \
    && cd /tmp \
    && rm -fr motion \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && git clone  --depth=1 git://git.linuxtv.org/v4l-utils.git \
    && cd v4l-utils \
    && autoreconf -vfi \
    && ./configure --prefix=${STAGING_DIR} \
    && make > /dev/null 2>&1 \
    && make install \
    && cd /tmp/ \
    && rm -Rf v4l-utils \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

#Automated static analysis tools for binary programs
RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && git clone  --depth=1 https://github.com/cmu-sei/pharos.git \
    && cd pharos \
    && cd /tmp/ \
    # && rm -Rf pharos \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && Time="$(date +%s)" \
    && git clone --depth=1 https://github.com/curl/curl.git \
    && cd curl \
    && cmake -E make_directory curl-build \
    && cmake -E chdir curl-build cmake -DCMAKE_BUILD_TYPE=Release \
       -DCMAKE_INSTALL_PREFIX=/usr/local .. \
    && cmake --build curl-build --target all --clean-first \
    && cmake --build curl-build --target install \
    && cd /tmp/ \
    && rm -Rf curl curl-build \
    && Time="$(($(date +%s)-Time))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((Time/86400))" "$((Time/3600%24))" "$((Time/60%60))" "$((Time%60))"

RUN cd /tmp \
    && Time="$(date +%s)" \
    && git clone --depth=1 https://github.com/Tencent/rapidjson.git \
    && cd rapidjson \
    && cmake -E make_directory rapidjson-build \
    && cmake -E chdir rapidjson-build cmake -DCMAKE_BUILD_TYPE=Release \
       -DCMAKE_INSTALL_PREFIX=/usr/local .. \
    && cmake --build rapidjson-build --target all --clean-first \
    && cmake --build rapidjson-build --target install \
    && cd /tmp/ \
    && rm -Rf rapidjson rapidjson-build boost-build \
    && Time="$(($(date +%s)-Time))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((Time/86400))" "$((Time/3600%24))" "$((Time/60%60))" "$((Time%60))"

FROM amd64/ubuntu:19.10

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN apt-get -qq -o Acquire::Check-Valid-Until="false" update --assume-yes \
    && apt-get -qq install --assume-yes --no-install-recommends \
      ca-certificates apt-transport-https \
      xz-utils unzip wget curl openssh-server openssh-client \
	  vim python3 hxtools perl xotcl tcl-expect tcl dos2unix \
	  libsqlite3-0 iptables jq htop most lsof

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && curl -sL https://deb.nodesource.com/setup_13.x | bash - \
    && apt-get -qq install --assume-yes --no-install-recommends nodejs \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

COPY --from=appsbuilder /opt/staging/bin /usr/local/bin
COPY --from=appsbuilder /opt/staging/lib/*.so /usr/local/lib/
COPY --from=appsbuilder /opt/Qt/5.13.2/gcc_64/lib/libQt*.so /usr/local/lib/

# Do some cleanup
RUN DEBIAN_FRONTEND=noninteractive  apt-get clean && \
  apt-get autoremove -y


RUN echo -e '\033[36;1m ******* CONTAINER START COMMAND ******** \033[0m'
CMD ["/bin/bash"]


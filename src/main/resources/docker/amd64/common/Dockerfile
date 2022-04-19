# %W% %G% %U%
#        cfs-com/src/main/resources/docker/amd64/common/Dockerfile
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

ARG BASE_IMAGE
FROM $BASE_IMAGE

ARG PROXY
ARG MAKEFLAGS_OPTIONS
ARG NOPROXY
ARG http_proxy=$PROXY
ARG https_proxy=$PROXY
ARG no_proxy=$NOPROXY
ARG HTTP_PROXY=$PROXY
ARG HTTPS_PROXY=$PROXY
ARG NO_PROXY=$NOPROXY

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN Time="$(date +%s)" \
    && apt-get -qq -o Acquire::Check-Valid-Until="false" update --assume-yes \
    && apt-get -qq install --assume-yes --no-install-recommends \
        ca-certificates apt-transport-https \
        libtool autotools-dev autopoint autoconf automake make autoproject bison flex \
        build-essential git xz-utils unzip wget curl openssh-server openssh-client \
        gawk vim vim-nox texinfo gtk-doc-tools autogen autogen-doc \

        python3-pip python3-dev python3-wheel cython3 python3-setuptools python3-tk \
        ruby ruby-dev libjpeg-dev libudev-dev libmpfr-dev libccrtp-dev \
        libglib2.0-dev libglib2.0-bin libglib2.0-0 hxtools\
        xvfb xauth libx11-xcb1 libfontconfig1 libfontconfig1-dev libdbus-1-3 libgl1-mesa-dev \
        libperl-dev perl perl-base perl-modules libgd-perl apt-utils gettext \
        yasm nasm xotcl-dev tcl-expect-dev tcl-dev docbook2x dos2unix \
        libpulse-dev libva-dev libxv-dev libelf-dev elfutils libelf1 \
        libavformat-dev libavutil-dev libdlna-dev libavcodec-dev uvcdynctrl \
        libtsan0 valgrind valgrind-dbg mscgen libgraphviz-dev xdot \
        display-dhammapada fortunes lsb-release libpng-dev libghc-graphviz-dev \
        libcrypto++-dev libgcrypt20-dev libpcap-dev libwiretap-dev bittwist tkpng \
        gnutls-bin ntopng pcaputils python3-pcapy tcpick tcpspy libgnutls30 \
        gobject-introspection liborc-0.4-dev liborc-0.4-dev-bin libgudev-1.0-dev \
        libogg-dev liboggz2-dev libisocodes-dev gir1.2-isocodes-1.2 libpng++-dev \
        libtheora-dev libtheora-bin libvorbis-dev libogg-vorbis-decoder-perl \
        iptables jq htop extra-cmake-modules libmicrohttpd-dev most lsof hxtools \
        ccache gcovr lcov node-lcov-parse tmux libsqlite3-dev gnupg2 libncurses5\
        libxkbcommon-x11-dev libxkbcommon-x11-0  p7zip-full zip libz3-dev  \
    && apt-get clean --assume-yes \
    && apt-get --assume-yes --quiet clean \
    && apt-get --assume-yes --quiet autoremove \
    && rm -rvf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/* \
    && rm -rf /usr/share/man/ \
    && Time="$(($(date +%s)-Time))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((Time/86400))" "$((Time/3600%24))" "$((Time/60%60))" "$((Time%60))"

# Set wget proxies
RUN [ -n "$http_proxy" ] && printf "use_proxy=yes\nhttp_proxy=$http_proxy\nhttps_proxy=$https_proxy\nno_proxy=$no_proxy" > /root/.wgetrc; exit 0

RUN echo -e '\033[36;1m ******* Differents builds tools installation ******** \033[0m'

ARG CMAKE_MAJOR_VERSION=${CMAKE_MAJOR_VERSION:-3.21}
ARG CMAKE_VERSION=${CMAKE_VERSION:-${CMAKE_MAJOR_VERSION}.3}

RUN cd /tmp \
    && Time="$(date +%s)" \
    && curl -L -O -k https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz \
    && tar -xvf cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz > /dev/null \
    && rm -v cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz \
    && mv -v cmake-${CMAKE_VERSION}-linux-x86_64 /opt/cmake \
    && Time="$(($(date +%s)-Time))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((Time/86400))" "$((Time/3600%24))" "$((Time/60%60))" "$((Time%60))"

RUN  cd /tmp \
    && Time="$(date +%s)" \
    && curl -L -O -k  https://github.com/ninja-build/ninja/releases/download/v1.10.2/ninja-linux.zip\
    && unzip ninja-linux.zip  \
    && mv ninja /usr/bin/ninja \
    && rm ninja-linux.zip \
    && Time="$(($(date +%s)-Time))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((Time/86400))" "$((Time/3600%24))" "$((Time/60%60))" "$((Time%60))"

ARG JDK_8_VERSION=${JDK_8_VERSION:-301}

RUN  cd /tmp \
    && Time="$(date +%s)" \
    && curl -L -O -k https://enos.itcollege.ee/~jpoial/allalaadimised/jdk8/jdk-8u${JDK_8_VERSION}-linux-x64.tar.gz \
    && tar -xzf jdk-8u${JDK_8_VERSION}-linux-x64.tar.gz -C /opt/ \
    && rm jdk-8u${JDK_8_VERSION}-linux-x64.tar.gz \
    && Time="$(($(date +%s)-Time))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((Time/86400))" "$((Time/3600%24))" "$((Time/60%60))" "$((Time%60))"

ARG MVN_VERSION=${MVN_VERSION:-3.8.5}
RUN cd /tmp \
    && Time="$(date +%s)" \
    &&  wget --no-check-certificate https://www-eu.apache.org/dist/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz \
    && tar -xzf apache-maven-${MVN_VERSION}-bin.tar.gz > /dev/null 2>&1 \
    && mv apache-maven-${MVN_VERSION}/ /opt/apache-maven \
    && rm -v apache-maven-${MVN_VERSION}-bin.tar.gz \
    && Time="$(($(date +%s)-Time))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((Time/86400))" "$((Time/3600%24))" "$((Time/60%60))" "$((Time%60))"

ARG GRADLE_VERSION=${GRADLE_VERSION:-7.4.2}
RUN cd /tmp \
    && Time="$(date +%s)" \
    && curl -L -O -k https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip \
    && mkdir -pv /opt/gradle \
    && unzip gradle-${GRADLE_VERSION}-bin.zip  \
    && mv gradle-${GRADLE_VERSION}  /opt/gradle/ \
    && rm -f gradle-${GRADLE_VERSION}-bin.zip \
    && Time="$(($(date +%s)-Time))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((Time/86400))" "$((Time/3600%24))" "$((Time/60%60))" "$((Time%60))"

ENV JAVA_HOME /opt/jdk1.8.0_${JDK_8_VERSION}
ENV JRE_HOME /opt/jdk1.8.0_${JDK_8_VERSION}/jre
ENV M2_HOME /opt/apache-maven/
ENV M2 $M2_HOME/bin
ENV MAVEN_OPTS "-Dstyle.info=bold,green -Dstyle.project=bold,magenta -Dstyle.warning=bold,yellow \
        -Dstyle.mojo=bold,cyan -Xmx1048m -Xms256m -XX:MaxPermSize=512M"
ENV PATH $PATH:/opt/apache-maven/bin/:/opt/jdk1.8.0_${JDK_8_VERSION}/bin:/opt/jdk1.8.0_${JDK_8_VERSION}/jre/bin:/opt/cmake/bin
ENV PATH $PATH:/opt/gradle/gradle-${GRADLE_VERSION}/bin

ARG BAZEL_VERSION=${BAZEL_VERSION:-5.1.1}
ARG BAZEL_TOOL_VERSION=${BAZEL_TOOL_VERSION:-5.1.0}

RUN cd /tmp \
    && Time="$(date +%s)" \
    && curl -L -O -k https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh \
    && chmod +x bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh  \
    && ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh  \
    && rm -f ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh \
    && Time="$(($(date +%s)-Time))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((Time/86400))" "$((Time/3600%24))" "$((Time/60%60))" "$((Time%60))"

RUN cd /tmp \
    && Time="$(date +%s)" \
    && curl -L -O -k https://github.com/bazelbuild/buildtools/releases/download/${BAZEL_TOOL_VERSION}/buildifier-linux-amd64 \
    && chmod +x buildifier-linux-amd64 && mv -v buildifier-linux-amd64 /usr/bin/buildifier \
    && curl -L -O -k https://github.com/bazelbuild/buildtools/releases/download/${BAZEL_TOOL_VERSION}/buildozer-linux-amd64 \
    && chmod +x buildozer-linux-amd64 && mv -v buildozer-linux-amd64 /usr/bin/buildozer \
    && curl -L -O -k https://github.com/bazelbuild/buildtools/releases/download/${BAZEL_TOOL_VERSION}/unused_deps-linux-amd64 \
    && chmod +x unused_deps-linux-amd64 && mv -v  unused_deps-linux-amd64 /usr/bin/unused_deps \
    && Time="$(($(date +%s)-Time))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((Time/86400))" "$((Time/3600%24))" "$((Time/60%60))" "$((Time%60))"

ARG BAZELISK_VERSION=${BAZELISK_VERSION:-1.11.1}
RUN cd /tmp \
    && Time="$(date +%s)" \
    && curl -L -O -k https://github.com/bazelbuild/bazelisk/releases/download/v${BAZELISK_VERSION}/bazelisk-linux-amd64 \
    && chmod +x bazelisk-linux-amd64 && mv -v bazelisk-linux-amd64 /usr/bin/bazelisk \
    && Time="$(($(date +%s)-Time))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((Time/86400))" "$((Time/3600%24))" "$((Time/60%60))" "$((Time%60))"

RUN cd /tmp \
    && Time="$(date +%s)" \
    && pip3 install --upgrade pip \
    && pip install -q --no-cache-dir conan \
    && pip install --upgrade conan_package_tools \
    && pip install cpplint \
    && pip3 install meson \
    && pip3 install cpplint-junit \
    && pip install cppcheck-junit \
    && pip install semver \
    && pip install semver-tool \
    && pip install lizard \
#    && pip install cpp-demangle \
    && pip install polysquare-cmake-linter \
    && pip install -U Sphinx \
    && pip3 install cmakedoc \
    && pip install cpp-coveralls \
    && pip install coverxygen \
    && pip install doxygen-junit \
    && pip3 install cornichon \
    && pip3 install python-afl \
    && pip3 install sphinx_rtd_theme sphinx sphinxcontrib-bibtex \
    && pip3 install nose coverage pytest pytest-cov \
    && pip3 install breathe \
    && pip install gdb-tools \
    && pip3 install licenseheaders \
    && Time="$(($(date +%s)-Time))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((Time/86400))" "$((Time/3600%24))" "$((Time/60%60))" "$((Time%60))"

RUN echo -e '\033[36;1m ******* Differnets QA tools installation ******** \033[0m'

ARG LLVM_VERSION=${LLVM_VERSION:-12.0.1}

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && curl -L -O -k https://github.com/llvm/llvm-project/releases/download/llvmorg-13.0.0/clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.04.tar.xz \
    && tar xvJf clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.10.tar.xz \
    && mv -v clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.10 /opt/clang-llvm-13.0.0 \
    && rm -Rvf clang+llvm-13.0.0-x86_64-linux-gnu-ubuntu-20.10.tar.xz \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

ENV PATH=${PATH}:/opt/clang-llvm-13.0.0/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/clang-llvm-13.0.0/lib

ARG GDB_VERSION=${GDB_VERSION:-11.2}
# Build and transform stdout into . to reduce the noise

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && curl -L -O -k http://ftp.gnu.org/gnu/gdb/gdb-${GDB_VERSION}.tar.gz \
    && tar -xzf gdb-${GDB_VERSION}.tar.gz \
    && mkdir gdb-${GDB_VERSION}-builds \
    && cd gdb-${GDB_VERSION}-builds \
    && ../gdb-${GDB_VERSION}/configure --prefix=/usr/local \
    && make -j $(nproc --all) | stdbuf -o0 tr -cd '\n' | stdbuf -o0 tr '\n' '.' \
    && make install \
    && make clean && ldconfig \
    && cd /tmp \
    && rm -rf gdb-${GDB_VERSION}.tar.gz gdb-${GDB_VERSION} gdb-${GDB_VERSION}-builds \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && git clone --depth=1 https://github.com/uncrustify/uncrustify.git \
    && TimePoint="$(date +%s)" \
    && cd uncrustify \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local  \
    && cmake --build build --target all --clean-first > /dev/null 2>&1 \
    && cmake --build build --target install \
    && cd /tmp \
    && rm -rf uncrustify \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && git clone --depth=1 https://github.com/danmar/cppcheck.git \
    && cd cppcheck \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local \
    && cmake --build build --target all --clean-first > /dev/null 2>&1 \
    && cmake --build build --target install \
    && cp --recursive --verbose cfg  /usr/local/bin || true \
    && cd /tmp \
    && rm -rf cppcheck \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && git clone --depth=1 https://github.com/doxygen/doxygen.git  \
    && cd doxygen \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local  \
    && cmake --build build --target all --clean-first > /dev/null 2>&1 \
    && cmake --build build --target install \
    && cd /tmp \
    && rm -rf doxygen \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cmake --version \
    && doxygen --version \
    && uncrustify --version \
    && cppcheck --version \
    && make --version \
    && mvn --version \
    && gradle -v \
    && bazel version \
    && conan --version || true \
    && gdb --version \
    && java -version \
    && clang --version \
    && clang-format --version \
    && clang-tidy -version \
    && gcc --version

#RUN cd /tmp \
#    && TimePoint="$(date +%s)" \
#    && git clone --depth=1 https://github.com/jeaye/stdman.git \
#    && cd stdman \
#    && ./configure --prefix=/usr/local \
#    && make install > /dev/null 2>&1 \
#    && cd /tmp \
#    && rm -Rf stdman \
#    && TimePoint="$(($(date +%s)-TimePoint))" \
#    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

# ENV MANPATH=${MANPATH}:/usr/local/man:/usr/local/share/man:/usr/share/man:/usr/man
# ENV MANPAGER=most

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && git clone --depth=1 https://github.com/catchorg/Catch2.git \
    && cd Catch2 \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DEXAMPLES=ON -DCOVERAGE=OFF -DEXTRAS=ON -DCMAKE_CXX_STANDARD=17 \
       -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD_REQUIRED=ON -DCMAKE_CXX_EXTENSIONS=OFF -DCMAKE_INSTALL_PREFIX=/usr/local \
    && cmake --build build --target all --clean-first > /dev/null 2>&1 \
    && cmake --build build --target install || true \
    && cd /tmp \
    && rm -Rf Catch2 \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && git clone --depth=1 https://github.com/google/breakpad.git \
    && cd breakpad \
    && git clone https://chromium.googlesource.com/linux-syscall-support src/third_party/lss \
    && ./configure --prefix=/usr/local  \
    && make > /dev/null 2>&1 \
    && make install \
    && make clean && ldconfig \
    && cd /tmp \
    && rm -Rf breakpad \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /opt \
    && git clone https://chromium.googlesource.com/chromium/tools/depot_tools

# Install repo
#RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo \
#  && chmod a+x /usr/bin/repo
# mkdir -p ~/.bin
# PATH="${HOME}/.bin:${PATH}"
# curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
# chmod a+rx ~/.bin/repo

COPY qt-installer-script.qs install-qt.sh  /tmp/

#RUN objdump -p ./qt-opensource-linux-x64-${Q_VERSION}.run | grep NEEDED

COPY install-qt.sh install-qt.sh

ARG QTCREATOR_VERSION=${QTCREATOR_VERSION:-4.15.2}

RUN cd /tmp \
   && TimePoint="$(date +%s)" \
   && chmod +x ./install-qt.sh \
   && ./install-qt.sh --directory /opt/Qt --host linux_x64 --target desktop  --version ${QTCREATOR_VERSION} qtcreator \
   && TimePoint="$(($(date +%s)-TimePoint))" \
   && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

ARG Q_MAJOR_VERSION=${Q_MAJOR_VERSION:-6.3}
ARG Q_VERSION=${Q_VERSION:-${Q_MAJOR_VERSION}.0}

ARG QT_SHA_256=0cd82c80287a783bd5db1339b6184803d57517c9450ffe16f505254853f0a41f
ARG T_MD5=c839aed9d551bdc8411a0a33e5ae46f3

# lists took from
# https://download.qt.io/online/qtsdkrepository/linux_x64/desktop/qt5_5141/Updates.xml
# https://download.qt.io/online/qtsdkrepository/linux_x64/desktop/qt5_5152/Updates.xml
# https://download.qt.io/online/qtsdkrepository/linux_x64/desktop/qt6_600/Updates.xml
# http://ftp.fau.de/qtproject/online/qtsdkrepository/linux_x64/desktop/qt6_601/Updates.xml
# https://download.qt.io/online/qtsdkrepository/linux_x64/desktop/qt6_630/Updates.xml
RUN cd /tmp \
   && TimePoint="$(date +%s)" \
   && ./install-qt.sh --directory /opt/Qt --host linux_x64 --target desktop --toolchain gcc_64 --version ${Q_VERSION} \
		qtbase qtdeclarative qttools \
   && TimePoint="$(($(date +%s)-TimePoint))" \
   && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

#        qtconnectivity qtx11extras qtwebchannel qtmultimedia qttranslations qtgraphicaleffects qtsvg qtdeclarative \
#		qtwebsockets qtimageformats qttools qtxmlpatterns qtsensors qtserialport qtlocation\
#		qtquickcontrols qtquickcontrols2 qt3d qtwebview qtserialbus qtscxml qtgamepad qtspeech qtcharts qtdatavis3d qtpurchasing\
#		qtvirtualkeyboard  qtwebengine qtnetworkauth qtwebglplugin qtlottie qtquick3d qtquicktimeline \
#		qtremoteobjects icu qtscript \
#qtactiveqt qtwinextras qtcanvas3d  d3dcompiler_47 opengl32sw

# https://download.qt.io/online/qtsdkrepository/linux_x64/desktop/tools_qtcreator/Updates.xml

# RUN cd /tmp \
   # && TimePoint="$(date +%s)" \
   # && chmod +x ./install-qt.sh \
   # && ./install-qt.sh --version ${Q_VERSION} qtbase qtdeclarative qtscript qttools qtx11extras icu \
   # && ./install-qt.sh --version ${QTCREATOR_VERSION} qtcreator \
   # && echo "export PATH=/opt/Qt/${Q_VERSION}/gcc_64/bin:/opt/Qt/Tools/QtCreator/bin:\${PATH}" > /etc/profile.d/qt.sh \
   # && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

#RUN cd /tmp \
#   && TimePoint="$(date +%s)" \
#   && if [ ! -f "/tmp/qt-opensource-linux-x64-${Q_VERSION}.run" ]; \
#		then \
#			curl -k -L -O "http://download.qt.io/official_releases/qt/${Q_MAJOR_VERSION}/${Q_VERSION}/qt-opensource-linux-x64-${Q_VERSION}.run"; \
#		fi \
#   && chmod +x ./qt-installer-script.qs \
#   && chmod +x ./qt-opensource-linux-x64-${Q_VERSION}.run \
#   && xvfb-run ./qt-opensource-linux-x64-${Q_VERSION}.run --script ./qt-installer-script.qs --platform minimal --verbose \
#   && rm -vf qt-opensource-linux-x64-${Q_VERSION}.run qt-installer-script.qs \
#   && TimePoint="$(($(date +%s)-TimePoint))" \
#   && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

ENV QT_INSTALL_DIR=/opt/Qt
ENV QT_BASE_DIR=${QT_INSTALL_DIR}/${Q_VERSION}
ENV QTDIR=${QT_INSTALL_DIR}/${Q_VERSION}/gcc_64
#:/opt/depot_tools
ENV PATH="${QTDIR}/bin/:${QT_INSTALL_DIR}/Tools/QtCreator/bin:${PATH}"
ENV LD_LIBRARY_PATH="${QTDIR}/lib/x86_64-linux-gnu:${QTDIR}/lib:${LD_LIBRARY_PATH}"
ENV PKG_CONFIG_PATH="${QTDIR}/lib/pkgconfig:${PKG_CONFIG_PATH}"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && curl -sL https://deb.nodesource.com/setup_17.x | bash - \
    && apt-get -qq install --assume-yes --no-install-recommends nodejs \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

# ARG QWT_RELEASE=${QWT_RELEASE:-6.2.0}
# RUN cd /tmp \
#    && TimePoint="$(date +%s)" \
#    && curl -L -O -k https://freefr.dl.sourceforge.net/project/qwt/qwt/${QWT_RELEASE}/qwt-${QWT_RELEASE}.tar.bz2 \
#    && tar xjvf qwt-${QWT_RELEASE}.tar.bz2 \
#    && cd qwt-${QWT_RELEASE} \
#    && qmake qwt.pro \
#    && make > /dev/null 2>&1 \
#    && make install DESTDIR=/usr/local \
#    && make clean && ldconfig \
#    && cd /tmp \
#    && rm -rf qwt-${QWT_RELEASE}.tar.bz2 qwt-${QWT_RELEASE} \
#    && TimePoint="$(($(date +%s)-TimePoint))" \
#    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

# ARG GST_VERSION=${GST_VERSION:-1.18.2}

RUN echo -e '\033[36;1m ******* Below are commented section to investigate ******** \033[0m'

# RUN cd /tmp \
  # && wget -O vscode-amd64.deb  https://go.microsoft.com/fwlink/?LinkID=760868 \
  # && dpkg -i vscode-amd64.deb \
  # &&  rm vscode-amd64.deb

#ADD ./src/main/resources/docker/amd64/vscode-ext.sh /tmp/

#RUN cd /tmp \
#    && chmod +x vscode-ext.sh\
#    && ./vscode-ext.sh \
#    && rm -vf vscode-ext.sh

RUN DEBIAN_FRONTEND=noninteractive  apt-get clean && \
  apt-get autoremove -y

RUN echo -e '\033[36;1m ******* CONTAINER START COMMAND ******** \033[0m'

CMD ["/bin/bash"]


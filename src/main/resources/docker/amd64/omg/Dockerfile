#        cfs-com/src/main/resources/docker/amd64/omg/Dockerfile
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

ARG DDS_DEV_IMAGE=docker.io/doevelopper/cfs-dev-tools-common:0.0.2
FROM $DDS_DEV_IMAGE

USER root

RUN git config --global url."https://github.com/".insteadOf "git@github.com:"
RUN git config --global url."https://".insteadOf git://
#RUN git config --global url."https".insteadOf "git+https"

ENV PKG_CONFIG_PATH=${QTDIR}/lib/pkgconfig:$PKG_CONFIG_PATH

ARG ACE_MAJOR_VERSION=6
ARG ACE_MINOR_VERSION=5
ARG ACE_PATCH_VERSION=6
ARG ACE_TAO_VERSION=${ACE_MAJOR_VERSION}.${ACE_MINOR_VERSION}.${ACE_PATCH_VERSION}
ARG ACE_TAO_RELEASE=${ACE_MAJOR_VERSION}_${ACE_MINOR_VERSION}_${ACE_PATCH_VERSION}

ARG OPENDDS_SECURITY_OPTIONS="--security"
ARG OPENDDS_BUILD_OPTIONS="--std=c++11 --ipv6 --openssl=/usr/local --xerces3=/usr/local --java --rapidjson --glib --boost=/usr/local"
ARG OPENDDS_BUILD_CONFIG_OPTIONS="--no-tests --no-inline --features=versioned_namespace=1 --macros=c++11=1 --no-debug --optimize"
ARG OPENDDS_QT_OPTIONS="--qt"
ARG DDS_BUILD_CONFIG_OPTIONS="--security --safety-profile=base --cmake=/opt/cmake/bin/"
ARG DDS_SAFETY_BASE_NO_BUILTIN_TOPICS="--safety-profile=base --no-built-in-topics"
ARG DDS_WITHOUTFEATURE="--no-inline --no-debug --no-built-in-topics --no-content-subscription --no-ownership-profile --no-object-model-profile --no-persistence-profile --security"
ARG DDS_BUILD_MACRO="--macros=CPPFLAGS+=-Wno-deprecated -Wno-unused-result"
ARG DDS_BUILD_MACRO_1="--macros=CPPFLAGS+=-Wno-deprecated-declarations -Wno-implicit-fallthroug -Wno-unused-result"
ARG EXTENDED_DDS_BUILD_SECURITY_OPTIONS="--security --safety-profile=base"
ARG DDS_BUILD_DISSECT_OPTIONS="--qt --wireshark=/usr/local/"

ARG DDS_BASE_DIR=/opt/dds
# ARG DDS_INSTALL_DIR=/opt/dds
ARG DDS_INSTALL_DIR=/usr/local/midleware

RUN cd /tmp \
    && rm -Rvf MPC \
    && git clone --depth=1 https://github.com/DOCGroup/MPC.git \
    && git clone --depth=1 https://github.com/DOCGroup/ACE_TAO.git \
    && git clone --depth=1 https://github.com/DOCGroup/CIAO.git \
    && git clone --depth=1 https://github.com/DOCGroup/DAnCE.git \
    && git clone --depth=1 https://github.com/DOCGroup/XSC.git \
    && git clone --depth=1 --recurse-submodules https://github.com/objectcomputing/OpenDDS.git \
    && git clone --depth=1 https://github.com/omg-dds/dds-rtps.git \
    && git clone --depth=1 https://github.com/omg-dds/dds-xtypes.git \
    && git clone --depth=1 https://github.com/omg-dds/dds-security.git \
    && git clone --depth=1 https://github.com/RemedyIT/dancex11.git \
    && git clone --depth=1 https://github.com/RemedyIT/taox11.git \
    && git clone --depth=1 https://github.com/RemedyIT/ciaox11.git

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && cd OpenDDS \
    && ./configure --help \
    && export ACE_TAO_ROOT=/tmp/ACE_TAO \
    && export ACE_ROOT=$ACE_TAO_ROOT/ACE \
    && export TAO_ROOT=$ACE_TAO_ROOT/TAO \
    && export CIAO_ROOT=/tmp/CIAO \
    && export DANCE_ROOT=/tmp/DAnCE \
    && export MPC_ROOT=/tmp/MPC \
    && export XSC_ROOT=/tmp/XSC \
    && export XERCESCROOT=/usr/local \
#    && export PATH=/opt/Qt/5.14.1/gcc_64/include:$PATH \
    && export LD_LIBRARY_PATH=/tmp/OpenDDS/lib:/tmp/OpenDDS/build/target/lib:$ACE_ROOT/lib:$LD_LIBRARY_PATH \
    && export LD_LIBRARY_PATH=${XSC_ROOT}/XSC/utils:${XSC_ROOT}/lib:/usr/local/lib/:$LD_LIBRARY_PATH \
    #&& echo "#include \"ace/config-linux.h\"" >> $ACE_ROOT/ace/config.h \
    && ./configure --prefix=/usr/local \
    # && ./configure --prefix=/usr/local \
 #           ${OPENDDS_BUILD_OPTIONS} \
            ${OPENDDS_BUILD_CONFIG_OPTIONS} \
            ${OPENDDS_SECURITY_OPTIONS} \
            ${OPENDDS_QT_OPTIONS} \
#NOK            --wireshark=/opt/dds/include/wireshark \
            --cmake=/opt/cmake/bin/ \
# OK            --wireshark-cmake=/tmp/wireshark \
# OK            --wireshark-build=/tmp/wireshark/wireshark-build \
# OK            --wireshark-lib=/tmp/wireshark/wireshark-build/run \
            --ace=$ACE_ROOT \
            --tao=$TAO_ROOT \
            --mpc=$MPC_ROOT \
            --qt=/opt/Qt/5.14.2/gcc_64 \
            --std=c++11 --ipv6 \
            --openssl=/usr/local \
            --xerces3=/usr/local \
            --java --rapidjson --glib \
            --boost=/usr/local \
            --mpcopts="-workers 4" \
#           --features="uses_wchar=1" \   void error: cannot convert ‘const char*’ to ‘const ACE_TCHAR* ....
            --features="versioned_namespace=1" \
            --features="xerces3=1" \
            --features="ssl=1" \
            --macros="xerces3=1" \
            --macros="ssl=1" \
            --macros="c++11=1" \
            --macros="CPPFLAGS+=-Wno-deprecated -Wno-unused-result" \
            --macros="CPPFLAGS+=-Wno-deprecated-declarations -Wno-implicit-fallthrough -Wno-unused-result" \
            ### --configh="#define ACE_FACE_SAFETY_BASE" \
    && ./tools/scripts/show_build_config.pl \
    && make -j$(nproc) \
    && make INSTALL_PREFIX=/usr/local install \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && cd DAnCE \
    && export MPC_ROOT=/tmp/MPC \
    && export ACE_TAO_ROOT=/tmp/ACE_TAO \
    && export ACE_ROOT=$ACE_TAO_ROOT/ACE \
    && export TAO_ROOT=$ACE_TAO_ROOT/TAO \
    && export CIAO_ROOT=/tmp/CIAO \
    && export DANCE_ROOT=/tmp/DAnCE \
	&& $ACE_ROOT/bin/mwc.pl -type gnuace -workers $(nproc) DAnCE_TAO.mwc \
    && make -j$(nproc) \
    && make INSTALL_PREFIX=/usr/local install \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"


RUN cd /tmp \
    && TimePoint="$(date +%s)" \
    && cd CIAO \
    && export MPC_ROOT=/tmp/MPC \
    && export ACE_TAO_ROOT=/tmp/ACE_TAO \
    && export ACE_ROOT=$ACE_TAO_ROOT/ACE \
    && export TAO_ROOT=$ACE_TAO_ROOT/TAO \
    && export CIAO_ROOT=/tmp/CIAO \
    && export DANCE_ROOT=/tmp/DAnCE \
    && export DDS_ROOT=/tmp/OpenDDS \
    && export PATH="${PATH}:/tmp/ACE_TAO/ACE/bin:/tmp/ACE_TAO/TAO/bin:/usr/local/bin" \
	&& $ACE_ROOT/bin/mwc.pl -type gnuace -workers $(nproc) CIAO_TAO_DAnCE_OpenDDS.mwc \
    && make -j$(nproc) \
    && make INSTALL_PREFIX=/usr/local install \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

ENV \
    ACE_ROOT=/usr/local/share/ace \
    CIAO_ROOT=/usr/local/share/ciao \
    DANCE_ROOT=/usr/local/share/dance \
    DDS_ROOT=/usr/local/share/dds \
    TAO_ROOT=/usr/local/share/tao \
    SSL_ROOT=/usr/local \
    BOOST_ROOT=/usr/local \
    GLIB_ROOT=/usr \
    MPC_ROOT=/tmp/MPC \
    XERCESCROOT=/usr/local \
    PROTOBUF_HOME=/usr/local

	# LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/local/lib:${ACE_ROOT}/tao:${ACE_ROOT}/lib:${ACE_ROOT}/TAO/orbsvcs" \
	# MPC_ROOT=/tmp/MPC \
    # PATH="${PATH}:/usr/local/bin:"

ARG ACCOUNT=${ACCOUNT:-developer}

RUN adduser --system --home /home/${ACCOUNT} --shell /bin/bash \
    --gecos GECOS --group --disabled-password --quiet ${ACCOUNT}
USER $ACCOUNT
WORKDIR /home/$ACCOUNT

CMD ["/bin/bash"]


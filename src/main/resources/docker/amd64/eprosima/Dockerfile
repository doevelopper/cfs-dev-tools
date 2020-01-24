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

ARG DDS_DEV_IMAGE=docker.io/doevelopper/cfs-dev-tools-common:0.0.1
FROM $DDS_DEV_IMAGE

USER root
RUN cd /tmp \
    && git clone --depth=1 --recurse-submodules https://github.com/foonathan/memory.git \
    && cd memory \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_CXX_FLAGS="-Wall -Wextra -pedantic" -DCMAKE_INSTALL_PREFIX=/usr/local \
        -DBUILD_SHARED_LIBS=ON \
    && cmake --build build --target all --clean-first --parallel \
    && cmake --build build --target install \
    && cd /tmp \
    && rm -rf memory

ENV OPENSSL_ROOT_DIR  /usr/local

RUN cd /tmp \
    && git clone --depth=1 --recurse-submodules https://github.com/eProsima/Fast-RTPS.git \
    && cd Fast-RTPS \
    && cmake -E make_directory build \
    && cmake -E chdir build cmake .. -DSECURITY=ON -DPERFORMANCE_TESTS=ON  \
        -DTHIRDPARTY=ON -DBUILD_JAVA=ON -DPERFORMANCE_TESTS=ON \
        -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS=ON \
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    && cmake --build build --target all --clean-first \
    && cmake --build build --target install \
    && cd /tmp \
    && rm -rf Fast-RTPS

RUN cd /tmp \
    && git clone --depth=1 --recurse-submodules https://github.com/eProsima/Fast-RTPS-Gen.git \
    && cd Fast-RTPS-Gen \
    && gradle assemble \
    && cp -v share/fastrtps/fastrtpsgen.jar  /opt/cmake/bin/ \
    && cd /tmp/ \
    && java -jar /opt/cmake/bin/fastrtpsgen.jar -version \
    && rm -Rvf Fast-RTPS-Gen \

#RUN cd /tmp \
#    && TimePoint="$(date +%s)" \
#    && git clone --depth=1 --recurse-submodules --single-branch --branch feature/fastrtps-1.8.1 https://github.com/eProsima/RPC.git \
#    && cd RPC \
#    && cmake -E make_directory rpc-build \
#    && cmake -E chdir rpc-build cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -DWITH_FASTRTPS=ON -DRPCPROTO=rpcdds \
#    && cmake --build rpc-build --target all --clean-first \
#    && cmake --build rpc-build --target install \
#    && cd /tmp \
#    && rm -rf RPC \
#    && TimePoint="$(($(date +%s)-TimePoint))" \
#    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

ARG ACCOUNT=${ACCOUNT:-developer}
RUN addgroup --quiet --force-badname --system dev
RUN adduser --quiet --system --ingroup dev --disabled-login \
    --disabled-password --home /home/${ACCOUNT} --force-badname --gecos "DDS apps runner" \
    --shell /bin/bash ${ACCOUNT}

USER $ACCOUNT
WORKDIR /home/$ACCOUNT
CMD ["/bin/bash"]


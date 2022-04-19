#        cfs-dev-tools/src/main/resources/docker/dind/Dockerfile
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
#        WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

ENV DOCKER_COMPOSE_VERSION ${DOCKER_COMPOSE_VERSION:-v2.4.1}
ENV KUBE_LATEST_VERSION ${KUBE_LATEST_VERSION:-v1.15.0}
ENV HELM_VERSION ${HELM_VERSION:-v3.8.2}
ENV DOCTL_VERSION ${DOCTL_VERSION:-1.73.0}

RUN apt-get update \
    && TimePoint="$(date +%s)" \
    && apt-get install curl git make wget unzip locales git-flow\
        software-properties-common apt-transport-https ca-certificates \
        gnupg2 lsb-release python3-pip python3-dev python3-wheel cython3 python3-setuptools --assume-yes \
    && curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - \
    && add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install docker-ce docker-ce-cli containerd.io --assume-yes\
    && apt-get autoremove --assume-yes \
    && apt-get clean --assume-yes \
    && rm -rf /var/lib/apt/lists/* \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && Time="$(date +%s)" \
    && pip3 install --upgrade pip \
    && pip3 install molecule \
    && pip3 install ansible \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && Time="$(date +%s)" \
    && curl -k -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && docker-compose --version \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"


# # # Install Kubectl
# # Note: Latest version of kubectl may be found at:
# # https://aur.archlinux.org/packages/kubectl-bin/

RUN cd /tmp \
    && Time="$(date +%s)" \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

# # # Install helm
# # Note: Latest version of helm may be found at:
# # https://github.com/kubernetes/helm/releases

RUN cd /tmp \
    && Time="$(date +%s)" \
    && wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && Time="$(date +%s)" \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip  \
    && ./aws/install \
    && rm -Rvf awscliv2.zip \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && Time="$(date +%s)" \
    && curl --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp \
    && mv /tmp/eksctl /usr/local/bin \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

# # Install doctl
RUN cd /tmp \
    && Time="$(date +%s)" \
    && curl --location https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VERSION}/doctl-${DOCTL_VERSION}-linux-amd64.tar.gz | tar xz -C /tmp \
    && mv /tmp/doctl /usr/local/bin \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

RUN cd /tmp \
    && Time="$(date +%s)" \
    && docker version || true \
    && docker-compose version || true \
    && helm version --client || true \
    && helm help || true \
    && kubectl version || true \
    && aws --version || true \
    && eksctl version || true \
    && doctl version \
    && TimePoint="$(($(date +%s)-TimePoint))" \
    && printf "Build time: %dd %02d:%02d:%02d\n" "$((TimePoint/86400))" "$((TimePoint/3600%24))" "$((TimePoint/60%60))" "$((TimePoint%60))"

CMD ["/bin/bash"]


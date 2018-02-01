FROM alpine:3.7
MAINTAINER "Aaron Ng" <aaron@9space.io>

RUN apk update && apk upgrade

RUN apk add --no-cache \
 bash \
 curl \
 jq \
 openssh

# RELEASES

## Node.JS
ENV NODE_VERSION=8.9.3 NPM_VERSION=5.5.1

## Platform
ENV PLATFORM linux-amd64

## Kubernetes kubectl
# https://github.com/kubernetes/kubernetes/releases
ENV KUBECTL_VERSION v1.8.4

## CoreOS Kube AWS
# https://github.com/coreos/kube-aws/releases
ENV KUBE_AWS_VERSION 0.9.9

## Helm - Package manager for Kubernetes
# https://docs.helm.sh/using-helm/#install-helm
ENV HELM_VERSION v2.7.2

## Install node
RUN apk add --no-cache nodejs && \
  rm -rf /root/.npm /root/.node-gyp /root/.gnupg \
  /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html

## Install git
RUN apk add --no-cache git

# INSTALL Ruby
# INSTALL GitLab
RUN apk add --no-cache \
  ca-certificates \
  ruby \
  ruby-irb \
  ruby-dev \
  ruby-rdoc && \
  rm -fr /usr/share/ri && \
 curl -L https://rubygems.org/rubygems/rubygems-2.6.6.tgz -o /tmp/rubygems-2.6.6.tgz && \
 cd /tmp && \
 tar xvfz /tmp/rubygems-2.6.6.tgz && \
 cd /tmp/rubygems-2.6.6 && \
 ruby setup.rb --no-doc && \
 gem install gitlab && \
 cd && rm -rf /tmp/rubygems-2.6.6 && \
# apk del ruby-irb ruby-dev ruby-rdoc
 apk del ruby-irb ruby-dev

## Install kubectl
RUN curl -O https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
     chmod +x kubectl && \
     mv kubectl /usr/local/bin/kubectl

## Install kube-aws
RUN curl -L https://github.com/coreos/kube-aws/releases/download/v${KUBE_AWS_VERSION}/kube-aws-${PLATFORM}.tar.gz -o /tmp/kube-aws-${PLATFORM}.tar.gz && \
    tar -zxvf /tmp/kube-aws-${PLATFORM}.tar.gz && \
    mv ${PLATFORM}/kube-aws /usr/local/bin && \
    rm -rf ${PLATFORM} && \
    rm -f /tmp/kube-aws-${PLATFORM}.tar.gz && \
    kube-aws version

## Install helm
RUN curl -L https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-${PLATFORM}.tar.gz -o /tmp/helm-${HELM_VERSION}-${PLATFORM}.tar.gz && \
    tar -zxvf /tmp/helm-${HELM_VERSION}-${PLATFORM}.tar.gz && \
    mv ${PLATFORM}/helm /usr/local/bin && \
    rm -rf ${PLATFORM} && \
    rm -f /tmp/helm-${HELM_VERSION}-${PLATFORM}.tar.gz && \
    which helm

## Install aws-cli
RUN apk --no-cache add \
  python3 groff less && \
  cd /usr/bin && \
  ln -sf python3 python && \
  curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && \
  unzip awscli-bundle.zip && \
  ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && \
  rm awscli-bundle.zip && \
  rm -rf awscli-bundle && \
  rm -rf /usr/share/man /tmp/* /var/cache/apk/*

## Install useful tools and utilities
RUN npm install -g yamljs

## Install docker
ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.13.1
ENV DOCKER_SHA256 97892375e756fd29a304bd8cd9ffb256c2e7c8fd759e12a55a6336e15100ad75

RUN set -x \
	&& curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
	&& echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
	&& tar -xzvf docker.tgz \
	&& mv docker/* /usr/local/bin/ \
	&& rmdir docker \
	&& rm docker.tgz \
	&& docker -v

## Install ninecloud
ADD ncloud /home/ncloud/ncloud
ADD ncshell /home/ncloud/ncshell
ADD lib /home/ncloud/lib
ADD commands /home/ncloud/commands
ADD ncloud-entrypoint.sh /home/ncloud

ADD ncloud /usr/sbin
ADD docker-entrypoint.sh /usr/sbin
ADD ncloud-entrypoint.sh /usr/sbin

WORKDIR /root/

EXPOSE 22 80
ENTRYPOINT ["docker-entrypoint.sh"]
#CMD ["/usr/sbin/sshd", "-D"]

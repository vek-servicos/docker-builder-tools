# vek_docker_image=vekservicos/docker-builder-tools:ubuntu
# docker build -t $vek_docker_image .
# docker run --rm -it --name ${vek_docker_image} --mount type=bind,source="$(pwd)",target=/vek-app ${vek_docker_image}
# docker run --rm -it -v ~/.aws:/root/.aws -v ~/.m2:/root/.m2 -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/root/.gitconfig -v /var/run/docker.sock:/var/run/docker.sock -v ~/.kube:/root/.kube -v $(pwd):/vek-app $vek_docker_image

FROM ubuntu:18.04 AS ubuntu

# Arguments
# ARG DEBIAN_FRONTEND=noninteractive

# Environment
# ENV DEBIAN_FRONTEND=${DEBIAN_FRONTEND}

# Update repository
RUN apt-get update -yqq

# Base tools
RUN apt-get install -fyqq apt-utils
RUN apt-get install -fyqq dialog
RUN apt-get install -fyqq sudo

# Tools
RUN sudo apt-get install -fyqq bash
RUN sudo apt-get install -fyqq openssh-client
RUN sudo apt-get install -fyqq git
RUN sudo apt-get install -fyqq sed
RUN sudo apt-get install -fyqq gawk
RUN sudo apt-get install -fyqq tar
RUN sudo apt-get install -fyqq gzip
RUN sudo apt-get install -fyqq rsync
RUN sudo apt-get install -fyqq curl
RUN sudo apt-get install -fyqq wget
RUN sudo apt-get install -fyqq xmlstarlet
RUN sudo apt-get install -fyqq lsb
RUN sudo apt-get install -fyqq jq

# Language Pack
# RUN sudo apt-get install -fyqq locales
# RUN sudo apt-get install -fyqq language-pack-en-base language-pack-en
# RUN sudo locale-gen en_US.UTF-8 > /dev/null
# RUN sudo apt-get install -fyqq language-pack-pt-base language-pack-pt
# RUN sudo locale-gen pt_BR.UTF-8 > /dev/null
# RUN sudo localedef -f UTF-8 -i pt_BR pt_BR.UTF-8
# RUN sudo update-locale LANG=pt_BR.UTF-8
# RUN sudo update-locale LC_ALL=pt_BR.UTF-8

# Time Zone
# ENV TZ=America/Sao_Paulo
# RUN sudo apt-get install -fyqq dbus
# RUN sudo apt-get install -fyqq tzdata
# # timedatectl set-timezone "${TZ}" - não funciona
# RUN sudo rm -f /etc/localtime
# RUN sudo echo "${TZ}" > /etc/timezone
# RUN sudo dpkg-reconfigure --frontend noninteractive tzdata

# Python/Pip
# RUN sudo apt-get install -fyqq python python-pip
RUN sudo --set-home apt-get install -fyqq python3 python3-pip
# RUN sudo --set-home pip2 install --upgrade pip
RUN sudo --set-home pip3 install --quiet --upgrade pip
RUN sudo --set-home pip3 install --quiet --upgrade awscli

# Snap Package Manager
# RUN sudo apt-get install -fyqq snapd
# RUN sudo apt-get install -fyqq snapcraft

# Remove old Docker
# RUN sudo apt-get autoremove -fyqq docker docker-engine docker-ce docker.io containerd containerd.io runc lxc-docker lxc lxd

# Install Docker dependencies
RUN sudo apt-get install -fyqq apt-transport-https ca-certificates curl software-properties-common gnupg-agent

# Docker by Snap
# RUN snap install docker

# Docker by docker.io
# RUN apt-cache madison docker.io
# RUN apt-cache policy docker.io
RUN sudo apt-get install -fyqq docker.io=18.09.*

# Docker by docker.com
# RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# RUN sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# RUN sudo apt-get update -yq
# RUN apt-cache madison docker-ce
# RUN apt-cache policy docker-ce
# RUN sudo apt-get install -fyqq docker-ce=5:18.09.* docker-ce-cli=5:18.09.* containerd.io

# Put current user into the Docker Group
RUN sudo usermod -aG docker $(whoami)

# Install aws-iam-authenticator
# sudo curl --silent --location -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator
# sudo curl --silent --location -o /usr/local/bin/aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.3.0/heptio-authenticator-aws_0.3.0_linux_amd64
RUN sudo curl --silent --location -o /usr/local/bin/aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.4.0/aws-iam-authenticator_0.4.0_linux_amd64
RUN sudo chmod +x /usr/local/bin/aws-iam-authenticator
# aws-iam-authenticator version

# Install KUBECTL
# sudo curl --silent --location -o /usr/local/bin/kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/kubectl
# sudo curl --silent --location -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN sudo curl --silent --location -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.15.0/bin/linux/amd64/kubectl
RUN sudo chmod +x /usr/local/bin/kubectl
# kubectl version

# Install EKSCTL
# sudo curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | sudo tar xz -C /usr/local/bin
RUN sudo curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/0.1.38/eksctl_$(uname -s)_amd64.tar.gz" | sudo tar xz -C /usr/local/bin
RUN sudo chmod +x /usr/local/bin/eksctl
# eksctl version

# Clean environment
RUN sudo apt-get install -fyqq
RUN sudo apt-get autoremove -yqq
# RUN sudo apt-get clean -yqq
RUN sudo apt-get autoclean -yqq

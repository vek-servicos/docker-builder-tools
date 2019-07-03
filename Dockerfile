# vek_docker_image=vekservicos/docker-builder-tools:ubuntu
# docker build -t $vek_docker_image .
# docker run --rm -it --name ${vek_docker_image} --mount type=bind,source="$(pwd)",target=/vek-app ${vek_docker_image}
# docker run --rm -it -v ~/.aws:/root/.aws -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/root/.gitconfig -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/vek-app $vek_docker_image

FROM ubuntu:18.04 AS ubuntu

# Update repository
RUN apt-get update -yqq

# Base tools
RUN apt-get install -fyqq apt-utils
RUN apt-get install -fyqq sudo

# Tools
RUN sudo apt-get install -fyqq bash
RUN sudo apt-get install -fyqq openssh-client
RUN sudo apt-get install -fyqq git
RUN sudo apt-get install -fyqq sed
RUN sudo apt-get install -fyqq gawk
RUN sudo apt-get install -fyqq tar
RUN sudo apt-get install -fyqq rsync
RUN sudo apt-get install -fyqq curl
RUN sudo apt-get install -fyqq wget
RUN sudo apt-get install -fyqq xmlstarlet
RUN sudo apt-get install -fyqq lsb

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
RUN sudo apt-get install -fyqq python3 python3-pip
# RUN sudo pip2 install --upgrade pip
RUN sudo pip3 install --quiet --upgrade pip
RUN sudo pip3 install --quiet --upgrade awscli

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

# Clean environment
RUN sudo apt-get install -fyqq
RUN sudo apt-get autoremove -yqq
# RUN sudo apt-get clean -yqq
RUN sudo apt-get autoclean -yqq

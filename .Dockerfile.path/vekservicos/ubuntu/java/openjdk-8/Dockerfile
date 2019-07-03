# vek_docker_image=vekservicos/docker-builder:openjdk-8
# docker build -t $vek_docker_image .
# docker run --rm -it -v ~/.aws:/root/.aws -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/root/.gitconfig -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/vek-app $vek_docker_image

FROM vekservicos/docker-builder:ubuntu AS builder

# Open Java JDK
RUN sudo apt-get install -fyqq openjdk-8-jdk
RUN echo JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/environment

# Oracle Java JDK by webupd8team
# RUN sudo apt-get install -fyqq software-properties-common
# RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
# RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true"   | sudo debconf-set-selections
# RUN sudo add-apt-repository -y ppa:webupd8team/java
# RUN sudo apt-get update -yq
# RUN sudo apt-get install -fyqq oracle-java8-installer
# RUN sudo apt-get install -fyqq oracle-java8-set-default
# RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /etc/environment

# Oracle Java JDK by Oracle

# Set environments to be called at start
RUN echo "source /etc/environment" >> /etc/bash.bashrc

# Troca o Java Default
# sudo update-alternatives --config java
# sudo update-alternatives --config javac

# vek_docker_image=vekservicos/docker-builder:maven
# docker build -t $vek_docker_image .
# docker run --rm -it -v ~/.aws:/root/.aws -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/root/.gitconfig -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/vek-app $vek_docker_image "commands"

FROM vekservicos/docker-builder:openjdk-8 AS java

# Install Maven
RUN sudo apt-get install -fyqq maven

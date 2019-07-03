# vek_docker_image=vekservicos/docker-builder-tools:ubuntu
# docker build -t $vek_docker_image .
# docker run --rm -it --name ${vek_docker_image} --mount type=bind,source="$(pwd)",target=/vek-app ${vek_docker_image}
# docker run --rm -it -v ~/.aws:/root/.aws -v ~/.ssh:/root/.ssh -v ~/.gitconfig:/root/.gitconfig -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/vek-app $vek_docker_image

FROM vekservicos/docker-builder-tools:latest AS ubuntu

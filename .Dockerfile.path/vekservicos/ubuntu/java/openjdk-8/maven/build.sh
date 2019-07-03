#!/bin/sh

# // Docker Properties
export docker_file='Dockerfile'
export docker_files='.'
export docker_registry=''
export docker_path="vekservicos"
export docker_image="docker-builder"
export docker_tag="maven"

# export docker_image_full="${docker_registry}/${docker_path}/${docker_image}:${docker_tag}"
# export docker_image_full="${docker_registry}/${docker_image}:${docker_tag}"
# export docker_image_full="${docker_path}/${docker_image}:${docker_tag}"

docker build $* --tag ${docker_path}/${docker_image}:${docker_tag} --file ${docker_file} ${docker_files}
# docker tag ${docker_image}:${docker_tag} ${docker_path}/${docker_image}:${docker_tag}

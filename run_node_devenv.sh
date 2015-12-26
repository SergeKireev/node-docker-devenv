#!/bin/bash

LOCAL_PORT=6000
CONTAINER_PORT=22
HOST_WEB_PORT=8080
CONTAINER_WEB_SERVER_PORT=5000

MONGO_PORT=27017

DOCKER_NAME=node_devenv
DOCKER_IMAGE_NAME=node_devenv

NODE_GIT_REPO=$1

if [ "$1" != "" ]
then
    echo "Launching Node devenv\n"
    docker run -it --privileged -d -p ${LOCAL_PORT}:${CONTAINER_PORT} -p ${HOST_WEB_PORT}:${CONTAINER_WEB_SERVER_PORT} --name ${DOCKER_NAME} -v /net:/net -v ${RVIEWR_GIT_REPO}:/repo -v /dev:/dev ${DOCKER_IMAGE_NAME} 

else
    echo "Usage $0: <git_repo>"

fi

#!/bin/bash
IMAGE=$1
if [ -z "$IMAGE" ]; then
    docker images
    IMAGE=travis/esp8266:18.04
fi
echo "use $IMAGE"
mkdir -p docker
docker run --init -v $PWD/docker:/docker -i -t --net="host" --privileged  --name esp8266 $IMAGE  /bin/bash


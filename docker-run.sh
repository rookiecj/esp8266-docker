#!/bin/bash
IMAGE=$1
if [ -z "$IMAGE" ]; then
    docker images
    IMAGE=travis/esp8266:16.04
    echo "use travis/esp8266:16.04"
fi
mkdir -p docker
docker run -v $PWD/../docker:/docker -i -t --net="host" --privileged  --name esp8266 $IMAGE  /bin/bash


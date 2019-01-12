#!/bin/bash
IMAGE=$1
if [ -z "$IMAGE" ]; then
    docker images
    IMAGE=travis/esp8266:18.04
    echo "use travis/esp8266:18.04"
fi

if [ ! -d ../docker-share ]; then
    echo >&2 "make docker-share folder first"
    exit 1
fi

# remove tinit and add --init option instead
docker run -v ../docker-share:/docker \
    --init \
    --net="host" \
    --privileged  \
    -i -t \
    --name esp8266 $IMAGE  \
    /bin/bash


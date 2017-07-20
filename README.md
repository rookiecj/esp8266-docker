# esp8266-docker
docker file for building esp8266 f/w including nodemcu

esp8266-docker file provides a ubuntu 16.04 image for building esp-open-sdk and nodemcu f/w.
it doesn't include f/w itself but environment for the building.

# Build
`docker build -t esp8266:latest --force-rm .`

# Run
you should mount a host folder under /docker on a container as follows:
`docker run -v $PWD/docker:/docker -it --net="host" --privileged --entrypoint /bin/bash --name esp8266 esp8266`

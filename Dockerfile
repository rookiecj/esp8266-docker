FROM ubuntu:16.04
MAINTAINER rookiecj <rookiecj@gmail.com>

# esp open sdk
RUN apt-get update && apt-get install -yq \
    make unrar-free autoconf automake libtool gcc g++ gperf \
    flex bison texinfo gawk ncurses-dev libexpat-dev python-dev python python-serial \
    sed git unzip bash help2man wget bzip2

   
# missing dependencies
RUN apt-get install -yq \
    build-essential \
    libtool-bin \
    python-pip \
    sudo \
    tmux \
    vim 

# nodemcu
RUN apt-get install -yq srecord bc xz-utils 

# add user esp8266 
RUN useradd -s /bin/bash -m -G plugdev,dialout esp8266 
RUN echo "esp8266 ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/esp8266
RUN chmod 0440 /etc/sudoers.d/esp8266

USER esp8266
ENV HOME=/home/esp8266
# link host share folder, /docker
RUN ln -s /docker $HOME/docker

WORKDIR $HOME
ENTRYPOINT /bin/bash

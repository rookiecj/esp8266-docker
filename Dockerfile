FROM ubuntu:16.04
MAINTAINER rookiecj <rookiecj@gmail.com>

# Configure Apt
ARG DEBIAN_FRONTEND=noninteractive
RUN sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu\//mirror:\/\/mirrors.ubuntu.com\/mirrors.txt/' /etc/apt/sources.list


# Why should we need the init process?
# http://phusion.github.io/baseimage-docker/ 
# tini 0.14.0
ENV TINI_VERSION v0.14.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
 && gpg --verify /tini.asc
RUN chmod +x /tini
# Command line arguments to docker run <image> will be appended after all elements in an exec form ENTRYPOINT, 
# and will override all elements specified using CMD. This allows arguments to be passed to the entry point, i.e., docker run <image> -d will pass the -d argument to the entry point. 
# You can override the ENTRYPOINT instruction using the docker run --entrypoint flag.
# ENTRYPOINT ["executable", "param1", "param2"] (exec form, preferred)
ENTRYPOINT ["/tini", "--"]


# esp open sdk
RUN apt-get update 
RUN apt-get install -yq \
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

# general utilities
RUN apt-get install -yq usbutils

# add user esp8266 
RUN useradd -s /bin/bash -m -G plugdev,dialout esp8266 
RUN echo "esp8266 ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/esp8266
RUN chmod 0440 /etc/sudoers.d/esp8266

USER esp8266
ENV HOME=/home/esp8266
# link host share folder, /docker
RUN ln -s /docker $HOME/docker

WORKDIR $HOME
CMD ["/bin/bash"]

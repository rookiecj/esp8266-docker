#ubuntu 18.04
#FROM phusion/baseimage:0.11

FROM ubuntu:18.04
MAINTAINER rookiecj <rookiecj@gmail.com>

# Configure Apt
ARG DEBIAN_FRONTEND=noninteractive
RUN sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu\//mirror:\/\/mirrors.ubuntu.com\/mirrors.txt/' /etc/apt/sources.list


# esp open sdk
RUN apt-get update 

# essentials
RUN apt-get install -yq \
    make unrar-free autoconf automake libtool gcc g++ gperf \
    flex bison texinfo gawk ncurses-dev libexpat-dev \
    python-dev python python-pip python-setuptools \
    sed git unzip bash help2man wget bzip2

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
    vim  \
    usbutils

# esp32
RUN apt-get install -yq gcc git wget make libncurses-dev flex bison gperf python python-pip python-setuptools python-serial python-cryptography python-future python-pyparsing

# nodemcu
RUN apt-get install -yq srecord bc xz-utils 

RUN echo esp8266 > /etc/hostname

# user id should be the same as the one on your host machine
# it usuallyis 1000, the first user 
# add user esp8266 
RUN useradd -s /bin/bash -m -G plugdev,dialout esp8266 
RUN echo "esp8266 ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/esp8266
RUN chmod 0440 /etc/sudoers.d/esp8266


# Give children processes 5 minutes to timeout
ENV KILL_PROCESS_TIMEOUT=300
# Give all other processes (such as those which have been forked) 5 minutes to timeout
ENV KILL_ALL_PROCESSES_TIMEOUT=300

# baseimage limitations
#RUN chmod 755 /etc/container_environment -R
#RUN chmod 644 /etc/container_environment.sh /etc/container_environment.json


USER esp8266
ENV HOME=/home/esp8266
# link host share folder, /docker
RUN ln -s /docker $HOME/docker && \
    ln -s /docker/envsetup $HOME/envsetup && \
    ln -s /docker/bin $HOME/bin && \
    ln -s /docker/esp32 $HOME/esp32


WORKDIR $HOME

# esp32
#RUN curl https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz -o $HOME/esp32/xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz 
#RUN cd $HOME/esp32/ && tar -xvzf xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz


# Command line arguments to docker run <image> will be appended after all elements in an exec form ENTRYPOINT, 
# and will override all elements specified using CMD. This allows arguments to be passed to the entry point, i.e., docker run <image> -d will pass the -d argument to the entry point. 
# You can override the ENTRYPOINT instruction using the docker run --entrypoint flag.
# ENTRYPOINT ["executable", "param1", "param2"] (exec form, preferred)
#ENTRYPOINT ["/tini", "--"]
#ENTRYPOINT ["/sbin/my_init", "--"]

CMD ["/bin/bash"]


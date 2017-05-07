FROM ubuntu:14.04
MAINTAINER Benjamin Henrion <zoobab@gmail.com>
LABEL Description="This image builds a JTAG Versaloon firmware for the STM32 Bluepill board." 

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y -q
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q --force-yes make gcc-arm-none-eabi binutils

ENV user versaloon
RUN useradd -d /home/$user -m -s /bin/bash $user
RUN echo "$user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$user
RUN chmod 0440 /etc/sudoers.d/$user

USER $user
WORKDIR /home/versaloon
RUN mkdir -pv code
COPY . ./code/
RUN cd code/dongle/firmware/Projects/Versaloon/GCC && make

FROM ubuntu:18.04

MAINTAINER simojenki

ENV DEBIAN_FRONTEND=noninteractive \
    TERM=xterm \
    VNC_DISPLAY=1 \
    NO_VNC_PORT=6901 \
    VNC_DEPTH=24 \
    VNC_GEOMETRY=1920x1080 \
    VNC_PASSWORD=password

EXPOSE $VNC_PORT $NO_VNC_PORT

RUN apt-get update && \
    apt-get -y install \
        sudo \
        locales \
        tigervnc-standalone-server \
        tigervnc-xorg-extension \
        tigervnc-viewer \
        novnc \
        websockify \
        python-numpy \
        xfonts-base \
        xfonts-100dpi \
        xfonts-75dpi \
        xfce4 \
        xfce4-goodies \
        xfce4-terminal \
        xterm && \
    apt-get purge -y pm-utils xscreensaver* && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    locale-gen 'en_US.UTF-8'

ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US:en' \
    LC_ALL='en_US.UTF-8'

ADD src /

ENTRYPOINT ["/init"]
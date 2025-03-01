FROM debian:bookworm

LABEL maintainer="simojenki"

ENV DEBIAN_FRONTEND=noninteractive \
    TERM=xterm \
    VNC_DISPLAY=1 \
    VNC_DEPTH=24 \
    VNC_GEOMETRY=1920x1080 \
    VNC_PASSWORD=password

RUN apt-get update && \
    apt-get install -y \
        inetutils-ping \
        iproute2 \
        locales \
        lxde-core  \
        sudo \
        tigervnc-standalone-server \
        tigervnc-xorg-extension \
        tigervnc-viewer \
        xfonts-base \
        xfonts-100dpi \
        xfonts-75dpi \
        xterm \
        vim && \
    apt-get purge -y \
        light-locker \
        pm-utils \
        xscreensaver* && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* && \
    sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen

ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US:en' \
    LC_ALL='en_US.UTF-8'

ADD src /

ENTRYPOINT ["/init"]

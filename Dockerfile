# 文件名: Dockerfile.base
FROM debian:buster-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /etc/secprint \
        /data/downloads \
        /data/uploads \
        /data/licenses \
        /tmp/drivers

RUN echo "deb http://archive.debian.org/debian/ buster main contrib non-free" > /etc/apt/sources.list \
    && echo "deb-src http://archive.debian.org/debian/ buster main contrib non-free" >> /etc/apt/sources.list \
    && apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update \
    && apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false dist-upgrade -y \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update \
    && apt-get install -y --no-install-recommends \
        cups \
        libpoppler-glib8 \
        libqt5network5 \
        printer-driver-all \
        hpijs-ppds \
        openprinting-ppds \
        hp-ppd \
        gettext-base \
        hplip \
        tcpdump \
        curl \
        ca-certificates \
        procps \
    && rm -rf /var/lib/apt/lists/*

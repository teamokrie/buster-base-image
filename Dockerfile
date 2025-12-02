# 文件名: Dockerfile.base
FROM debian:buster-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN set -eux; \
    printf '%s\n' \
    'deb https://mirrors.aliyun.com/debian/ bullseye main non-free contrib' \
    'deb-src https://mirrors.aliyun.com/debian/ bullseye main non-free contrib' \
    'deb https://mirrors.aliyun.com/debian-security/ bullseye-security main' \
    'deb-src https://mirrors.aliyun.com/debian-security/ bullseye-security main' \
    'deb https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib' \
    'deb-src https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib' \
    '#deb https://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib' \
    '#deb-src https://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib' \
    > /etc/apt/sources.list; \
    export DEBIAN_FRONTEND=noninteractive; \
    rm -rf /var/lib/apt/lists/*

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
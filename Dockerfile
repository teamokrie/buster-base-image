# 文件名: Dockerfile.base
FROM debian:buster-slim

ENV DEBIAN_FRONTEND=noninteractive

# 替换 sources.list 到 archive.debian.org
RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|http://security.debian.org/debian-security|http://archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    # 对于已经没有 Release 文件的仓库，需要允许使用过期的
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99ignore-release-date

RUN apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update \
    && apt-get install -y --install-recommends \
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

COPY ./hplip-3.18.12-plugin.run /tmp/hplip-3.18.12-plugin.run

RUN mkdir -p /tmp/hplip-plugin-install && chmod +x /tmp/hplip-3.18.12-plugin.run && \
    cd /tmp && ./hplip-3.18.12-plugin.run --noexec --target /tmp/hplip-plugin-install && \
    cd /tmp/hplip-plugin-install && yes | ./hplip-plugin-install && \
    rm -rf /tmp/hplip-3.18.12-plugin.run /tmp/hplip-plugin-install

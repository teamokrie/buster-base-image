FROM debian:buster-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /etc/secprint \
        /data/downloads \
        /data/uploads \
        /data/licenses \
        /tmp/drivers

# --- 核心系统修复与依赖安装开始 ---
# 1. 替换为 archive 源
# 2. 忽略过期检查
# 3. 执行 dist-upgrade (修复 Buster EOL 后的依赖割裂问题)
# 4. 安装通用系统库 (CUPS, HPLIP 等)
RUN echo "deb http://archive.debian.org/debian/ buster main contrib non-free" > /etc/apt/sources.list \
    && echo "deb-src http://archive.debian.org/debian/ buster main contrib non-free" >> /etc/apt/sources.list \
    && apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update \
    && apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false dist-upgrade -y \
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

FROM alpine:3.14
MAINTAINER William Wang <william@10ln.com>

RUN apk add --update bash ca-certificates openssl curl tzdata pngquant \
    autoconf automake build-base libtool nasm wget \
 && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
 && echo "Asia/Shanghai" > /etc/timezone

RUN mkdir -p 755 /usr/local/build && cd /usr/local/build && \
wget https://github.com/mozilla/mozjpeg/archive/v3.3.1.tar.gz && \
wget https://github.com/danielgtaylor/jpeg-archive/archive/v2.2.0.tar.gz && \
tar -xzf v3.3.1.tar.gz && tar -xzf v2.0.tar.gz && cd mozjpeg-3.3.1 && \
autoreconf -fiv && ./configure --with-jpeg8 && make && make install && \
cd /usr/local/build/jpeg-archive-2.2.0 && make && make install && \
rm -rf /usr/local/build

ENV SHELL /bin/bash

RUN mkdir -p /usr/local/work

WORKDIR /usr/local/work

ENTRYPOINT ["/usr/local/work/run.sh"]

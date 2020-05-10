FROM alpine

MAINTAINER cyf <cuiyufeng1234@gmail.com>

ENV JAVA_VERSION=8u221 \
    JAVA_HOME=/usr/lib/jvm/jdk1.8.0_221 \
    PATH=$PATH:/usr/lib/jvm/jdk1.8.0_221/jre/bin:/usr/lib/jvm/jdk1.8.0_221/bin \
    MIRROR=mirrors.aliyun.com \
    NPM_MIRROR=registry.npm.taobao.org \
    GLIBC_VERSION=2.23-r3 \
    GLIBC_MD5=70f2869821c0ea85248c85fee7943284

RUN sed -i "s@dl-cdn.alpinelinux.org@$MIRROR@g" /etc/apk/repositories && \  
    apk update && \
    apk add curl && \
    glibc=glibc-${GLIBC_VERSION}.apk && \
    url=https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/$glibc && \
    curl -Lo $glibc $url && \
    echo "$GLIBC_MD5  $glibc" | md5sum -c && \
    apk add --allow-untrusted $glibc && \
    rm -f $glibc && \
    mkdir -p $(dirname $JAVA_HOME) && \
    { \
        echo '#!/bin/sh'; \
        echo 'set -e'; \
        echo; \
        echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
    } > /usr/local/bin/docker-java-home \
    && chmod +x /usr/local/bin/docker-java-home

ADD jdk-8u221-linux-x64.tar.gz /usr/lib/jvm/

RUN set -x && \  
    [ "$JAVA_HOME" = "$(docker-java-home)" ]

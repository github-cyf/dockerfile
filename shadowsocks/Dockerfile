FROM ubuntu:14.04

ENV TZ=Asia/Shanghai

RUN apt-get update && apt-get install -y \
    python-software-properties \
    software-properties-common \
 && add-apt-repository ppa:chris-lea/libsodium \
 && echo "deb http://ppa.launchpad.net/chris-lea/libsodium/ubuntu trusty main" >> /etc/apt/sources.list \
 && echo "deb-src http://ppa.launchpad.net/chris-lea/libsodium/ubuntu trusty main" >> /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y libsodium-dev python-pip tzdata git \
 && pip install https://github.com/shadowsocks/shadowsocks/archive/master.zip -U \
 && rm -rf /etc/locatime && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
 && cd /tmp;git clone https://github.com/shadowsocks/simple-obfs.git \
 && cd simple-obfs \
 && git submodule update --init --recursive \
 && ./autogen.sh \
 && ./configure && make \
 && make install 

COPY config.json /etc/

CMD ["/usr/local/bin/sslocal","-c","/etc/config.json","start"]


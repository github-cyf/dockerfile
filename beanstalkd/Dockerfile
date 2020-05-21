FROM alpine:3.10

LABEL maintainer="cyf"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
 && apk update \
 && apk add --no-cache beanstalkd tzdata \
 && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
 && echo "Asia/Shanghai" > /etc/timezone \
 && rm -rf /var/cache/apk/* /tmp/* /var/tmp/* $HOME/.cache 
 

EXPOSE 11300

CMD ["/usr/bin/beanstalkd"]

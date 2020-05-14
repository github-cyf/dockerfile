FROM alpine:3.10

LABEL maintainer="cyf"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
 && apk update \
 && apk add --no-cache beanstalkd 

EXPOSE 11300

CMD ["/usr/bin/beanstalkd"]

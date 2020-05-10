FROM node:8.12.0-alpine

LABEL QianJia.cuiyufeng <1627999813@qq.com>
#update time
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk add --no-cache tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/cache/apk/* /tmp/* /var/tmp/* $HOME/.cache \
    && echo "registry=https://registry.npm.taobao.org" > /root/.npmrc \
    && echo "sass_binary_site=https://npm.taobao.org/mirrors/node-sass/" >> /root/.npmrc \
    && echo "phantomjs_cdnurl=https://npm.taobao.org/mirrors/phantomjs/" >> /root/.npmrc \
    && echo "electron_mirror=http://npm.taobao.org/mirrors/electron/" >> /root/.npmrc \
    && echo "chromedriver_cdnurl=https://npm.taobao.org/mirrors/chromedriver" >> /root/.npmrc \
    && source /root/.npmrc


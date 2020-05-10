FROM nginx:1.16
LABEL cyf <1627999813@qq.com>

COPY nginx.conf /etc/nginx/nginx.conf

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' > /etc/timezone


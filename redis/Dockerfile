FROM redis:5.0
LABEL cyf <1627999813@qq.com>
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo 'Asia/Shanghai' > /etc/timezone \
    && mkdir -p /etc/redis
COPY redis.conf /etc/redis/redis.conf
CMD ["bash","-c","redis-server","/etc/redis/redis.conf"]

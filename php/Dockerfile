FROM debian:buster-slim

LABEL maintainer="cyf cuiyufeng1234@gmail.com"

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive
ENV NGINX_VERSION 1.17.9-1~buster
ENV COMPOSER_VERSION 1.9.3

COPY soft /tmp/soft

# Install Basic Requirements
RUN buildDeps='curl gcc make autoconf libc-dev zlib1g-dev pkg-config rpm' \
    && set -x \
    && sed -i "s/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list \
    && sed -i "s/security.debian.org/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list \
    && apt-get update \
    && apt-get install --no-install-recommends $buildDeps --no-install-suggests -q -y gnupg2 dirmngr wget apt-transport-https lsb-release ca-certificates \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && \
    NGINX_GPGKEY=573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62; \
	  found=''; \
	  for server in \
		  ha.pool.sks-keyservers.net \
		  hkp://keyserver.ubuntu.com:80 \
		  hkp://p80.pool.sks-keyservers.net:80 \
		  pgp.mit.edu \
	  ; do \
		  echo "Fetching GPG key $NGINX_GPGKEY from $server"; \
		  apt-key adv --batch --keyserver "$server" --keyserver-options timeout=10 --recv-keys "$NGINX_GPGKEY" && found=yes && break; \
	  done; \
    test -z "$found" && echo >&2 "error: failed to fetch GPG key $NGINX_GPGKEY" && exit 1; \
    echo "deb http://nginx.org/packages/mainline/debian/ buster nginx" >> /etc/apt/sources.list \
    && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -q -y \
            apt-utils \
            vim \
            cron \
            zip \
            unzip \
            python-pip \
            python-setuptools \
            git \
            librabbitmq-dev \
            nginx=${NGINX_VERSION} \
            php5.6-fpm \
            php5.6-cli \
            php5.6-bcmath \
            php5.6-dev \
            php5.6-common \
            php5.6-json \
            php5.6-opcache \
            php5.6-mbstring \
            php5.6-curl \
            php5.6-gd \
            php5.6-mysql \
            php5.6-sqlite3 \
            php5.6-mcrypt \
            php5.6-zip \
            php5.6-xml \
            php5.6-soap \
            php-pear \
    && tar -zxvf /tmp/soft/eall_encoder.tar.gz \
    && cd eall_encoder \
    && phpize \
    && ./configure --with-php-config=/usr/bin/php-config \
    && make && make install \
    && pecl -d php_suffix=5.6 install -o -f redis-2.2.7 amqp-1.6.1 mongodb-1.7.4 yac-0.9.2 yaf-2.3.5 \
    && mkdir -p /run/php \
    && echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d \
    && echo "extension=eall_encoder.so" > /etc/php/5.6/mods-available/eall_encoder.ini \
    && echo "extension=redis.so" > /etc/php/5.6/mods-available/redis.ini \
    && echo "extension=amqp.so" > /etc/php/5.6/mods-available/amqp.ini \
    && echo "extension=mongodb.so" > /etc/php/5.6/mods-available/mongodb.ini \
    && echo "extension=yac.so" > /etc/php/5.6/mods-available/yac.ini \
    && echo "extension=yaf.so" > /etc/php/5.6/mods-available/yaf.ini \
    && echo "yaf.environ=local" >> /etc/php/5.6/mods-available/yaf.ini \
    && ln -sf /etc/php/5.6/mods-available/eall_encoder.ini /etc/php/5.6/fpm/conf.d/20-eall_encoder.ini \
    && ln -sf /etc/php/5.6/mods-available/eall_encoder.ini /etc/php/5.6/cli/conf.d/20-eall_encoder.ini \
    && ln -sf /etc/php/5.6/mods-available/redis.ini /etc/php/5.6/fpm/conf.d/20-redis.ini \
    && ln -sf /etc/php/5.6/mods-available/redis.ini /etc/php/5.6/cli/conf.d/20-redis.ini \
    && ln -sf /etc/php/5.6/mods-available/amqp.ini /etc/php/5.6/fpm/conf.d/20-amqp.ini \
    && ln -sf /etc/php/5.6/mods-available/amqp.ini /etc/php/5.6/cli/conf.d/20-amqp.ini \
    && ln -sf /etc/php/5.6/mods-available/mongodb.ini /etc/php/5.6/fpm/conf.d/20-mongodb.ini \
    && ln -sf /etc/php/5.6/mods-available/mongodb.ini /etc/php/5.6/cli/conf.d/20-mongodb.ini \
    && ln -sf /etc/php/5.6/mods-available/yac.ini /etc/php/5.6/fpm/conf.d/20-yac.ini \
    && ln -sf /etc/php/5.6/mods-available/yac.ini /etc/php/5.6/cli/conf.d/20-yac.ini \ 
    && ln -sf /etc/php/5.6/mods-available/yaf.ini /etc/php/5.6/fpm/conf.d/20-yaf.ini \
    && ln -sf /etc/php/5.6/mods-available/yaf.ini /etc/php/5.6/cli/conf.d/20-yaf.ini \
    && pip install wheel \
    && pip install supervisor supervisor-stdout \
    && curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
    && curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
    && php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }" \
    && php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION} && rm -rf /tmp/composer-setup.php \
    && rm -rf /tmp/pear \
    #&& apt-get purge -y --auto-remove $buildDeps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/soft \
    && rm -rf /eall_encoder

ADD ./php.ini /etc/php/5.6/fpm/php.ini
ADD ./php-fpm.conf /etc/php/5.6/fpm/php-fpm.conf
ADD ./www.conf /etc/php/5.6/fpm/pool.d/www.conf
ADD ./supervisord.conf /etc/supervisord.conf
ADD ./default.conf /etc/nginx/conf.d/default.conf
ADD ./nginx.conf /etc/nginx/nginx.conf
ADD ./fastcgi.conf /etc/nginx/fastcgi.conf
ADD ./fastcgi_params /etc/nginx/fastcgi_params
ADD ./cronphp /etc/cron.d/cronphp
ADD ./start.sh /start.sh

EXPOSE 80

CMD ["/start.sh"]

#!/bin/bash

procs=$(cat /proc/cpuinfo |grep processor | wc -l)
sed -i -e "s/worker_processes  1/worker_processes $procs/" /etc/nginx/nginx.conf
sed -i -e "s/yaf.environ=local/yaf.environ=$APP_ENV/g" /etc/php/5.6/mods-available/yaf.ini
crontab /etc/cron.d/cronphp

/usr/local/bin/supervisord -n -c /etc/supervisord.conf

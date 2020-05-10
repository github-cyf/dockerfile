FROM centos:7

RUN yum update -y \
 && yum install -y wget epel-release \
 && wget https://github.com/Qihoo360/Atlas/releases/download/2.2.1/Atlas-2.2.1.el6.x86_64.rpm \
 && rpm -ivh Atlas-2.2.1.el6.x86_64.rpm \
 && rm -rf Atlas-2.2.1.el6.x86_64.rpm \
 && mv /usr/local/mysql-proxy/conf/test.conf /usr/local/mysql-proxy/conf/atlas.conf \
 && yum clean all

EXPOSE 1234 2345

CMD ["/usr/local/mysql-proxy/bin/mysql-proxyd","atlas","start"]

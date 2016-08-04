FROM alpine:3.4
MAINTAINER Leonel Baer <leonel@lysender.com>

RUN apk add --no-cache mariadb supervisor

ADD ./start.sh /start.sh
ADD ./config_mysql.sh /config_mysql.sh
ADD ./config_root_account.sh /config_root_account.sh
ADD ./config_credentials.sh /config_credentials.sh
ADD ./config_power_credentials.sh /config_power_credentials.sh
RUN chmod 755 /*.sh

RUN mkdir -p /etc/supervisor/conf.d
ADD ./supervisor-mysql.conf /etc/supervisor/conf.d/mysql.conf

# Configure MySQL
# Allow external connections
RUN sed -i 's/bind-address/#bind-address/g' /etc/mysql/mysql.conf.d/mysqld.cnf
# Configure default DB
RUN /config_mysql.sh

VOLUME ["/var/lib/mysql", "/var/log/mysql", "/var/log/supervisor"]

EXPOSE 3306

CMD ["supervisor", "-n"]


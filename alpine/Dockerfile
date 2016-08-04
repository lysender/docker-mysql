FROM alpine:3.4
MAINTAINER Leonel Baer <leonel@lysender.com>

RUN apk add --no-cache bash mariadb mariadb-client supervisor

ADD ./config_mysql.sh /config_mysql.sh
ADD ./config_root_account.sh /config_root_account.sh
ADD ./config_credentials.sh /config_credentials.sh
ADD ./config_power_credentials.sh /config_power_credentials.sh
RUN chmod 755 /*.sh

RUN mkdir -p /etc/supervisor.d
ADD ./supervisor-mysql.ini /etc/supervisor.d/mysql.ini

# Configure MySQL
RUN sed -ri 's/^user\s/#&/' /etc/mysql/my.cnf \
    && rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql /var/run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/my.cnf

# Configure default DB
RUN /config_mysql.sh

VOLUME ["/var/lib/mysql", "/var/log/mysql"]

EXPOSE 3306

CMD ["supervisord", "-n"]


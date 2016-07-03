#!/bin/bash

__mysql_config() {
    rm -rf /var/lib/mysql
    mysqld --initialize
    #mysql_install_db
    chown -R mysql:mysql /var/lib/mysql
}

__mysql_config


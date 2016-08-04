#!/bin/bash

ROOT_PASSWORD=${ROOT_PASSWORD:-foobar}
DB_NAME=${DB_NAME:-genericdb}
DB_USER=${DB_USER:-genericdb}
DB_PASS=${DB_PASS:-genericdb}

__setup_credentials() {
    echo "Setting up new DB and user credentials."
    /usr/bin/mysqld_safe & sleep 10
    mysql --user=root --password=$ROOT_PASSWORD -e "CREATE DATABASE $DB_NAME"
    mysql --user=root --password=$ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS'; FLUSH PRIVILEGES;"
    mysql --user=root --password=$ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS'; FLUSH PRIVILEGES;"
    mysql --user=root --password=$ROOT_PASSWORD -e "select user, host FROM mysql.user;"
    killall mysqld
    sleep 10
}

__setup_credentials


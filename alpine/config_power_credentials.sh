#!/bin/bash

ROOT_PASSWORD=${ROOT_PASSWORD:-foobar}
DB_USER=${DB_USER:-genericdb}
DB_PASS=${DB_PASS:-genericdb}

__setup_credentials() {
    echo "Setting up new power user credentials."
    /usr/bin/mysqld_safe & sleep 10
    mysql --user=root --password=$ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS' WITH GRANT OPTION; FLUSH PRIVILEGES;"
    mysql --user=root --password=$ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS' WITH GRANT OPTION; FLUSH PRIVILEGES;"
    mysql --user=root --password=$ROOT_PASSWORD -e "select user, host FROM mysql.user;"
    killall mysqld
    sleep 10
}

__setup_credentials


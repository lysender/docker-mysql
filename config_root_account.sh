#!/bin/bash

ROOT_PASSWORD=${ROOT_PASSWORD:-foobar}

__setup_root() {
    echo "Setting up root password."
    /usr/bin/mysqld_safe & sleep 10
    mysqladmin -u root password $ROOT_PASSWORD
    killall mysqld
    sleep 10
}

__setup_root


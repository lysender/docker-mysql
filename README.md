# Generic MySQL

Uses Ubuntu Xenial as base image.

## Build

~~~
sudo docker build --rm -t lysender/mysql .
~~~

## Prepare data

We need a volume container to hold our MySQL data.

### Create volume container

~~~
sudo docker create --name mysql-data \
    -v /var/lib/mysql \
    -v /var/log/mysql \
    lysender/mysql /bin/true
~~~

### Initialize root password

~~~
sudo docker run --rm \
    --volumes-from=mysql-data \
    -e "ROOT_PASSWORD=the_root_password" \
    lysender/mysql /config_root_account.sh
~~~

### Create power user

Note: Only use this if you need root-like privilege on all databases (ex: on dev environment)

~~~
sudo docker run --rm \
    --volumes-from=mysql-data \
    -e "ROOT_PASSWORD=the_root_password" \
    -e "DB_USER=genericdb" \
    -e "DB_PASS=genericdb" \
    lysender/mysql /config_power_credentials.sh
~~~

### Create a specific database with credentials (access limited to the specified database)

~~~

sudo docker run --rm \
    --volumes-from=mysql-data \
    -e "ROOT_PASSWORD=the_root_password" \
    -e "DB_NAME=blog" \
    -e "DB_USER=bloguser" \
    -e "DB_PASS=blogpassword" \
    lysender/mysql /config_credentials.sh
~~~

## Running the container

Note: The example below forwards localhost's port 3307 to the mysql container. You may use a different port or use the default port `3306`.

~~~
sudo docker run --name mysql \
    --volumes-from=mysql-data \
    -d \
    -p 3307:3306 \
    lysender/mysql
~~~

## Connect from local machine

~~~
mysql --protocol tcp --port 3307 --user blog -p -D blog
~~~

## Restore a DB dump into the specified database

~~~
mysql --protocol tcp --port 3307 --user blog -p -D blog < /path/to/blog-backup.sql
~~~

## Link to another container

Note: This is just an example and may not work without prior preparation like creating volume containers or a web app image.

~~~
sudo docker run --name "blog-webapp" \
    -d \
    -p 8080:80 \
    --volumes-from "blog-data" \
    --link mysql:db \
    my-blog-webapp-image
~~~

The `blog-webapp` container will have access to the MySQL server via `db` hostname (note the `db` alias). Set the DB hostname in the blog webapp to `db`.

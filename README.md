# Generic MySQL

Uses Ubuntu Xenial as base image.

## Sample usage

    docker build --rm -t mysql-server .

Running the container.

    docker run --name mysql -d -p 3307:3306 mysql-server

Sample connection from local machine.

    mysql --protocol tcp --port 3307 -u usernamehere -p

## Advanced usage

See Docker documentation for best practices when managing volumes especially for databases.


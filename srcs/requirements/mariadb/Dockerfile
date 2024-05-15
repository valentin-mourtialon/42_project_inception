FROM alpine:3.18

RUN apk update && apk upgrade

RUN apk add --no-cache mariadb mariadb-client

RUN mkdir -p /var/lib/mysql /run/mysqld && chown -R mysql:mysql /var/lib/mysql /run/mysqld

# Creating the system database: mysql_install_db doesn't
# create a database for the user (like a WordPress database),
# but initializes the system database required for MariaDB to function.
# This includes the creation of system tables that manage,
# for example, users and permissions.
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db --rpm

COPY ./conf/my.cnf /etc/my.cnf
COPY . src/

WORKDIR src/

ENTRYPOINT ["sh", "./tools/setup.sh"]


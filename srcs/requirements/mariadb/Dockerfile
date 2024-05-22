FROM alpine:3.18

# Creating the system database: mysql_install_db doesn't
# create a database for the user (like a WordPress database),
# but initializes the system database required for MariaDB to function.
# This includes the creation of system tables that manage,
# for example, users and permissions.
# -> mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db --rpm
RUN apk update && apk upgrade && \
    apk add --no-cache mariadb mariadb-client gettext && \
    mkdir -p /var/lib/mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld && \
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db --rpm

COPY ./conf/my.cnf /etc/my.cnf
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY ./tools/setup.sh /usr/local/bin/setup.sh
COPY ./tools/dbconfig.sql /usr/local/bin/dbconfig.sql

ENTRYPOINT ["sh", "/usr/local/bin/setup.sh"]

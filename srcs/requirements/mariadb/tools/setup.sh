#!/bin/sh

if [ -d "/var/lib/mysql/mysql" ]; then
    	exit 0
else
	# Set mysql group and user as the owner
	# of the files and folders at /var/lib/mysql
	chown -R mysql:mysql /var/lib/mysql

	# Creating the system database: mysql_install_db doesn't
	# create a database for the user (like a WordPress database),
	# but initializes the system database required for MariaDB to function.
	# This includes the creation of system tables that manage,
	# for example, users and permissions.
	mysql_install_db \
		--user=mysql \
		--datadir=/var/lib/mysql \
		--skip-test-db \
		--rpm


	# The following commands must be run on the mysql db.
	# The mysql db is the system db.
	echo "USE mysql;" > sys_db
	echo "FLUSH PRIVILEGES;" >> sys_db
	echo "DELETE FROM mysql.user WHERE User='';" >> sys_db
	# The following cmd prevents attempts to access the root account
	# from a remote location.
	echo "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');" >> sys_db
	# Change the database administrator password
	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ADMIN_PWD}';" >> sys_db
	# Create the wordpress database and set the admin user.
	echo "CREATE DATABASE ${WP_DB_NAME};" >> sys_db
	echo "CREATE USER '${WP_DB_ADMIN_USERNAME}'@'%' IDENTIFIED BY '${WP_DB_ADMIN_PWD}';" >> sys_db
	echo "GRANT ALL PRIVILEGES ON ${WP_DB_NAME}.* TO '${WP_DB_ADMIN_USERNAME}'@'%' IDENTIFIED BY '${WP_DB_ADMIN_PWD}';" >> sys_db
	echo "FLUSH PRIVILEGES;" >> sys_db

    	# The --bootstrap mode allows mysqld to start executing SQL
	# scripts supplied via standard input without completely
	# initializing all its components, especially
	# those related to network and user access controls.
	/usr/bin/mysqld --user=mysql --bootstrap < sys_db
	rm -f sys_db
fi

# Start MariaDb
rc-service mariadb start

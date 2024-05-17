#!/bin/sh

# The following commands must be run on the mysql db.
# The mysql db is the system db.
echo "USE mysql;" > dbconfig.sql
echo "FLUSH PRIVILEGES;" >> dbconfig.sql
echo "DELETE FROM mysql.user WHERE User='';" >> dbconfig.sql

# The following cmd prevents attempts to access the root account
# from a remote location.
echo "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');" >> dbconfig.sql

# Change the database administrator password
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ADMIN_PWD}';" >> dbconfig.sql

# Create the wordpress database and set the admin user.
echo "CREATE DATABASE ${WP_DB_NAME};" >> dbconfig.sql
echo "CREATE USER '${WP_DB_ADMIN_USERNAME}'@'%' IDENTIFIED BY '${WP_DB_ADMIN_PWD}';" >> dbconfig.sql
echo "GRANT ALL PRIVILEGES ON ${WP_DB_NAME}.* TO '${WP_DB_ADMIN_USERNAME}'@'%' IDENTIFIED BY '${WP_DB_ADMIN_PWD}';" >> dbconfig.sql
echo "FLUSH PRIVILEGES;" >> dbconfig.sql

# The --bootstrap mode allows mysqld to start executing SQL
# scripts supplied via standard input without completely
# initializing all its components, especially
# those related to network and user access controls.
/usr/bin/mysqld --user=mysql --bootstrap < dbconfig.sql
rm -f dbconfig.sql

# Start MariaDb daemon
mariadbd --user=mysql

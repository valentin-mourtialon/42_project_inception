#!/bin/sh

# Replace env vars in the sql file
envsubst < /usr/local/bin/dbconfig.sql > /tmp/dbconfig.sql

# The --bootstrap mode allows mysqld to start executing SQL
# scripts supplied via standard input without completely
# initializing all its components, especially
# those related to network and user access controls.
/usr/bin/mysqld --user=mysql --bootstrap < /tmp/dbconfig.sql
rm -f /tmp/dbconfig.sql

# Start MariaDb daemon
mariadbd --user=mysql

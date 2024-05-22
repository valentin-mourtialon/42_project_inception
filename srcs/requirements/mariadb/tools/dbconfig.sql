-- The following commands must be run on the mysql db.
-- The mysql db is the system db.
USE mysql;

FLUSH PRIVILEGES;

DELETE FROM mysql.user WHERE User='';

-- The following cmd prevents attempts to access the root account
-- from a remote location.
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

-- Change the database administrator password
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ADMIN_PWD}';

CREATE DATABASE ${WP_DB_NAME};

-- Create the wordpress database and set the admin user.
CREATE USER '${WP_DB_ADMIN_USERNAME}'@'%' IDENTIFIED BY '${WP_DB_ADMIN_PWD}';

GRANT ALL PRIVILEGES ON ${WP_DB_NAME}.* TO '${WP_DB_ADMIN_USERNAME}'@'%';

FLUSH PRIVILEGES;

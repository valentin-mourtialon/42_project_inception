#!/bin/sh

wp-cli.phar cli update --yes --allow-root

wp-cli.phar core download --allow-root --path=/var/www/html/wordpress

wp-cli.phar config create --dbname=${WP_DB_NAME} --dbuser=${WP_USER} --dbpass=${WP_USER_PWD} --dbhost="mariadb":"3306" --path=/var/www/html/wordpress --allow-root

wp-cli.phar core install --url=vmourtia.42.fr/wordpress --title=wordpress --admin_user=${WP_DB_ADMIN_USERNAME} --admin_password=${WP_DB_ADMIN_PWD} --admin_email=${WP_DB_ADMIN_EMAIL} --path=/var/www/html/wordpress --allow-root

wp-cli.phar user create ${WP_DB_USER} ${WP_DB_USER_EMAIL} --user_pass=${WP_DB_USER_PWD} --role=editor --display_name=${WP_DB_USER} --path=/var/www/html/wordpress --allow-root


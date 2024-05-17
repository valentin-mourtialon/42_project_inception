#!/bin/sh

# At this point, the depends_on and the condition
# in our docker-compose should have ensured
# that the database is available.
mysql -h${WP_DB_HOST} -u${WP_DB_ADMIN_USERNAME} -p${WP_DB_ADMIN_PWD} ${WP_DB_NAME}

if [ -f /var/www/html/wordpress/wp-config.php ]
then
	echo "Wordpress is already configured"
else
	echo "Installing wordpress..."

	wp core download --path=/var/www/html/wordpress --allow-root

	wp config create --dbname=${WP_DB_NAME} \
		--dbuser=${WP_DB_ADMIN_USERNAME} \
		--dbpass=${WP_DB_ADMIN_PWD} \
		--dbhost=${WP_DB_HOST} \
		--path=/var/www/html/wordpress \
		--allow-root

	wp core install --url=vmourtia.42.fr/wordpress \
		--title=wordpress \
		--admin_user=${WP_DB_ADMIN_USERNAME} \
		--admin_password=${WP_DB_ADMIN_PWD} \
		--admin_email=${WP_DB_ADMIN_EMAIL} \
		--path=/var/www/html/wordpress \
		--allow-root

	wp user create ${WP_DB_USER} ${WP_DB_USER_EMAIL} \
		--user_pass=${WP_DB_USER_PWD} \
		--role=editor \
		--display_name=${WP_DB_USER} \
		--path=/var/www/html/wordpress \
		--allow-root
fi

php-fpm -F

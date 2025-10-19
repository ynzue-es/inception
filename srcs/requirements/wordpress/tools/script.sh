#!/bin/bash
service php8.2-fpm start

DB_PASS=$(cat /run/secrets/db_password)
DB_ROOT_PASS=$(cat /run/secrets/db_root_password)

DB_HOST=${WORDPRESS_DB_HOST}
DB_USER=${WORDPRESS_DB_USER}
DB_NAME=${WORDPRESS_DB_NAME}
SITE_URL=${WORDPRESS_URL}
SITE_TITLE=${WORDPRESS_TITLE}
ADMIN_USER=${WORDPRESS_ADMIN_USER}
ADMIN_EMAIL=${WORDPRESS_ADMIN_EMAIL}

wp core download --allow-root --path=/var/www/html
wp config create --allow-root \
--dbname=${DB_NAME} \
--dbuser=${DB_USER} \
--dbpass=${DB_PASS} \
--dbhost=${DB_HOST}

wp core install --allow-root \
--url=${SITE_URL} \
--title="${SITE_TITLE}" \
--admin_user=${ADMIN_USER} \
--admin_password=${DB_ROOT_PASS} \
--admin_email=${ADMIN_EMAIL}

exec php-fpm8.2 -F
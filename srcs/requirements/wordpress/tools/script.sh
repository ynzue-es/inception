#!/bin/bash
set -e

DB_PASS=$(cat /run/secrets/db_password)
DB_ROOT_PASS=$(cat /run/secrets/db_root_password)

if [ ! -f /var/www/html/wp-config.php ]; then
  wp config create --allow-root \
    --dbname="$WORDPRESS_DB_NAME" \
    --dbuser="$WORDPRESS_DB_USER" \
    --dbpass="$DB_PASS" \
    --dbhost="$WORDPRESS_DB_HOST"

  wp core install --allow-root \
    --url="$WORDPRESS_URL" \
    --title="$WORDPRESS_TITLE" \
    --admin_user="$WORDPRESS_ADMIN_USER" \
    --admin_password="$DB_ROOT_PASS" \
    --admin_email="$WORDPRESS_ADMIN_EMAIL"
fi

exec php-fpm8.2 -F
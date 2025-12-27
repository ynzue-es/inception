#!/bin/bash
set -e

DB_PASS=$(cat /run/secrets/db_password)
WP_ADMIN_PASS=$(cat /run/secrets/wp_admin_password)

if [ ! -f /var/www/html/wp-config.php ]; then
  until mariadb -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$DB_PASS" -e "SELECT 1;" >/dev/null 2>&1; do
    sleep 2
  done

  chown -R www-data:www-data /var/www/html

  wp config create --allow-root --path=/var/www/html \
    --dbname="$WORDPRESS_DB_NAME" \
    --dbuser="$WORDPRESS_DB_USER" \
    --dbpass="$DB_PASS" \
    --dbhost="$WORDPRESS_DB_HOST"

  wp core install --allow-root --path=/var/www/html \
    --url="$WORDPRESS_URL" \
    --title="$WORDPRESS_TITLE" \
    --admin_user="$WORDPRESS_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASS" \
    --admin_email="$WORDPRESS_ADMIN_EMAIL"
fi

exec php-fpm8.2 -F
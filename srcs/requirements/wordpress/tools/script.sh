#!/bin/bash
service php8.2-fpm start
sleep 5
wp core download --allow-root --path=/var/www/html
wp config create --allow-root \
  --dbname=wordpress \
  --dbuser=wp_user \
  --dbpass=doerg!eKUU073@iergzrIUG \
  --dbhost=mariadb:3306
wp core install --allow-root \
  --url=https://ynzue-es.42.fr \
  --title="Inception" \
  --admin_user=yannis \
  --admin_password=siudYIUTugu976!!erfz@zseOIY \
  --admin_email=ynzue-es@student.42lyon.fr
php-fpm8.2 -F
#!/bin/bash
set -e

DB_PASS=$(cat /run/secrets/db_password)
DB_ROOT_PASS=$(cat /run/secrets/db_root_password)

mysqld_safe &
sleep 5

if [ ! -f /var/lib/mysql/.initialized ]; then
    mariadb <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';
CREATE DATABASE IF NOT EXISTS wordpress CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'wp_user'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%';
FLUSH PRIVILEGES;
EOF
    touch /var/lib/mysql/.initialized
fi

mysqladmin -u root -p"${DB_ROOT_PASS}" shutdown
exec mysqld_safe
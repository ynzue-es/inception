#!/bin/bash
service mariadb start

DB_PASS=$(cat /run/secrets/db_password)

echo "CREATE DATABASE IF NOT EXISTS wordpress;" > /tmp/init.sql
echo "CREATE USER IF NOT EXISTS 'wp_user'@'%' IDENTIFIED BY '${DB_PASS}';" >> /tmp/init.sql
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%';" >> /tmp/init.sql
echo "FLUSH PRIVILEGES;" >> /tmp/init.sql

mariadb < /tmp/init.sql

kill $(cat /run/mysqld/mysqld.pid)
exec mysqld_safe
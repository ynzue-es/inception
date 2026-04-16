#!/bin/bash
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

DB_PASS=$(cat /run/secrets/db_password)
DB_ROOT_PASS=$(cat /run/secrets/db_root_password)

if [ ! -f /var/lib/mysql/.initialized ]; then
    mariadbd --user=mysql --skip-networking &
    
    until mariadb-admin ping --silent 2>/dev/null; do sleep 1; done
    mariadb <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASS}';
GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
    mariadb-admin -u root -p"${DB_ROOT_PASS}" shutdown
    wait
    touch /var/lib/mysql/.initialized
fi

exec mariadbd --user=mysql --console
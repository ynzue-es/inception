FROM debian:bookworm

RUN apt update \
 && apt install -y php8.2-fpm php-mysql mariadb-client curl wget unzip \
 && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
 && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp \
 && mkdir -p /var/www/html \
 && wget https://wordpress.org/latest.tar.gz -P /tmp \
 && tar -xzf /tmp/latest.tar.gz -C /var/www/html --strip-components=1 \
 && rm /tmp/latest.tar.gz \
 && sed -i 's|^listen = .*|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf

COPY tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT ["/usr/local/bin/script.sh"]
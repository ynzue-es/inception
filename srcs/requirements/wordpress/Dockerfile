FROM debian:bookworm
RUN apt update \
    && apt install -y wget tar \
    && apt install -y php-fpm php-mysql \
    && mkdir -p /var/www/html \
    && wget https://wordpress.org/latest.tar.gz -P /tmp \
    && tar -xzf /tmp/latest.tar.gz -C /var/www/html --strip-components=1 \
    && rm /tmp/latest.tar.gz \
    && chown -R www-data:www-data /var/www/html \
    && ln -s $(ls /usr/sbin/php-fpm*) /usr/local/bin/php-fpm \
    && sed -i 's|^listen = .*|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf
CMD ["php-fpm", "-F"]

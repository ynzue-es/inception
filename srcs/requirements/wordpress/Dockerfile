FROM debian:bookworm
RUN apt update \
    && apt install -y wget tar \
    && apt install -y php-fpm php-mysql \
    && mkdir -p /var/www/html \
    && wget https://wordpress.org/latest.tar.gz -P /tmp \
    && tar -xzf /tmp/latest.tar.gz -C /var/www/html --strip-components=1 \
    && rm /tmp/latest.tar.gz \
    && ln -s $(ls /usr/sbin/php-fpm*) /usr/local/bin/php-fpm
CMD ["php-fpm", "-F"]

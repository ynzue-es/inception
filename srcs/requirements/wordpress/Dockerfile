FROM debian:bookworm
RUN apt update \
    && apt install -y wget tar \
    && apt install -y php8.2-fpm php-mysql \
    && mkdir -p /var/www/html \
    && wget https://wordpress.org/latest.tar.gz -P /tmp \
    && tar -xzf /tmp/latest.tar.gz -C /var/www/html --strip-components=1 \
    && rm /tmp/latest.tar.gz \
    && chown -R www-data:www-data /var/www/html \
    && sed -i 's|^listen = .*|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf 
ENTRYPOINT [ "./tools/script.sh" ]

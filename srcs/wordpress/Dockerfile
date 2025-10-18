FROM debian:bookworm
RUN apt update \
    && apt install -y wget tar \
    && apt install php-fpm php-mysql php-xml php-mbstring \
    && wget https://wordpress.org/latest.tar.gz -P /tmp \
    && tar -xzf /tmp/latest.tar.gz -C /var/www/html --strip-components=1 \
    && rm /tmp/latest.tar.gz \
    && rm -rf /var/lib/apt/lists/* \
CMD ["php-fpm", "-F"]

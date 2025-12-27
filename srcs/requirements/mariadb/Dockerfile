FROM debian:bookworm

RUN apt update \
    && apt install -y mariadb-server

# Autoriser les connexions depuis le réseau Docker
RUN sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' \
    /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT ["/usr/local/bin/script.sh"]
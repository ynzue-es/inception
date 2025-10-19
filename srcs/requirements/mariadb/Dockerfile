FROM debian:bookworm
RUN apt update \
    && apt install -y mariadb-server \
    && sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
ENTRYPOINT [ "./tools/script.sh" ]

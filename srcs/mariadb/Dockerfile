FROM debian:bookworm
RUN apt update \
    && apt install mariadb-server mariadb-client -y \ 
    && rm -rf /var/lib/apt/lists/*
CMD ["mysqld_safe"]

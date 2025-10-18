FROM debian:bookworm
RUN apt update \
    && apt install -y nginx
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]
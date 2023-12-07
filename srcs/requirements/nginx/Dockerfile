FROM debian:bullseye

RUN apt update -y
RUN apt install nginx openssl -y
RUN mkdir -p /run/nginx

RUN mkdir -p /etc/nginx/certs && \
	mkdir -p /var/www/html && \
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/certs/server.key -out /etc/nginx/certs/server.crt -subj "/CN=mdarify.42.fr"

COPY  ./conf/nginx.conf /etc/nginx/conf.d/default.conf

COPY test.html /var/www/html/index.html

CMD ["nginx", "-g", "daemon off;"]
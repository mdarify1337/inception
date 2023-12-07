FROM debian:bullseye

RUN apt update -y  &&  apt upgrade -y 
RUN apt-get install -y php\
                    php-fpm\
                    php-mysql\
                    mariadb-client \ 
                    wget

RUN mkdir -p /var/www/html && \
    sed -i 's#listen = \/run\/php\/php7.4-fpm.sock#listen = 0.0.0.0:9000#' /etc/php/7.4/fpm/pool.d/www.conf

WORKDIR /var/www/html


COPY ./tools/setup.sh /tmp/setup.sh

RUN wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod 777 /usr/local/bin/wp && \
    wp core download --allow-root


RUN chmod 777 /tmp/setup.sh

WORKDIR /tmp

CMD ["./setup.sh"]

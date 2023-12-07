#!/bin/sh

cd /var/www/html

wp core download --allow-root --path=/var/www/html --version=5.8.1 --locale=en_US

wp config create --allow-root --path=/var/www/html \
      --dbname=${WP_NAME} \
      --dbuser=${WP_ADMIN_USER} \
       --dbpass=${WP_PASSWORD} \
       --dbhost=${WP_HOST}

sed -i "41 i define( 'WP_REDIS_HOST', 'redis' );\ndefine( 'WP_REDIS_PORT', '6379' );\n" wp-config.php

wp core install --allow-root --path=/var/www/html \
    --url=${WP_URL} \
    --title=${WP_TITLE}\
    --admin_user=${WP_ADMIN_USER}\
    --admin_password=${WP_ADMIN_PASSWORD}\
     --admin_email=${WP_ADMIN_EMAIL}

wp user create --allow-root --path=/var/www/html \
    "${WP_USER}" "${WP_EMAIL}" -\
    -user_pass="${WP_PASSWORD}" \
    --role=author

chown -R nobody:nobody *

wp plugin install redis-cache --allow-root  --activate

wp redis enable --allow-root

exec php-fpm7 -F -R 
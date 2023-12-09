FROM php:8.1-fpm-alpine

RUN mkdir -p /var/www/html
WORKDIR /var/www/html

RUN apk update && apk add --no-cache \
    curl \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    libxpm-dev \
    freetype-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-install pdo_mysql mysqli gd zip

#install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
#move wp-cli.phar to /usr/local/bin/wp
RUN mv wp-cli.phar /usr/local/bin/wp

#install wordpress


RUN curl -LO https://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz
RUN mv wordpress/* .
RUN rm -rf latest.tar.gz

#rename wp-config-sample.php to wp-config.php
RUN mv wp-config-sample.php wp-config.php


RUN chown -R www-data:www-data .

EXPOSE 80

# run nginx and php-fpm
CMD ["php-fpm"]

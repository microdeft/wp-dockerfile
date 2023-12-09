FROM php:8.1-fpm-alpine

RUN mkdir -p /var/www/html
WORKDIR /var/www/html

RUN curl -LO https://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz
RUN mv wordpress/* .
RUN rm -rf latest.tar.gz

#rename wp-config-sample.php to wp-config.php
RUN mv wp-config-sample.php wp-config.php

COPY wp-config.php .

RUN chown -R www-data:www-data .

EXPOSE 8080

CMD ["php-fpm", "-D"]

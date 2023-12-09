FROM wordpress:php8.2-fpm-alpine

WORKDIR /var/www/html

# Install dependencies

RUN apk update && apk add --no-cache \
    bash \
    curl \
    git \
    libpng-dev \
    libzip-dev \
    mysql-client \
    openssh-client \
    unzip \
    zip

# Install PHP extensions

RUN docker-php-ext-install \
    gd \
    mysqli \
    pdo_mysql \
    zip



# Copy custom configuration files, if needed


EXPOSE 9000

CMD ["php-fpm"]

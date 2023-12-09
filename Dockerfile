# Use the official WordPress image with PHP 8.2 FPM on Alpine
FROM wordpress:php8.2-fpm-alpine

# Install necessary dependencies and extensions
RUN apk --no-cache add \
    nginx \
    supervisor \
    && docker-php-ext-install mysqli pdo pdo_mysql

# Copy Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Copy PHP configuration file
COPY php.ini /usr/local/etc/php/php.ini

# Copy Supervisor configuration file
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports
EXPOSE 80

# Start Supervisor
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

FROM php:8.1.0-fpm-alpine3.14

# Install system dependencies
RUN apk update && apk add --no-cache \
    $PHPIZE_DEPS \
    zlib-dev \
    libzip-dev \
    curl

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/html

# Copy application files to the container
COPY src /var/www/html

# Expose the port if necessary
EXPOSE 9000

# Start the PHP-FPM server
CMD ["php-fpm"]

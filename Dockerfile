# Gebruik een PHP-image met FPM
FROM php:8.1-fpm

# Installeer systeemvereisten en PHP-extensies
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    curl \
    git \
    && docker-php-ext-install pdo pdo_mysql mbstring zip

# Installeer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Stel de werkdirectory in
WORKDIR /var/www/html

# Kopieer projectbestanden
COPY . .

# Installeer PHP-afhankelijkheden
RUN composer install --no-dev --optimize-autoloader --verbose

# Installeer Node.js en npm (voor Vue)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    npm install && npm run build

# Expose poort 8000
EXPOSE 8000

# Start Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
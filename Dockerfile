# Gebruik een PHP-image met Composer en Node.js
FROM php:8.1-fpm

# Installeer Node.js en npm
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Installeer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Stel de werkdirectory in
WORKDIR /var/www/html

# Kopieer projectbestanden
COPY . .

# Installeer PHP- en Node.js-afhankelijkheden
RUN composer install --no-dev --optimize-autoloader
RUN npm install && npm run build

# Expose poort 8000
EXPOSE 8000

# Start Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
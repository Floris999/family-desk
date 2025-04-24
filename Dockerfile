# --- STAGE 1: Build assets + install PHP deps ---
    FROM php:8.1-fpm AS build

    # Installeer systeemvereisten en PHP-extensies
    RUN apt-get update && apt-get install -y \
        git curl unzip zip \
        libpng-dev libjpeg-dev libfreetype6-dev libzip-dev libxml2-dev libonig-dev \
        && docker-php-ext-configure gd --with-freetype --with-jpeg \
        && docker-php-ext-install pdo pdo_mysql mbstring zip gd bcmath tokenizer xml
    
    # Installeer Composer
    RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
    
    # Maak werkdirectory
    WORKDIR /var/www/html
    
    # Kopieer alleen dependency-files eerst voor cache
    COPY composer.json composer.lock ./
    
    # Installeer PHP-dependencies
    RUN composer install --no-dev --optimize-autoloader --verbose
    
    # Kopieer alle andere bestanden
    COPY . .
    
    # Node.js installeren voor frontend build (Vue)
    RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
        apt-get install -y nodejs && \
        npm install && npm run build
    
    # --- STAGE 2: Production container ---
    FROM php:8.1-fpm
    
    # Installeer alleen de noodzakelijke libraries
    RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev libzip-dev libxml2-dev libonig-dev \
        && docker-php-ext-configure gd --with-freetype --with-jpeg \
        && docker-php-ext-install pdo pdo_mysql mbstring zip gd bcmath tokenizer xml
    
    # Werkdirectory
    WORKDIR /var/www/html
    
    # Kopieer composer-geïnstalleerde app en gebuilde assets van de build-stage
    COPY --from=build /var/www/html /var/www/html
    
    # Zorg voor juiste permissies
    RUN chown -R www-data:www-data /var/www/html
    USER www-data
    
    # Expose poort 8000 voor Laravel
    EXPOSE 8000
    
    # Start Laravel server
    CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
    
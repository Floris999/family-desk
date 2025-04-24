# --- STAGE 1: Build Laravel + Vue ---
    FROM php:8.1-fpm AS build

    # Installeer OS packages
    RUN apt-get update && apt-get install -y \
        git curl unzip zip \
        libzip-dev \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libonig-dev \
        libxml2-dev \
        pkg-config \
        nodejs \
        npm
    
    RUN docker-php-ext-configure gd --with-freetype --with-jpeg
    
    # Installeer PHP-extensies
    RUN docker-php-ext-install pdo
    RUN docker-php-ext-install pdo_mysql
    RUN docker-php-ext-install mbstring
    RUN docker-php-ext-install zip
    RUN docker-php-ext-install gd
    RUN docker-php-ext-install bcmath
    RUN docker-php-ext-install xml
    # tokenizer is standaard → niet installeren
    
    # Composer
    RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
    
    WORKDIR /var/www/html
    
    COPY composer.json composer.lock ./
    RUN composer install --no-dev --optimize-autoloader --verbose
    
    COPY . .
    
    # Build frontend
    RUN npm install && npm run build
    
    # --- STAGE 2: Runtime image ---
    FROM php:8.1-fpm
    
    RUN apt-get update && apt-get install -y \
        libzip-dev \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libonig-dev \
        libxml2-dev \
        pkg-config
    
    RUN docker-php-ext-configure gd --with-freetype --with-jpeg
    RUN docker-php-ext-install pdo pdo_mysql mbstring zip gd bcmath xml
    # tokenizer weglaten
    
    WORKDIR /var/www/html
    
    COPY --from=build /var/www/html /var/www/html
    
    RUN chown -R www-data:www-data /var/www/html
    USER www-data
    
    EXPOSE 8000
    CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
    
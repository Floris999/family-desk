# --- STAGE 1: Build stage ---
    FROM php:8.1-fpm AS build

    # Install system dependencies
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
    
    # Configure GD properly
    RUN docker-php-ext-configure gd --with-freetype --with-jpeg
    
    # Install PHP extensions one-by-one for easier debugging
    RUN docker-php-ext-install pdo pdo_mysql
    RUN docker-php-ext-install mbstring
    RUN docker-php-ext-install zip
    RUN docker-php-ext-install gd
    RUN docker-php-ext-install bcmath
    RUN docker-php-ext-install tokenizer
    RUN docker-php-ext-install xml
    
    # Install Composer
    RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
    
    WORKDIR /var/www/html
    
    # Copy only composer files for cache efficiency
    COPY composer.json composer.lock ./
    RUN composer install --no-dev --optimize-autoloader --verbose
    
    # Copy rest of the app
    COPY . .
    
    # Build frontend assets (Vue)
    RUN npm install && npm run build
    
    # --- STAGE 2: Runtime stage ---
    FROM php:8.1-fpm
    
    # Install required runtime libraries only
    RUN apt-get update && apt-get install -y \
        libzip-dev \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libonig-dev \
        libxml2-dev \
        pkg-config
    
    # Configure GD again in runtime image
    RUN docker-php-ext-configure gd --with-freetype --with-jpeg
    
    # Install PHP extensions
    RUN docker-php-ext-install pdo pdo_mysql mbstring zip gd bcmath tokenizer xml
    
    WORKDIR /var/www/html
    
    # Copy app from build container
    COPY --from=build /var/www/html /var/www/html
    
    RUN chown -R www-data:www-data /var/www/html
    USER www-data
    
    EXPOSE 8000
    
    CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
    
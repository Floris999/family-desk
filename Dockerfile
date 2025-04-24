# --- STAGE 1: Build Laravel + Assets ---
    FROM php:8.1-fpm AS build

    # Install system dependencies and PHP extensions
    RUN apt-get update && apt-get install -y \
        git curl unzip zip \
        libpng-dev libjpeg62-turbo-dev libfreetype6-dev libzip-dev libxml2-dev libonig-dev pkg-config
    
    # Fix for freetype and jpeg for GD (some images need explicit symlinks)
    RUN ln -s /usr/include/freetype2 /usr/include/freetype && \
        docker-php-ext-configure gd --with-freetype --with-jpeg
    
    # Install PHP extensions
    RUN docker-php-ext-install \
        pdo \
        pdo_mysql \
        mbstring \
        zip \
        gd \
        bcmath \
        tokenizer \
        xml
    
    # Install Composer
    RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
    
    WORKDIR /var/www/html
    
    COPY composer.json composer.lock ./
    RUN composer install --no-dev --optimize-autoloader --verbose
    
    COPY . .
    
    # Install Node and build frontend (Vue)
    RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
        apt-get install -y nodejs && \
        npm install && npm run build
    
    # --- STAGE 2: Clean runtime container ---
    FROM php:8.1-fpm
    
    RUN apt-get update && apt-get install -y \
        libpng-dev libjpeg62-turbo-dev libfreetype6-dev libzip-dev libxml2-dev libonig-dev pkg-config
    
    RUN ln -s /usr/include/freetype2 /usr/include/freetype && \
        docker-php-ext-configure gd --with-freetype --with-jpeg && \
        docker-php-ext-install \
            pdo \
            pdo_mysql \
            mbstring \
            zip \
            gd \
            bcmath \
            tokenizer \
            xml
    
    WORKDIR /var/www/html
    
    COPY --from=build /var/www/html /var/www/html
    
    RUN chown -R www-data:www-data /var/www/html
    USER www-data
    
    EXPOSE 8000
    CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
    
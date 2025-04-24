# --- STAGE 1: Build Stage met Composer + Node ---
    FROM php:8.1-fpm AS build

    # Systeemvereisten en PHP-extensies installeren
    RUN apt-get update && apt-get install -y \
        git curl unzip zip \
        libpng-dev libjpeg-dev libfreetype6-dev libzip-dev libxml2-dev libonig-dev pkg-config
    
    # Configureer GD vóór installatie
    RUN docker-php-ext-configure gd --with-freetype --with-jpeg
    
    # Installeer PHP-extensies
    RUN docker-php-ext-install \
        pdo \
        pdo_mysql \
        mbstring \
        zip \
        gd \
        bcmath \
        tokenizer \
        xml
    
    # Installeer Composer
    RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
    
    # Werkdirectory
    WORKDIR /var/www/html
    
    # Kopieer alleen dependency files eerst voor caching
    COPY composer.json composer.lock ./
    
    # Installeer PHP dependencies
    RUN composer install --no-dev --optimize-autoloader --verbose
    
    # Kopieer volledige project
    COPY . .
    
    # Node.js installeren + Vue build uitvoeren
    RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
        apt-get install -y nodejs && \
        npm install && npm run build
    
    # --- STAGE 2: Production Container ---
    FROM php:8.1-fpm
    
    # Alleen noodzakelijke packages voor runtime
    RUN apt-get update && apt-get install -y \
        libpng-dev libjpeg-dev libfreetype6-dev libzip-dev libxml2-dev libonig-dev pkg-config
    
    # Configureer en installeer GD opnieuw
    RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
        docker-php-ext-install \
        pdo \
        pdo_mysql \
        mbstring \
        zip \
        gd \
        bcmath \
        tokenizer \
        xml
    
    # Werkdirectory
    WORKDIR /var/www/html
    
    # Kopieer alles uit build stage
    COPY --from=build /var/www/html /var/www/html
    
    # Zet permissies goed
    RUN chown -R www-data:www-data /var/www/html
    USER www-data
    
    # Poort voor Laravel
    EXPOSE 8000
    
    # Start Laravel via artisan
    CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
    
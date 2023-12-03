FROM php:7.4-fpm as api

WORKDIR /var/www

ARG user
ARG uid

RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libc6 \
    zip \
    unzip \
    default-mysql-client \
    netcat-openbsd

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

RUN pecl install redis

COPY --from=composer:2.5.8 /usr/bin/composer /usr/bin/composer

RUN useradd -G www-data,root -u $uid -d /home/$user $user

RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

COPY ./composer*.json /var/www
#COPY ./docker-compose/php-fpm/php-prod.ini /usr/local/etc/php/conf.d/php.ini
#COPY ./docker-compose/php-fpm/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./docker-compose/bin/update.sh /var/www/update.sh
#COPY ./docker-compose/run.sh /var/www/run.sh

RUN composer install --no-scripts

COPY ./ .

RUN php artisan storage:link && \
    chmod +x ./update.sh && \
    chmod +x ./run.sh && \
    chown -R $user:$user /var/www && \
    chmod -R 775 ./storage ./bootstrap/cache && \
    chmod -R 777 /var/www/storage

USER $user
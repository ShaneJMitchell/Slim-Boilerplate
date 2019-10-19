FROM php:7.2.2-fpm
ARG arg

RUN apt-get update -y && apt-get install -y libmcrypt-dev openssl curl libcurl4-gnutls-dev zlib1g-dev libpng-dev zip unzip libc6 libxml2-dev libxslt1-dev libicu-dev
RUN pecl install mcrypt-1.0.1
RUN docker-php-ext-install mbstring zip json ctype curl soap xml intl iconv bcmath pdo pdo_mysql
RUN docker-php-ext-enable mcrypt

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app
COPY . /app

RUN if [ $arg -eq 1 ] ; then \
    chown -R www-data:www-data /app \
    && cp /app/.env.example /app/.env \
    && php /usr/bin/composer install \
    && phpdbg -qrr ./vendor/bin/phpunit --coverage-html code-coverage ; fi


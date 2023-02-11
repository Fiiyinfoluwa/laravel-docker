FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
    && apt install apache2 wget lsb-release software-properties-common -y

WORKDIR /var/www/html/

COPY laravel-realworld-example-app /var/www/html/laravel-realworld-example-app

WORKDIR /var/www/html/laravel-realworld-example-app

RUN apt install apt-transport-https gnupg2 ca-certificates -y

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php -y \
    && apt install libapache2-mod-php php8.1 php-common php-xml php-gd php8.1-opcache php-mbstring \
    php-tokenizer php-json php-bcmath php-zip unzip curl -y \
    php8.1-curl php-curl zip php-mysql php8.1-mysql vim git

COPY php.ini /etc/php/8.1/apache2/php.ini

COPY .env.example /var/www/html/laravel-realworld-example-app/.env

COPY laravel-realworld-example-app.conf /etc/apache2/sites-available/laravel-realworld-example-app.conf

COPY web.php routes/web.php

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && chown -R www-data:www-data /var/www/html/laravel-realworld-example-app \
    && chmod -R 775 /var/www/html/laravel-realworld-example-app

RUN composer install --no-dev

RUN a2dissite 000-default.conf && a2enmod rewrite && a2ensite laravel-realworld-example-app.conf

RUN php artisan key:generate

EXPOSE 80

CMD [ "/usr/sbin/apachectl", "-D", "FOREGROUND" ]

FROM php:8.1.1-fpm-alpine

COPY --from=mlocati/php-extension-installer:1.1.41 /usr/bin/install-php-extensions /usr/local/bin/

# Instalación de paquete linux-headers
RUN apk add --no-cache linux-headers

RUN apk add --no-cache autoconf g++ make

RUN install-php-extensions \
    bcmath \
    exif \
    gd \
    gmp \
    mysqli \
    opcache \
    pdo_mysql \
    zip \
    soap \
    @composer \
    && apk add --no-cache supervisor

# RUN apk del autoconf g++ make

RUN pecl install -o -f xdebug-3.2.2 \
    && docker-php-ext-enable xdebug

COPY ./docker/local/entrypoint.sh /usr/local/bin/docker-entrypoint

RUN chmod +x /usr/local/bin/docker-entrypoint

COPY ./app /var/www/app/app
COPY ./bootstrap /var/www/app/bootstrap
COPY ./config /var/www/app/config
COPY ./database /var/www/app/database
COPY ./public /var/www/app/public
COPY ./resources /var/www/app/resources
COPY ./routes /var/www/app/routes
COPY ./tests /var/www/app/tests
COPY ./storage /var/www/app/storage
COPY ./vendor /var/www/app/vendor
COPY ./.env /var/www/app
COPY ./.env.example /var/www/app
COPY ./artisan /var/www/app
COPY ./composer.json /var/www/app
COPY ./composer.lock /var/www/app
COPY ./package-lock.json /var/www/app
COPY ./package.json /var/www/app
COPY ./vite.config.js /var/www/app

COPY ./phpunit.xml /var/www/app

WORKDIR /var/www/app

COPY ./docker/local/supervisor/supervisord.conf /

COPY ./docker/local/php/config/php.ini /usr/local/etc/php/conf.d/in-php.ini

ARG UID=1500
ENV DRIVE_USER=inertiauser

RUN addgroup --gid=$UID --system "$DRIVE_USER" \
    && adduser --uid=$UID \
    --disabled-password \
    --gecos "" \
    --home "$(pwd)" \
    --ingroup "$DRIVE_USER" \
    --no-create-home \
    "$DRIVE_USER" \
    && addgroup "$DRIVE_USER" www-data \
    && mkdir /var/log/supervisord /var/run/supervisord \
    && chown -R "$DRIVE_USER":"$DRIVE_USER" /var/www/app \
    && chown $DRIVE_USER:www-data /var/log/supervisord /var/run/supervisord

USER $UID

RUN /usr/local/bin/composer install

ENTRYPOINT ["docker-entrypoint"]
CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]

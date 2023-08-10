FROM php:8.1.1-fpm-alpine

COPY --from=mlocati/php-extension-installer:1.1.41 /usr/bin/install-php-extensions /usr/local/bin/

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

COPY ./docker/development/php/config/php.ini /usr/local/etc/php/conf.d/in-php.ini

ARG UID=1500
ENV COLLECTION_USER=collectionuser

RUN addgroup --gid=$UID --system "$COLLECTION_USER" \
    && adduser --uid=$UID \
    --disabled-password \
    --gecos "" \
    --home "$(pwd)" \
    --ingroup "$COLLECTION_USER" \
    --no-create-home \
    "$COLLECTION_USER" \
    && addgroup "$COLLECTION_USER" www-data \
    && mkdir /var/log/supervisord /var/run/supervisord \
    && chown -R "$COLLECTION_USER":"$COLLECTION_USER" /var/www/app \
    && chown $COLLECTION_USER:www-data /var/log/supervisord /var/run/supervisord

USER $UID

RUN /usr/local/bin/composer install

ENTRYPOINT ["docker-entrypoint"]
CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]
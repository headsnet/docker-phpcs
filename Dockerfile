FROM alpine:3.8

RUN set -x \
    && apk add --no-cache \
        php7 \
        php7-ctype \
        php7-iconv \
        php7-simplexml \
        php7-tokenizer \
        php7-xmlwriter \
    && apk add --no-cache -t .build-deps \
        git \
        php7-json \
        php7-openssl \
        php7-phar \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer \
    && rm composer-setup.php \
    && composer global require 'squizlabs/php_codesniffer=3.3.0' \
    && git clone https://github.com/headsnet/php-coding-standards.git \
    && ln -s /php-coding-standards/Headstrong/ /root/.composer/vendor/squizlabs/php_codesniffer/src/Standards/Headstrong \
    && ln -s /php-coding-standards/Symfony2/ /root/.composer/vendor/squizlabs/php_codesniffer/src/Standards/Symfony2 \
    # Clean-up
    && rm /usr/local/bin/composer \
    && apk del --purge .build-deps \
    # Default directory
    && mkdir -p /code

ENV PATH=$PATH:/root/.composer/vendor/bin/

WORKDIR /code
VOLUME /code


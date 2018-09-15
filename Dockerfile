FROM alpine:3.8

RUN set -x \
    && apk add --no-cache \
		php7 \
        php7-iconv \
        php7-simplexml \
        php7-tokenizer \
        php7-phar \
        php7-xmlwriter \
    && apk add --no-cache -t .build-deps \
        wget \
    && wget https://github.com/headsnet/php-coding-standards/archive/master.zip \
    && unzip /master.zip \
    && rm /master.zip \
    && mv /php-coding-standards-master /standards \
    && wget https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar \
    && mv /phpcs.phar /usr/local/bin/phpcs \
    && chmod +x /usr/local/bin/phpcs \
    && phpcs --config-set installed_paths /standards/HeadstrongPSR2 \
    # Clean-up
    && apk del --purge .build-deps \
    # Default directory
    && mkdir -p /code

WORKDIR /code
VOLUME /code

ENTRYPOINT ["phpcs"]

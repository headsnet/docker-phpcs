FROM alpine:3.8

RUN set -x \
    && apk add --no-cache \
		php7 \
        php7-iconv \
        php7-simplexml \
        php7-tokenizer \
        php7-phar \
        php7-xmlwriter \
    && wget https://github.com/headsnet/php-coding-standards/archive/master.zip \
    && unzip /master.zip \
    && rm /master.zip \
    && wget https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar \
    && mv /phpcs.phar /usr/local/bin/phpcs \
    && chmod +x /usr/local/bin/phpcs \
    && phpcs --config-set installed_paths /php-coding-standards-master/HeadstrongPSR2 \
    && mkdir -p /code

WORKDIR /code
VOLUME /code

ENTRYPOINT ["phpcs"]

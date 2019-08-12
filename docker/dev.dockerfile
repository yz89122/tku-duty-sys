FROM php:7-cli-alpine

WORKDIR /app

RUN set -eux; \
	apk add --no-cache libpng libzip composer npm git; \
	apk add --no-cache --virtual .dev-deps \
		libpng-dev \
		libzip-dev \
	; \
	docker-php-ext-install pdo_mysql gd zip; \
	apk del .dev-deps; \
	apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS; \
	pecl install -o -f igbinary redis xdebug; \
	docker-php-ext-enable igbinary redis xdebug; \
	apk del --no-network .phpize-deps; \
	mkdir /.npm /.config /.composer; \
	chmod -R 777 /.npm /.config /.composer

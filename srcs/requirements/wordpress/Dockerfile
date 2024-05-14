FROM alpine:3.18

RUN apk update && apk upgrade \
	&& apk add mariadb-client curl \
	&& apk add php82 php82-fpm \
		php82-apache2 \
		php82-bcmath \
		php82-brotl \
		php82-bz2 \
		php82-calendar \
		php82-cgi \
		php82-common \
		php82-ctype \
		php82-curl \
		php82-dba \
		php82-dbg \
		php82-dev \
		php82-doc \
		php82-dom \
		php82-embed \
		php82-enchant \
		php82-exif \
		php82-ffi \
		php82-fileinfo \
		php82-fpm \
		php82-ftp \
		php82-gd \
		php82-gettext \
		php82-gmp \
		php82-iconv \
		php82-imap \
		php82-intl \
		php82-ldap \
		php82-litespeed \
		php82-mbstring \
		php82-mysqli \
		php82-mysqlnd \
		php82-odbc \
		php82-opcache \
		php82-openssl \
		php82-pcntl \
		php82-pdo \
		php82-pdo_dblib \
		php82-pdo_mysql \
		php82-pdo_odbc \
		php82-pdo_pgsql \
		php82-pdo_sqlite \
		php82-pear \
		php82-pecl-amq \
		php82-pecl-apcu \
		php82-pecl-as \
		php82-pecl-couchbase \
		php82-pecl-igbinary \
		php82-pecl-imagick \
		php82-pecl-imagick-dev \
		php82-pecl-lz \
		php82-pecl-maxmindd \
		php82-pecl-memcache \
		php82-pecl-memcached \
		php82-pecl-mongod \
		php82-pecl-msgpack \
		php82-pecl-protobuf \
		php82-pecl-ps \
		php82-pecl-redis \
		php82-pecl-smbclien \
		php82-pecl-ssh2 \
		php82-pecl-swoole \
		php82-pecl-swoole-dev \
		php82-pecl-uploadprogress \
		php82-pecl-uploadprogress-doc \
		php82-pecl-uui \
		php82-pecl-xdebug \
		php82-pecl-xhprof \
		php82-pecl-xhprof-assets \
		php82-pecl-yaml \
		php82-pecl-zst \
		php82-pgsql \
		php82-phar \
		php82-phpdbg \
		php82-posix \
		php82-pspell \
		php82-session \
		php82-shmop \
		php82-simplexml \
		php82-snmp \
		php82-soap \
		php82-sockets \
		php82-sodium \
		php82-sqlite3 \
		php82-sysvmsg \
		php82-sysvsem \
		php82-sysvshm \
		php82-tidy \
		php82-tokenizer \
		php82-xml \
		php82-xmlreader \
		php82-xmlwriter \
		php82-xsl \
		php82-zip

RUN mkdir -p /usr/local/bin \
	&& curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

RUN sed -i 's/listen = 127.0.0.1:9000/listen = [::]:9000/g' /etc/php82/php-fpm.d/www.conf

COPY . src/

WORKDIR src/

EXPOSE 9000

RUN sh ./tools/setup.sh

CMD ["php-fpm", "-F"]

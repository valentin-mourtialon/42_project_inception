FROM alpine:3.18

RUN apk update && apk upgrade
RUN apk add --no-cache mariadb-client curl
RUN apk add --no-cache php php-fpm php-mysqli php-json php-openssl php-curl php-zlib php-xml php-phar php-intl php-dom php-ctype php-session php-mbstring php-pdo php-pdo_mysql php-gd


RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN php wp-cli.phar --info
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/bin/wp-cli.phar

RUN sed -i 's/listen = 127.0.0.1:9000/listen = [::]:9000/g' /etc/php81/php-fpm.d/www.conf

RUN mkdir -p /var/www/html/wordpress && chown -R nobody:nobody /var/www/html

COPY . src/

WORKDIR src/

RUN ln -s /usr/sbin/php-fpm81 /usr/sbin/php-fpm

ENTRYPOINT ["sh", "./tools/setup.sh"]

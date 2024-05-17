FROM alpine:3.18

RUN apk update && apk upgrade
RUN apk add --no-cache mariadb-client wget
RUN apk add --no-cache php php-fpm php-mysqli php-json php-openssl php-curl php-zlib php-xml php-phar php-intl php-dom php-ctype php-session php-mbstring php-pdo php-pdo_mysql php-gd

RUN sed -i 's/listen = 127.0.0.1:9000/listen = [::]:9000/g' /etc/php81/php-fpm.d/www.conf
RUN ln -s /usr/sbin/php-fpm81 /usr/sbin/php-fpm

# Install wp cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN php wp-cli.phar --info
RUN mv wp-cli.phar /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

RUN mkdir -p /var/www/html/wordpress && chown -R root:root /var/www/html/wordpress

COPY ./tools/setup.sh /tmp/mytools/setup.sh
RUN chmod +x /tmp/mytools/setup.sh

WORKDIR /var/www/html/wordpress

ENTRYPOINT ["sh", "/tmp/mytools/setup.sh"]

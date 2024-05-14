FROM alpine:3.18

RUN apk update && apk upgrade

RUN apk add --no-cache mariadb mariadb-client openrc 

RUN rc-update add mariadb default

COPY . src/

WORKDIR src/

COPY ./conf/my.cnf /etc/my.cnf

EXPOSE 3306

CMD ["sh", "./tools/setup.sh"]


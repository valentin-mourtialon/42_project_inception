FROM alpine:3.18

RUN apk update && apk upgrade
RUN apk add no-cache mariadb mariadb-client openrc 
RUN rc-update add mariadb default

COPY . src/

WORKDIR src/

RUN sh ./tools/setup.sh


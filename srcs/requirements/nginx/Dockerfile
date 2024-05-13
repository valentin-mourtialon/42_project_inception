FROM alpine:3.18

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
COPY . src/

WORKDIR src/

RUN sh ./tools/setup.sh

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

FROM alpine:3.18

COPY ./default.conf ./etc/nginx/conf.d/default.conf
COPY . src/

WORKDIR src/

RUN sh setup.sh

EXPOSE 443

CMD ["nginx", "-g", "deamon off;"]

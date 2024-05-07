#!/bin/sh

#Prerequisites
apk update
apk add openssl curl ca-certificates

#Set up the apk repository for stable nginx packages
printf "%s%s%s%s\n" \
    "@nginx " \
    "http://nginx.org/packages/alpine/v" \
    `egrep -o '^[0-9]+\.[0-9]+' /etc/alpine-release` \
    "/main" \
    | tee -a /etc/apk/repositories

#Import an official nginx signing key so apk could verify the packages authenticity.
#Fetch the key:
curl -o /tmp/nginx_signing.rsa.pub https://nginx.org/keys/nginx_signing.rsa.pub
#Verify that downloaded file contains the proper key
openssl rsa -pubin -in /tmp/nginx_signing.rsa.pub -text -noout

#Finally, move the key to apk trusted keys storage
mv /tmp/nginx_signing.rsa.pub /etc/apk/keys/

#Install nginx
apk add nginx@nginx

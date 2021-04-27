#!/bin/bash

CERT_PATH="./service/nginx/conf.d"

openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 \
    -subj   "/C=US/ST=Test/L=Test/O=Test/CN=test.com"     \
    -keyout "$CERT_PATH/default_cert.key"                 \
    -out    "$CERT_PATH/default_cert.crt"

openssl x509 -text -noout -in "$CERT_PATH/default_cert.crt"

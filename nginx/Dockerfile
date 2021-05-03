FROM alpine:latest

COPY nginx.conf setup_nginx.sh default.conf ssl_request.conf index.html ./

RUN mkdir -p /run/nginx

EXPOSE 22 80 443

RUN sh setup_nginx.sh

ENTRYPOINT sh &&
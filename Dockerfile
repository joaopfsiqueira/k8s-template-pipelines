FROM nginx:1.25-alpine

WORKDIR /usr/share/nginx/html

COPY /manifest/docker/nginx-vhost-default.conf /etc/nginx/conf.d/default.conf

EXPOSE 8000

cmd ["nginx", "-g", "daemon off;"]

FROM nginx:latest

RUN apt update
RUN apt install -y nano net-tools
RUN apt install -y iproute2 iputils-ping dnsutils
RUN apt install -y certbot python3-certbot-nginx 


RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup
RUN mkdir -p /var/www/html/www

ADD config/nginx.conf /etc/nginx/nginx.conf






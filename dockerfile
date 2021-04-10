FROM debian:buster
RUN apt-get update \
&& apt-get -y install wget \
&& apt-get -y install nginx \
&& apt-get -y install mariadb-server \
&& apt -y install php-fpm php-mysql \
&& apt-get install openssl \
&& wget https://wordpress.org/latest.tar.gz \
&& wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz

ADD /srcs/config_nginx /etc/nginx

COPY srcs/index.html ./
COPY srcs/start.sh ./
COPY srcs/own_config ./
COPY srcs/test_php.php ./
COPY srcs/wp-config.php ./
COPY srcs/config.inc.php ./
COPY srcs/config_autoindex_off ./
COPY srcs/disable_autoindex.sh ./

EXPOSE 80:80
EXPOSE 443:443

CMD bash /start.sh



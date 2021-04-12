FROM debian:buster
RUN apt-get update \
&& apt-get -y install wget \
&& apt-get -y install nginx \
&& apt-get -y install mariadb-server \
&& apt-get -y install php-fpm php-mysql \
&& apt install -y php-json php-mbstring \
&& apt-get install openssl \
&& wget https://wordpress.org/latest.tar.gz \
&& wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz

ADD /srcs/config_nginx /etc/nginx

COPY srcs/index.html ./
COPY srcs/own_config ./
COPY srcs/wp-config.php ./
COPY srcs/config.inc.php ./
COPY srcs/config_autoindex_off ./
COPY srcs/disable_autoindex.sh ./
COPY srcs/nath_db.sql ./

EXPOSE 80:80
EXPOSE 443:443

# ssl config
RUN mkdir /etc/nginx/ssl \
&& openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=fantastic_company/OU=nath/CN=localhost"

# mariadb config
RUN service mysql start \
&& echo "CREATE DATABASE nath_db;" | mysql -u root \
&& echo "GRANT ALL ON nath_db.* TO 'nath'@'localhost' IDENTIFIED BY 'toto' WITH GRANT OPTION;"| mysql -u root \
&& echo "FLUSH PRIVILEGES;" | mysql -u root \
&& mysql -u root nath_db < nath_db.sql

# nginx config
RUN mkdir -p /var/www/localhost \
&& cp own_config /etc/nginx/sites-available/localhost \
&& cp config_autoindex_off /etc/nginx/sites-available/localhost_autoindex_off \
&& mkdir -p /var/www/home_without_autoindex \
&& cp index.html /var/www/home_without_autoindex \
&& ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/

# wordpress config
RUN mkdir var/www/localhost/wordpress \
&& tar -xzvf latest.tar.gz \
&& cp wp-config.php /wordpress/wp-config.php \
&& cp -a /wordpress/. /var/www/localhost/wordpress \
&& chown -R www-data:www-data /var/www/localhost \
&& rm -rf latest.tar.gz

# phpmyadmin config
RUN mkdir var/www/localhost/phpMyAdmin \
&& tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz \
&& mv phpMyAdmin-4.9.0.1-all-languages phpMyAdmin \
&& cp -a /phpMyAdmin/. /var/www/localhost/phpMyAdmin \
&& rm -rf phpMyAdmin-4.9.0.1-all-languages \
&& rm -rf phpMyAdmin-4.9.0.1-all-languages.tar.gz \
&& rm -rf var/www/html/index.nginx-debian.html

RUN cp -a config.inc.php var/www/localhost/phpMyAdmin/config.inc.php \
&& mkdir -p var/www/localhost/phpMyAdmin/tmp/ \
&& chmod 777 var/www/localhost/phpMyAdmin/tmp/ \
&& chown -R www-data:www-data var/www/localhost/phpMyAdmin/tmp/

# launch
CMD ["sh", "-c", "service mysql start && service php7.3-fpm start && service nginx start && sleep infinity"]


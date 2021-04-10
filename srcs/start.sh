# ssl config
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=fantastic_company/OU=nath/CN=localhost"

# mariadb config
service mysql start
echo "CREATE DATABASE nath_db;" | mysql -u root
echo "GRANT ALL ON nath_db.* TO 'nath'@'localhost' IDENTIFIED BY 'toto' WITH GRANT OPTION;"| mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

# nginx config
mkdir -p /var/www/localhost
cp own_config /etc/nginx/sites-available/localhost
cp config_autoindex_off /etc/nginx/sites-available/localhost_autoindex_off
mkdir -p /var/www/home_without_autoindex
cp index.html /var/www/home_without_autoindex
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/

# wordpress config
mkdir var/www/localhost/wordpress
tar -xzvf latest.tar.gz
cp wp-config.php /wordpress/wp-config.php
cp -a /wordpress/. /var/www/localhost/wordpress
chown -R www-data:www-data /var/www/localhost
rm -rf latest.tar.gz

# phpmyadmin config
mkdir var/www/localhost/phpMyAdmin
tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
mv phpMyAdmin-4.9.0.1-all-languages phpMyAdmin
cp -a /phpMyAdmin/. /var/www/localhost/phpMyAdmin
rm -rf phpMyAdmin-4.9.0.1-all-languages
rm -rf phpMyAdmin-4.9.0.1-all-languages.tar.gz
rm -rf var/www/html/index.nginx-debian.html

# launch
service nginx start
/etc/init.d/php7.3-fpm start
sleep infinity

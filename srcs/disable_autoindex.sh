cd  /etc/nginx/sites-enabled   && rm -rf localhost
cp -a /wordpress/. /var/www/home_without_autoindex/wordpress
chown -R www-data:www-data /var/www/home_without_autoindex
cp -a /phpMyAdmin/. /var/www/home_without_autoindex/phpMyAdmin
ln -s /etc/nginx/sites-available/localhost_autoindex_off /etc/nginx/sites-enabled/localhost
service nginx reload

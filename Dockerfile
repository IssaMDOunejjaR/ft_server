FROM debian:buster

RUN	apt-get update && apt-get upgrade
RUN apt-get -y install wget
RUN apt-get -y install nginx
RUN apt-get -y install openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=MA/ST=Khouribga/L=Khouribga/O=1337/CN=issamounejjar"
RUN apt-get install php-mbstring php-zip php-gd php-xml php-pear php-gettext php-cli php-cgi -y
RUN apt-get -y install php-fpm php-mysql
RUN apt-get install -y default-mysql-server
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.4/phpMyAdmin-4.9.4-english.tar.gz
RUN tar -xf phpMyAdmin-4.9.4-english.tar.gz
RUN mv phpMyAdmin-4.9.4-english /var/www/html/phpmyadmin
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xf latest.tar.gz
RUN mv wordpress /var/www/html/wordpress
COPY srcs/default /etc/nginx/sites-available/
COPY srcs/wp-config.php /var/www/html/wordpress
COPY srcs/config.inc.php /var/www/html/phpmyadmin
COPY srcs/start_services.sh tmp/
COPY srcs/users.sh tmp/
RUN sh tmp/users.sh
RUN chown -R www-data:www-data /var/www/html
CMD sh tmp/start_services.sh && tail -f /dev/null

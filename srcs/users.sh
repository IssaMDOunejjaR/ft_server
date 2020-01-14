#! /bin/sh
service mysql start
mysql < /var/www/html/phpmyadmin/sql/create_tables.sql
mysql -uroot -e "CREATE USER 'issam'@'localhost' IDENTIFIED BY '123456789';"
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'issam'@'localhost';"
mysql -uroot -e "CREATE USER 'ounejjar'@'localhost' IDENTIFIED BY '1234567890';"
mysql -uroot -e "GRANT SELECT, INSERT, UPDATE, DELETE ON phpmyadmin.* TO 'ounejjar'@'localhost';"
mysql -uroot -e "CREATE DATABASE wordpress_db;"
mysql -uroot -e "GRANT ALL ON wordpress_db.* TO 'issam'@'localhost';"

#!/bin/bash

# update apt
echo "updating apt..."
sudo apt-get update
sudo apt-get -y upgrade

# install apache
echo "installing apache..."
sudo apt-get install -y apache2

# install mariadb/mysql
echo "installing mariadb..."
sudo apt-get install -y debconf-utils
sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mariadb-server mysql-server/root_password_again password root'
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository 'deb [arch=amd64,i386] http://sfo1.mirrors.digitalocean.com/mariadb/repo/10.3/ubuntu xenial main'
sudo apt-get install -y mariadb-server

# allow root mysql login without sudo
echo "setting mysql permissions..."
sudo mysql -e "DROP USER 'root'@'localhost'; CREATE USER 'root'@'localhost' IDENTIFIED BY 'root'; GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION; FLUSH PRIVILEGES;"

# install php
echo "installing php..."
sudo apt-get -y install libapache2-mod-fastcgi libapache2-mod-php php7.0-fpm php7.0 php7.0-mysql

# copy config files
echo "copying apache config..."
sudo rm -r /etc/apache2/sites-available/000-default.conf
sudo cp /var/www/html/provision/apache/000-default.conf /etc/apache2/sites-available/

#copy bash aliases
echo "copying bash aliases..."
cp /var/www/html/provision/misc/.bash_aliases ~

echo "enabling mod_rewrite..."
sudo a2enmod rewrite

echo "restarting apache..."
sudo service apache2 restart

echo "Provisioning complete!"
#!/bin/bash
 
echo "Установка и настройка MariaDB"
 
sudo apt install mariadb-server -y
sudo systemctl enable mariadb
sudo systemctl start mariadb
 
root_password=Qwedsa!1
 
# Установка root-пароля для СУБД
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$root_password';"
sudo mysql -e "UPDATE mysql.user SET authentication_string = '' WHERE user = 'root';"
sudo mysql -e "UPDATE mysql.user SET plugin = '' WHERE user = 'root';"

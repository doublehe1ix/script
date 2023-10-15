#!/bin/bash
 
echo "Установка и настройка MariaDB"
 
sudo apt install mariadb-server -y
sudo systemctl enable mariadb
sudo systemctl start mariadb
 
root_password=Qwedsa!1
 
# Установка root-пароля для СУБД
sudo mysql -e "UPDATE mysql.user SET Password = PASSWORD('$root_password') WHERE User = 'root'"

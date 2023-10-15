#!/bin/bash
PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
# объявляем переменные
dst="/backup/mysql"
usr="dbadmin"
pwd="Qwedsa!1"
date=`date +%Y-%m-%d`
#Очищаем каталоги от старых бэкапов и создаем каталог для новых, если он отсутствует
find $dst -type d \( -name "*-1[^5]" -o -name "*-[023]?" \) -mtime +30 -exec rm -R {} \; 2>&1
find $dst -type d -name "*-*" -mtime +180 -exec rm -R {} \; 2>&1
test -d $dst/$date || mkdir $dst/$date 2>&1
# Для всех баз, за исключением служебных, создаем подкаталог для бекапов таблиц, делаем потабличный бекап с закоменченным указанием позиции бинлога с упаковкой в архив
for dbname in `echo show databases | mysql -u$usr -p$pwd | grep -Ev "Database|mysql|performance_schema|information_schema"`; do
mkdir $dst/$date/$dbname
for tabname in `echo show tables from $dbname | mysql -u$usr -p$pwd | grep -v Table`; do
mariadb-dump --dump-slave=2 -u$usr -p$pwd $dbname $tabname | gzip > $dst/$date/$dbname/$tabname.sql.gz;
done ;
done;

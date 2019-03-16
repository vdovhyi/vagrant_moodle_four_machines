#!/bin/bash
sudo yum update -y
#expect, wget
sudo yum install -y expect wget
# MariaDB
sudo yum -y install mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
# set root password

ROOT_PASS="r00t_PA@@"
DB_NAME="moodle_db"
DB_USER="moodle"
DB_PASS="user_PA@@w0rd"


sudo /usr/bin/mysqladmin -u root password $ROOT_PASS
mysql -u root -p$ROOT_PASS -e \
"CREATE DATABASE ${DB_NAME} DEFAULT CHARACTER SET UTF8 COLLATE utf8_unicode_ci;\
CREATE USER '${DB_USER}' IDENTIFIED BY '${DB_PASS}';\
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}' IDENTIFIED BY '${DB_PASS}' WITH GRANT OPTION;\
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${ROOT_PASS}' WITH GRANT OPTION;\
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}@%' IDENTIFIED BY '${DB_PASS}' WITH GRANT OPTION;;\
FLUSH PRIVILEGES;"
# restart
sudo systemctl restart mariadb



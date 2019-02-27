#!/bin/bash
sudo yum update -y
#expect, wget
sudo yum install -y expect wget
# MariaDB
sudo yum -y install mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
# set root password
sudo /usr/bin/mysqladmin -u root password 'r00t_PA@@'
mysql -u root -pr00t_PA@@ -e "SET GLOBAL character_set_server = 'utf8mb4';"
mysql -u root -pr00t_PA@@ -e "SET GLOBAL innodb_file_format = 'BARRACUDA';"
mysql -u root -pr00t_PA@@ -e "SET GLOBAL innodb_large_prefix = 'ON';"
mysql -u root -pr00t_PA@@ -e "SET GLOBAL innodb_file_per_table = 'ON';"
# allow remote access (required to access from our private network host. Note that this is completely insecure if used in any other way)
mysql -u root -p r00t_PA@@ -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION; FLUSH PRIVILEGES;"

# drop the anonymous users
#mysql -u root -ppassword -e "DROP USER ''@'localhost';"
#mysql -u root -ppassword -e "DROP USER ''@'$(hostname)';"

# drop the demo database
mysql -u root -pr00t_PA@@ -e "DROP DATABASE test;"
mysql -u root -pr00t_PA@@ -e "CREATE DATABASE moodle_db;"
mysql -u root -pr00t_PA@@ -e "CREATE USER 'moodle'@'%' IDENTIFIED BY 'user_PA@@w0rd';"
mysql -u root -pr00t_PA@@ -e "GRANT ALL PRIVILEGES ON moodle_db.* TO 'moodle'@'%';"
mysql -u root -pr00t_PA@@ -e "FLUSH PRIVILEGES;"
# restart
sudo systemctl restart mariadb


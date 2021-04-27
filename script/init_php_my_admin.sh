#!/bin/bash

PMA_PATH="./www/html/pma"
RANDOM_SECRET=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 32 ; echo '')

wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-all-languages.zip
unzip phpMyAdmin*.zip -d ./www/html
mv ./www/html/phpMyAdmin* "$PMA_PATH"

cp "$PMA_PATH/config.sample.inc.php" "$PMA_PATH/config.inc.php"
sed -i -e "s/cfg\['blowfish_secret'\] = ''/cfg['blowfish_secret'] = '$RANDOM_SECRET'/" "$PMA_PATH/config.inc.php"
sed -i -e "s/\['host'\] = 'localhost'/\['host'\] = 'mariadb'/" "$PMA_PATH/config.inc.php"

mkdir "$PMA_PATH/tmp"
chmod 777 "$PMA_PATH/tmp"

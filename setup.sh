#!/bin/bash

echo "---- Iniciando instalacao do ambiente de Desenvolvimento PHP [EspecializaTI] ---"

echo "--- Atualizando lista de pacotes ---"
sudo apt-get update

echo "--- Definindo Senha padrao para o MySQL e suas ferramentas ---"

DEFAULTPASS="vagrant"
sudo debconf-set-selections <<EOF
mysql-server	mysql-server/root_password password $DEFAULTPASS
mysql-server	mysql-server/root_password_again password $DEFAULTPASS
dbconfig-common	dbconfig-common/mysql/app-pass password $DEFAULTPASS
dbconfig-common	dbconfig-common/mysql/admin-pass password $DEFAULTPASS
dbconfig-common	dbconfig-common/password-confirm password $DEFAULTPASS
dbconfig-common	dbconfig-common/app-password-confirm password $DEFAULTPASS
phpmyadmin		phpmyadmin/reconfigure-webserver multiselect apache2
phpmyadmin		phpmyadmin/dbconfig-install boolean true
phpmyadmin      phpmyadmin/app-password-confirm password $DEFAULTPASS 
phpmyadmin      phpmyadmin/mysql/admin-pass     password $DEFAULTPASS
phpmyadmin      phpmyadmin/password-confirm     password $DEFAULTPASS
phpmyadmin      phpmyadmin/setup-password       password $DEFAULTPASS
phpmyadmin      phpmyadmin/mysql/app-pass       password $DEFAULTPASS
EOF

echo "--- Instalando pacotes basicos ---"
sudo apt-get install software-properties-common vim curl python-software-properties git-core --assume-yes --force-yes

echo "--- Adicionando repositorio do pacote PHP ---"
sudo add-apt-repository ppa:ondrej/php

echo "--- Atualizando lista de pacotes ---"
sudo apt-get update

echo "--- Instalando MySQL, Phpmyadmin e alguns outros modulos ---"
sudo apt-get install mysql-server mysql-client phpmyadmin --assume-yes --force-yes

echo "--- Instalando PHP, Apache e alguns modulos ---"
sudo apt-get install php7.2 php7.2-common --assume-yes --force-yes
sudo apt-get install php7.2-cli libapache2-mod-php7.2 php7.2-mysql php7.2-curl php-memcached php7.2-json php7.2-dev libapache2-mod-php7.2 php-mbstring php7.2-sqlite3  php*-mysql  php-gd php-xml --assume-yes --force-yes


echo "--- Atualizando lista de pacotes ---"
sudo apt-get update
sudo apt-get install php-mbstring php-xml php7.2-mbstring -y
sudo apt-get install php7.2-xml zip unzip php7.2-zip  -y
sudo apt-get install mysql-client-core-5.7 -y

echo "--- Habilitando o PHP 7.2 ---"
sudo a2dismod php5
sudo a2enmod php7.2

echo "--- Habilitando mod-rewrite do Apache ---"
sudo a2enmod rewrite

echo "--- Reiniciando Apache ---"
sudo service apache2 restart

echo "--- alter versao php cli ---"
sudo update-alternatives --set php /usr/bin/php7.2

echo "--- Baixando e Instalando Composer ---"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

echo "--- Instalando Banco NoSQL -> Redis <- ---" 
sudo apt-get install redis-server --assume-yes
sudo apt-get install php7.2-redis --assume-yes

# Instale apartir daqui o que você desejar 

echo "[OK] --- Ambiente de desenvolvimento concluido ---"
echo "Provisioning virtual machine..."
# Git
echo "Installing Git"
sudo apt-get install git -y
sudo apt-get update

# Nginx
echo "Installing Nginx"
sudo apt-get install nginx -y
sudo apt-get update

echo "Updating PHP repository"
sudo apt-get install python-software-properties build-essential -y
sudo apt-get install language-pack-en-base -y
sudo LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php -y
sudo apt-get update

echo "Installing PHP"
sudo apt-get install php7.0 php7.0-fpm php7.0-mysql -y
#To resolve the issue mentioned at https://github.com/oerdnj/deb.sury.org/issues/372, I fired below command
sudo apt-get install libpcre3

echo "Installing PHP extensions"
sudo apt-get install curl php7.0-common php7.0-cli  php7.0-curl php7.0-mcrypt php7.0-gd  -y

echo "Getting ready to install mysql 5.7"
sudo apt-get install debconf-utils -y


export DEBIAN_FRONTEND=noninteractive
ROOT_PASSWORD="1234"

#echo mysql-apt-config mysql-apt-config/unsupported-platform select abort | /usr/bin/debconf-set-selections
#echo mysql-apt-config mysql-apt-config/repo-codename   select trusty | /usr/bin/debconf-set-selections
#echo mysql-apt-config mysql-apt-config/select-tools select | /usr/bin/debconf-set-selections
echo mysql-apt-config mysql-apt-config/repo-distro select ubuntu | /usr/bin/debconf-set-selections
echo mysql-apt-config mysql-apt-config/repo-codename   select precise | /usr/bin/debconf-set-selections
echo mysql-apt-config mysql-apt-config/select-server select mysql-5.7 | /usr/bin/debconf-set-selections
#echo mysql-apt-config mysql-apt-config/select-product select Apply | /usr/bin/debconf-set-selections

echo mysql-community-server mysql-community-server/root-pass password $ROOT_PASSWORD | /usr/bin/debconf-set-selections
echo mysql-community-server mysql-community-server/re-root-pass password $ROOT_PASSWORD | /usr/bin/debconf-set-selections
#echo mysql-community-server mysql-community-server/remove-data-dir boolean false | /usr/bin/debconf-set-selections
#echo mysql-community-server mysql-community-server/data-dir note | /usr/bin/debconf-set-selections


wget http://dev.mysql.com/get/mysql-apt-config_0.6.0-1_all.deb
dpkg --install mysql-apt-config_0.6.0-1_all.deb
apt-get update
apt-get --yes --force-yes install mysql-server-5.7


# Allow remote connections to MySQL server.
#if you are using mysql 5.6 then bind-address will be editable in /etc/mysql/mysql.conf.d/mysqld.cnf file, otherwise bind-address will be editable in /etc/mysql/my.cnf
sudo sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf


# Retart MySQL server to apply new configuration
sudo service mysql restart


#CREATE NEW MYSQL USER STARTS
    MYSQL='mysql'

    Q0="CREATE USER 'demo'@'%' IDENTIFIED BY 'demo123';"
    Q1="GRANT ALL PRIVILEGES ON *.* TO 'demo'@'%' IDENTIFIED BY 'demo123' WITH GRANT OPTION;"
    Q2="FLUSH PRIVILEGES;"
    SQL="${Q0}${Q1}${Q2}"

#$ROOT_PASSWORD HAS ALREADY BEEN DEFINED ABOVE

    $MYSQL -uroot -p$ROOT_PASSWORD -e "$SQL"
#CREATE NEW MYSQL USER ENDS

# Nginx Configuration
# If NginX does start, then you can always debug the issue by running "nginx" at terminal. This checks for any error in configuration of Nginx and prints out error if any. 
echo "Configuring Nginx"
sudo cp /var/www/provision/config/nginx_vhost /etc/nginx/sites-available/nginx_vhost
sudo ln -s /etc/nginx/sites-available/nginx_vhost /etc/nginx/sites-enabled/

sudo rm -rf /etc/nginx/sites-available/default

# Restart Nginx for the config to take effect
sudo service nginx restart

echo "Installing Composer"
sudo curl -sS https://getcomposer.org/installer | sudo php
sudo mv composer.phar /usr/local/bin/composer

echo "Finished provisioning."

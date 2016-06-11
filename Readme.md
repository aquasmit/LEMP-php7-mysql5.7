# LEMP [PHP 7 - MySQL 5.7 - NginX] 

####Installation####

Assuming that you have installed Virtualbox and Vagrant; you have enabled virutalization in BIOS settings.

Step 1: Fire up terminal and enter ````vagrant up````
Step 2: Sit back and have a cup of coffee

####Some addition info... ignore typos ####

1. This vagrant's provisioning script includes install.sh and also folder "provision".
Folder contains "provision" contains virtual host file "config/nginx_vhost" for nginx.

2. File provision > config/nginx_vhost file has web root as root /var/www/app.dev/. So make sure that you create a folder "app.dev" in a folder where you have your Vagrantfile. 

3. File "provision > config/nginx_vhost" has been set such that, it will work as htaccess of apache. In this I have added line "try_files $uri $uri/ /index.php?$args;". This line makes sure that, all the requests will got to index.php. So please make sure that your document root of nginx virtual host should be pointing to a folder which contains index.php. In this case, folder "app.dev" must contain index.php. Now if you want to make some changes, for example if you want web root to be "public" folder, then create 'public' folder inside "app.dev" and make changes in file /etc/nginx/sites-available/nginx_vhost. In this file update root to /var/www/app.dev/public/. That's it. And then of course you have to reload nginx (sudo service nginx reload) to allow these changes to reflect. 

5. After vagrant is up and running, make sure you add a line (192.168.33.21   app.dev) in hosts file in your desktop (host machine). This line will map url http://app.dev to IP address. This IP address is the one that is specified in Vagrantfile. Web server in vagrant box runs at this IP.

6. Note: If you notice install.sh file, it also installs php7.0-fpm. This is needed in nginx to run php. Note that php-7.0-fpm is a service. In future, you may need to restart (start / stop) this service after making some changes in configuration. While trying to restart this service, you may see a messages like  "unknown instance" or "service undefined". To fix this you may have to kill this service first and then you can try to start again.
Step 1: sudo pkill php7.0-fpm; 
Step 2: sudo service php7.0-fpm start
Source: http://stackoverflow.com/a/27268933 

7. Note: When you use nginx for php 5.5 /5.6 and when you use nginx for php 7.0; there is just the small difference in virtual host file. Check file "provision > config/nginx_vhost", locate line ````fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;````. This line defined path for .sock file and for php 5 this path is  "/var/run/php5-fpm.sock;" and for php 7 this path is "/var/run/php/php7.0-fpm.sock". This is what I noticed while I was installing PHP 7.

8. If you want, you find more php 7.0 extensions at below urls:
	8.1: http://www.tutorialspoint.com/articles/how-to-install-php-7-on-ubuntu-linux-14-04-lts
	8.2: http://tecadmin.net/install-php-7-on-ubuntu/#

9. Automatted installation of MySQL through shell script was challenging. Below resources helped:
	9.1 Video: https://www.youtube.com/watch?v=jMaocv9SVI0
	9.2 http://imsavva.com/silent-installation-mysql-5-7-on-ubuntu/
	9.3 Laracasts forum (this is unique. try it out.): https://laracasts.com/discuss/channels/laravel/laravel-compatibility-with-mysql-57?page=1 

#!/bin/bash
sudo yum install httpd wget unzip epel-release  mysql -y
sudo yum install https://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
sudo yum-config-manager --enable remi-php74
sudo yum install php -y
sudo yum install php-mysql -y
     wget https://wordpress.org/latest.tar.gz
sudo tar zxf latest.tar.gz -C /var/www/html/
sudo mv /var/www/html/wordpress/* /var/www/html/
sudo setenforce 0
sudo chown -R apache:apache /var/www/html/
sudo systemctl restart httpd
sudo systemctl enable httpd



#!/bin/bash
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install nginx
sudo touch /var/www/html/index.html
sudo chmod 777 /var/www/html/index.html
echo "Hello World" > /var/www/html/index.html

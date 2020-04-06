#!/bin/bash
sudo DEBIAN_FRONTEND=noninteractive apt-get -y git
sudo cd /var/www/html
sudo git init
sudo echo "gitacesso" > /home/ubuntu/.vargit
sudo git config --global credential.helper 'store --file /home/ubuntu/vargit' 
sudo git clone https://github.com/bfreits/devops/repo

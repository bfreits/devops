#!/bin/bash
sudo DEBIAN_FRONTEND=noninteractive apt-get -y s3fs
sudo echo "meulogin:minhasenha" > /home/ubuntu/.var-s3fs
sudo chmod 600 /home/ubuntu/.var-s3fs
sudo s3fs repoappcoletatwtiter /var/www/html -o passwd_file=/home/ubuntu/var-s3fs

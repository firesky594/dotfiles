#!/bin/bash
#start the php-fpm
#if started? reload it 
sudo /etc/init.d/php-fpm start
sudo /etc/init.d/php-fpm reload
#start nginx 
sudo /usr/sbin/nginx -c /etc/nginx/nginx.conf
sudo /usr/sbin/nginx -s reload

#!/bin/bash

DOMAIN="$1"

if [[ "$1" == "" ]]
then
	echo "usage: $0 <domain>"
	exit 1
fi

CONF_FILE="/etc/apache2/sites-available/$1"

echo '<VirtualHost *:80>' >>$CONF_FILE
echo "      ServerAdmin webmaster@$1" >>$CONF_FILE
echo "      ServerName $1" >>$CONF_FILE
echo "      ServerAlias www.$1" >>$CONF_FILE
echo "      DocumentRoot /srv/www/$1/public_html/" >>$CONF_FILE
echo "      ErrorLog /srv/www/$1/logs/error.log" >>$CONF_FILE
echo "      CustomLog /srv/www/$1/logs/access.log combined" >>$CONF_FILE
echo ' </VirtualHost>' >>$CONF_FILE
 
mkdir -p /srv/www/$1/public_html
mkdir /srv/www/$1/logs

a2ensite $1

/etc/init.d/apache2 restart

exit 0

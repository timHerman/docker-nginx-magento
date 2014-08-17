#!/bin/bash
set -e

echo >&2 "Initializing ssmtp"

export DEFAULT_MAILSERVER='mailserver'

if [[ "x"$MAILSERVER != "x" ]]; then
	export DEFAULT_MAILSERVER=$MAILSERVER	
fi

echo "root=noReply@${DEFAULT_MAILSERVER}" > /etc/ssmtp/ssmtp.conf


if [[ "x"$ROUTER_VIRTUAL_HOST = "x" ]]; then
	export ROUTER_VIRTUAL_HOST="localhost"
fi

echo "root=noReply@${ROUTER_VIRTUAL_HOST}" > /etc/ssmtp/ssmtp.conf
sed -i -e"s:server_name localhost:server_name ${ROUTER_VIRTUAL_HOST}:g" /etc/nginx/sites-available/default

echo "mailhub=${DEFAULT_MAILSERVER}" >> /etc/ssmtp/ssmtp.conf
echo "hostname=${DEFAULT_MAILSERVER}" >> /etc/ssmtp/ssmtp.conf
echo "FromLineOverride=YES" >> /etc/ssmtp/ssmtp.conf

sed -i -e"s:;sendmail_path =:sendmail_path = ssmtp -t:g" /etc/php5/fpm/php.ini

mkdir -p /var/www/htdocs
mkdir -p /var/www/logs
chown www-data.www-data /var/www/ -Rf
chmod 755 /var/www/htdocs -Rf

exec "$@"

#!/bin/sh

apk update
apk upgrade
apk add apache2 php82-apache2 php82
apk add mysql mysql-client php82-mysqli
apk add phpmyadmin

chown -R apache:apache /etc/phpmyadmin

/etc/init.d/mariadb setup

rc-service apache2 restart
rc-update add apache2 default
rc-service mariadb restart
rc-update add mariadb default

/usr/bin/mariadb-admin -u root password password

TMPDIR=`mktemp -d`
pushd $TMPDIR
wget -q https://github.com/datacharmer/test_db/releases/download/v1.0.7/test_db-1.0.7.tar.gz
tar xzf test_db-1.0.7.tar.gz
cd test_db
/usr/bin/mariadb -u root -ppassword < employees.sql
popd
rm -rf $TMPDIR

#fstrim /

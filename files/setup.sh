#!/bin/sh

apk update
apk upgrade
apk add apache2 php82-apache2 php82
apk add mariadb mariadb-client php82-mysqli
apk add phpmyadmin

chown -R apache:apache /etc/phpmyadmin
sed -i '/AllowNoPassword/s/false/true/g' /etc/phpmyadmin/config.inc.php
sed -i '/auth_type/s/cookie/config/g' /etc/phpmyadmin/config.inc.php
sed -i "/auth_type/a \$cfg['Servers'][\$i]['password'] = '';" /etc/phpmyadmin/config.inc.php
sed -i "/auth_type/a \$cfg['Servers'][\$i]['user'] = 'root';" /etc/phpmyadmin/config.inc.php

/etc/init.d/mariadb setup
sed -i '/skip-networking/s/.*skip-networking/#skip-networking/' /etc/my.cnf.d/mariadb-server.cnf

rc-service apache2 restart
rc-update add apache2 default
rc-service mariadb restart
rc-update add mariadb default

/usr/bin/mariadb-admin -u root password ''

TMPDIR=`mktemp -d`
pushd $TMPDIR
wget -q https://github.com/datacharmer/test_db/releases/download/v1.0.7/test_db-1.0.7.tar.gz
tar xzf test_db-1.0.7.tar.gz
cd test_db
/usr/bin/mariadb -u root < employees.sql
popd
rm -rf $TMPDIR


# For development: exit here
#exit


apk add util-linux
rm -rf /etc/ssh/ssh_host_*
rm -rf /var/cache/apk/*

install -d -m 700 /home/vagrant/.ssh
wget -qO /home/vagrant/.ssh/authorized_keys https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant.pub
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh


# zero the free disk space -- for better compression of the box file.
# NB prefer discard/trim (safer; faster) over creating a big zero filled file
#    (somewhat unsafe as it has to fill the entire disk, which might trigger
#    a disk (near) full alarm; slower; slightly better compression).
if [ "$(lsblk -no DISC-GRAN $(findmnt -no SOURCE /) | awk '{print $1}')" != '0B' ]; then
    fstrim -v /
else
    dd if=/dev/zero of=/EMPTY bs=1M || true && sync && rm -f /EMPTY && sync
fi


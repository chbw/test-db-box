# Datacharmer test_db in an Alpine Linux vagrant box

This project prepares a copy of [datacharmer's test_db](https://github.com/datacharmer/test_db) in a [MariaDB server](https://mariadb.org/) running on [Alpine Linux](https://www.alpinelinux.org/) in a [Vagrant Box](https://www.vagrantup.com/) running on [VirtualBox](https://www.virtualbox.org/). The database is accessible either directly (port forwarding to localhost:3306 with user root/empty password), or via [phpMyAdmin](https://www.phpmyadmin.net/) exposed at http://localhost:8080/phpmyadmin.

## Usage

Create an empty folder and from a shell in the folder run:
```
vagrant init chbw/test_db
vagrant up
```
and point your browser to http://localhost:8080/phpmyadmin or connect to the database server on localhost:3306 with user root/empty password.


## Box Development

In case you want to create the box from scratch yourself, run the following commands:
```
rm test_db.box
vagrant destroy -f
vagrant up
vagrant package --vagrantfile Vagrantfile-in-box --output test_db.box
vagrant box remove dev-test_db
vagrant box add --name dev-test_db ./test_db.box
```



# Datacharmer test_db in an Alpine Linux vagrant box

## Prepare

```
vagrant up
vagrant package --vagrantfile Vagrantfile-in-box
```


## Usage

Create an empty folder and from a shell in the folder run
```
vagrant init chbw/test_db
vagrant up
```
and point your browser to http://localhost:8080/phpmyadmin.


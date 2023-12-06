# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "generic/alpine318"
  config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  config.vm.provision "file", source: "files", destination: "$HOME/files"
  config.vm.provision "shell", inline: <<-SHELL
    /bin/bash /home/vagrant/files/setup.sh
  SHELL
end

# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "trusty64"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.network :private_network, ip: "192.168.33.21" 
  #below line is forward the 8080 port of host machine to port 80 of guest machine. But incase, if that is not available then vagrant will try to auto_correct it by using some other available port.
  config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
  config.vm.provision :shell, :path => "install.sh"
  config.vm.synced_folder ".", "/var/www", create: true, group: "www-data", owner: "www-data"
end

# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "trusty64"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

#####----NETWORKING STARTS-----####
#Public Network: https://www.vagrantup.com/docs/networking/public_network.html
#Private Newtwork: https://www.vagrantup.com/docs/networking/private_network.html
#Other Resource: https://github.com/Varying-Vagrant-Vagrants/VVV/issues/676

  #Option 1: Network identifier: Public network - RECOMMENDED
  #In Vagrant the idea is that while private networks should never allow the general public access to your machine, public networks can.
  #Generally you should use this when you want to access guest machine from any machine in LAN or from Internet
  #Notice that, vagrant will automatically assign IP to vagrant box. You can get this IP in two steps. Step 1: SSH into vagrant with command "vagrant ssh". Step 2: Run "ifconfig" on your SSH console and have a look at the eth1 device which should carry the VMs IP address.
  #Once you get the IP using command "ifconfig", then you can access web page at url http://<IP>
  #config.vm.network :public_network

  #Option 2: Network identifier: Public network with STATIC IP - RECOMMENDED
  #In Vagrant the idea is that while private networks should never allow the general public access to your machine, public networks can.
  # Warning! Do not choose an IP that overlaps with any other IP space on your system. This can cause the network to not be reachable.
  #Generally you should use this when you want to access guest machine from any machine in LAN or from Internet
  #Once vagrant has been set up then you can access web page in browser at url http://192.168.33.21
  #config.vm.network :public_network, ip: "192.168.33.21" 
  
  #Option 3: Network identifier: Privite network 
  #Vagrant private networks allow you to access your guest machine by some address that is not publicly accessible from the global internet. In general, this means your machine gets an address in the private address space.
  #Generally you should use this when you want to access guest machine yourself only
  #Notice that, vagrant will automatically assign IP to vagrant box. You can get this IP in two steps. Step 1: SSH into vagrant with command "vagrant ssh". Step 2: Run "ifconfig" on your SSH console and have a look at the eth1 device which should carry the VMs IP address.
  #Once you get the IP using command "ifconfig", then you can access web page at url http://<IP>
  #Resource: https://github.com/Varying-Vagrant-Vagrants/VVV/issues/676
  #config.vm.network :private_network


  #Option 4: Network identifier: Privite network with STATIC IP - RECOMMENDED
  #You can also specify a static IP address for the machine. This lets you access the Vagrant managed machine using a static, known IP. The Vagrantfile for a static IP looks as follows.
  # Warning! Do not choose an IP that overlaps with any other IP space on your system. This can cause the network to not be reachable.
  #Generally you should use this when you want to access guest machine yourself only
  #Once vagrant has been set up then you can access web page in browser at url http://192.168.33.21
  config.vm.network :private_network, ip: "192.168.33.21" 

  #Alternative you may want to share complete vagrant environment to someone over internet. Source: https://www.hashicorp.com/blog/feature-preview-vagrant-1-5-share.html
  #####----NETWORKING ENDS-----####

  #below line is forward the 8080 port of host machine to port 80 of guest machine. But incase, if that is not available then vagrant will try to auto_correct it by using some other available port.
  config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
  config.vm.provision :shell, :path => "install.sh"
  config.vm.synced_folder ".", "/var/www", create: true, group: "www-data", owner: "www-data"
end

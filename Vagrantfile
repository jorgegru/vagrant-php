Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/xenial64"
    config.vm.network :forwarded_port, guest: 80, host: 8080
    config.vm.network :private_network, ip: "192.168.33.10"
    config.vm.synced_folder "www/", "/var/www", owner: "www-data", group: "www-data", mount_options: ['dmode=777','fmode=777']
    config.vm.synced_folder "~", "/vagrant", owner: "vagrant", group: "vagrant"
    config.vm.provider "virtualbox" do |machine|
    	machine.memory = 3024
    	machine.cpus  = 2
    	machine.name = "ubuntu-server-php"
    	machine.gui = false
    end
    config.vm.provision :shell, path: "setup.sh"
end

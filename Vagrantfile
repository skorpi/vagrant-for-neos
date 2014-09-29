# Installation specific settings
$project_name = 'neos'
$ip_address = '192.168.38.17'

# box and chef versions
# keep them synced with the versions in the cheffile, if you want to avoid trouble due to chef version incompatibilities
$box = "hashicorp/precise64"
$box_version = "1.1.0"
$chef_version = "11.16.0"

# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	config.vm.box = $box
	config.vm.box_version = $box_version

	config.omnibus.chef_version = $chef_version

	config.ssh.forward_agent = true

	config.vm.network :private_network, ip: $ip_address
	config.vm.synced_folder "../../", "/var/www/typo3flow", create: "true", type: "nfs"

	config.vm.provision :chef_solo do |chef|
		chef.cookbooks_path = [ "cookbooks", "site-cookbooks" ]

		chef.log_level = :debug
	end

	config.vm.provider "virtualbox" do |v|
		v.name = $project_name
		v.customize ["modifyvm", :id, "--memory", "2048"]
	end
end
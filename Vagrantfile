# -*- mode: ruby -*-
# vi: set ft=ruby :

#################################
# Installation specific settings
################################
$project_name = 'neos'
$ip_address = '192.168.38.17'
$neos_rootpath = '/var/www/myneos'
$database_name = 'myneos'
$behat_database_name = 'testing_behat'
# This is the host of your live site. A vagrant and behat subdomain will be added automatically.
$hostname = 'myneos.com'
$site_package = 'TYPO3.NeosDemoTypo3Org'


#######################
# box and chef versions
# keep them synced with the versions in the cheffile, if you want to avoid trouble due to chef version incompatibilities
#######################
$box = "hashicorp/precise64"
$box_version = "1.1.0"
$chef_version = "11.16.0"

#######################
$vagrant_hostname = 'vagrant.' + $hostname


VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	config.vm.box = $box
	config.vm.box_version = $box_version

	config.omnibus.chef_version = $chef_version

	config.ssh.forward_agent = true

	config.vm.network :private_network, ip: $ip_address
	config.vm.synced_folder "../../", $neos_rootpath, create: "true", type: "nfs"

	# automatically manage /etc/hosts on hosts and guests
	config.vm.hostname = $vagrant_hostname
	config.hostmanager.enabled = true
	config.hostmanager.manage_host = true

	config.vm.provision :chef_solo do |chef|
		chef.cookbooks_path = [ "cookbooks", "site-cookbooks" ]
		# chef.log_level = :debug

		chef.add_recipe 'skorpi_typo3neos'
		chef.json = {
			:skorpi_typo3neos => {
				:rootpath => $neos_rootpath,
				:hostname => $vagrant_hostname,
				:database_name => $database_name,
				:behat_database_name => $behat_database_name,
				:site_package => $site_package
			},
			:mysql  => {
				:server_root_password   => "root",
				:server_repl_password   => "root",
				:server_debian_password => "root",
				:allow_remote_root      => true,
				:bind_address           => "127.0.0.1"
			},
		}
	end

	config.vm.provider "virtualbox" do |v|
		v.name = $project_name
		v.customize ["modifyvm", :id, "--memory", "2048"]
	end
end
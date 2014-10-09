# -*- mode: ruby -*-
# vi: set ft=ruby :

settings={
	####################################################################################
	# Installation specific settings you probably want to override for each installation
	####################################################################################
	'project_name' => 'neos',
	'ip_address' => '192.168.38.17',
	# This is the host of your live site. A vagrant and behat subdomain will be added automatically.
	'hostname' => 'myneos.com',
	'site_package' => 'TYPO3.NeosDemoTypo3Org',

	##########################################################################################
	# Installation specific settings you probably don't want to override for each installation
	##########################################################################################
	'use_nfs' => TRUE,
	'neos_rootpath' => '/var/www/myneos',
	'database_name' => 'myneos',
	'behat_database_name' => 'testing_behat',
}

##################################################
# Override settings based on environment variables
##################################################

puts '------ Overriding Settings with environment variables -------'
settings.each do |i, setting|
	if(ENV['VAGRANT_' + i])
		puts '------ Override "' + i + '" with "' + ENV['VAGRANT_' + i] + '" -----'
		settings[i] = ENV['VAGRANT_' + i]
	end
end


#######################
# box and chef versions
# keep them synced with the versions in the cheffile, if you want to avoid trouble due to chef version incompatibilities
#######################
$box = "ubuntu/trusty64"
$box_version = "14.04"
$chef_version = "11.16.0"

$vagrant_hostname = 'vagrant.' + settings['hostname']


VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	config.vm.box = $box
	config.vm.box_version = $box_version

	if Vagrant.has_plugin?("vagrant-cachier")
		# Configure cached packages to be shared between instances of the same base box.
		# More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
		config.cache.scope = :box
	end

	config.omnibus.chef_version = $chef_version

	config.ssh.forward_agent = true

	config.vm.network :private_network, ip: settings['ip_address']

	if settings['use_nfs'] === TRUE
		puts "----- Using nfs shared folders ---------"
		config.vm.synced_folder "../../", settings['neos_rootpath'], create: "true", type: "nfs"
	else
		config.vm.synced_folder "../../", settings['neos_rootpath'], create: "true", type: "rsync", user: "vagrant", group: "www-data", rsync__exclude: ["Web/", ".git"]
	end

	# automatically manage /etc/hosts on hosts and guests
	config.vm.hostname = $vagrant_hostname
	config.hostmanager.enabled = true
	config.hostmanager.manage_host = true
	config.hostmanager.aliases = 'behat.' + $vagrant_hostname

	config.vm.provision :chef_solo do |chef|
		chef.cookbooks_path = [ "cookbooks", "site-cookbooks" ]
		# chef.log_level = :debug

		chef.add_recipe 'skorpi_typo3neos'
		chef.json = {
			:skorpi_typo3neos => {
				:rootpath => settings['neos_rootpath'],
				:hostname => $vagrant_hostname,
				:database_name => settings['database_name'],
				:behat_database_name => settings['behat_database_name'],
				:site_package => settings['site_package'],
				:use_nfs => settings['use_nfs']
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
		v.name = settings['project_name']
		v.customize ["modifyvm", :id, "--memory", "2048"]
	end
end
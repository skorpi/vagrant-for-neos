#
# Cookbook:: skorpi_typo3neos
# Recipe:: basic.rb
#
# Copyright 2014, Irene Höppner
#
# Install neos

# Install via composer only if nfs is used. For rsync it had to be done on the host machine.
if node['skorpi_typo3neos']['use_nfs'] === TRUE
	execute "composer install --quiet" do
		cwd node['skorpi_typo3neos']['rootpath']
	end
end

directory "#{node['skorpi_typo3neos']['rootpath']}/Configuration/Development/" do
  action :create
end

template "#{node['skorpi_typo3neos']['rootpath']}/Configuration/Development/Settings.yaml" do
  source "Development.Settings.yaml.erb"
  variables(
  	:database_name => node['skorpi_typo3neos']['database_name'],
  	:database_password => node['mysql']['server_root_password']
  )
  action :create
end

if node['skorpi_typo3neos']['use_nfs'] === TRUE
	execute "set some heavy filepermissions for nfs as setfilepermissions doesn't work" do
		command "chgrp -R www-data . && chmod -R 2777 ."
		cwd node['skorpi_typo3neos']['rootpath']
	end
else
	execute "./flow flow:core:setfilepermissions vagrant www-data www-data" do
		cwd node['skorpi_typo3neos']['rootpath']
	end
end

execute "./flow flow:cache:flush" do
	cwd node['skorpi_typo3neos']['rootpath']
end

execute "./flow flow:cache:warmup" do
	cwd node['skorpi_typo3neos']['rootpath']
end

execute "./flow doctrine:migrate" do
	cwd node['skorpi_typo3neos']['rootpath']
end

execute "./flow site:import --package-key #{node['skorpi_typo3neos']['site_package']}" do
	cwd node['skorpi_typo3neos']['rootpath']
end

execute "create vagrant admin user" do
	command "./flow user:create --roles Administrator --username vagrant --password vagrant --first-name Vagrant --last-name Vagrant"
	cwd node['skorpi_typo3neos']['rootpath']
	not_if "#{node['skorpi_typo3neos']['rootpath']}/flow user:show --username vagrant"
end

execute "create vagrant editor user" do
	command "./flow user:create --roles Editor --username vagranteditor --password vagrant --first-name Vagrant --last-name Editor"
	cwd node['skorpi_typo3neos']['rootpath']
	not_if "#{node['skorpi_typo3neos']['rootpath']}/flow user:show --username vagranteditor"
end
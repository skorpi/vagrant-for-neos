#
# Cookbook:: skorpi_typo3neos
# Recipe:: basic.rb
#
# Copyright 2014, Irene Höppner
#
# Install neos

execute "composer install --quiet" do
	cwd node['skorpi_typo3neos']['rootpath']
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

execute "set some heavy filepermissions for nfs" do
	command "chgrp -R www-data . && chmod -R 2777 ."
	cwd node['skorpi_typo3neos']['rootpath']
end

execute "./flow doctrine:migrate" do
	cwd node['skorpi_typo3neos']['rootpath']
end

execute "./flow site:import --package-key #{node['skorpi_typo3neos']['site_package']}" do
	cwd node['skorpi_typo3neos']['rootpath']
end
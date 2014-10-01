#
# Cookbook:: skorpi_typo3neos
# Recipe:: behat.rb
#
# Copyright 2013, Irene Höppner
#
# Version 0.1
#

execute "install behat" do
	command "composer install"
	cwd "#{node['skorpi_typo3neos']['rootpath']}/Build/Behat/"
end

web_app "behat.#{node['skorpi_typo3neos']['hostname']}" do
	template "vhost.conf.erb"
	server_name "behat.#{node['skorpi_typo3neos']['hostname']}"
	docroot "#{node['skorpi_typo3neos']['rootpath']}/Web"
	directory node['skorpi_typo3neos']['rootpath']
	context "Development/Behat"
end

directory "#{node['skorpi_typo3neos']['rootpath']}/Configuration/Development/Behat" do
	action :create
end

template "#{node['skorpi_typo3neos']['rootpath']}/Configuration/Development/Behat/Settings.yaml" do
	source "Development.Behat.Settings.yaml.erb"
	variables(
		:database_name => node['skorpi_typo3neos']['behat_database_name'],
	)
	action :create
end

directory "#{node['skorpi_typo3neos']['rootpath']}/Configuration/Testing/Behat" do
	action :create
end

template "#{node['skorpi_typo3neos']['rootpath']}/Configuration/Testing/Behat/Settings.yaml" do
	source "Testing.Behat.Settings.yaml.erb"
	variables(
		:database_name => node['skorpi_typo3neos']['behat_database_name'],
		:database_password => node['mysql']['server_root_password']

	)
	action :create
end

execute "create behat database" do
	command "mysql -uroot -proot -e 'create database if not exists #{node['skorpi_typo3neos']['behat_database_name']} CHARACTER SET utf8;'"
end
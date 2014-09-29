#
# Cookbook:: skorpi_typo3neos
# Recipe:: basic.rb
#
# Copyright 2014, Irene Höppner
#
# Add the vhost

web_app "#{node['skorpi_typo3neos']['hostname']}" do
	template "vhost.conf.erb"
	server_name node['skorpi_typo3neos']['hostname']
	docroot "#{node['skorpi_typo3neos']['rootpath']}/Web"
	directory node['skorpi_typo3neos']['rootpath']
	context "Development"
end
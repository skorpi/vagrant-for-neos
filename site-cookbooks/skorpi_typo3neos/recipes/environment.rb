#
# Cookbook:: skorpi_typo3neos
# Recipe:: env.rb
#
# Copyright 2013, Irene Höppner
#
# Version 0.1
#
# creates includable script files that set some environment variables
#
#

directory "/vagrant/Scripts/Environment" do
	action :create
end

template "/vagrant/Scripts/Environment/basic" do
	source "environment.basic.erb"
	variables(
		:hostname => node['skorpi_typo3neos']['hostname'],
		:rootpath => node['skorpi_typo3neos']['rootpath'],
	)
	mode '0755'
	action :create
end

template "/vagrant/Scripts/Environment/xdebug" do
	source "environment.xdebug.erb"
	variables(
		:hostname => node['skorpi_typo3neos']['hostname'],
	)
	mode '0755'
	action :create
end
#
# Cookbook:: skorpi_typo3neos
# Recipe:: database.rb
#
# Copyright 2014, Irene Höppner
#
# Add mysql and database

include_recipe 'mysql::server'

execute "create database" do
	command "mysql -uroot -p#{node['mysql']['server_root_password']} -e 'create database if not exists #{node['skorpi_typo3neos']['database_name']} CHARACTER SET utf8;'"
end
#
# Cookbook:: skorpi_typo3neos
# Recipe:: default.rb
#
# Copyright 2014, Irene Höppner
#
# default recipe


include_recipe 'apache2'

['php5', 'rewrite', 'headers'].each do |mod|
	include_recipe "apache2::mod_#{mod}"
end

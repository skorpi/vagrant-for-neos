#
# Cookbook:: skorpi_typo3neos
# Recipe:: php.rb
#
# Copyright 2014, Irene Höppner
#
# Add php and configuration

include_recipe "php"

packages=[
	"php5-mysql",
]

case node[:platform]
	when "debian","ubuntu"
		packages.each do |pkg|
			package pkg do
			action :upgrade
		end
	end
end

cookbook_file "/etc/php5/conf.d/php_dateTimeZone.ini" do
	source "php_dateTimeZone.ini"
	mode 0655
end

cookbook_file "/etc/php5/conf.d/php_maxValues.ini" do
	source "php_maxValues.ini"
	mode 0655
end

execute "reload apache" do
	command "/etc/init.d/apache2 reload"
end
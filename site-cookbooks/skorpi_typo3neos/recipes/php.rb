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
	"php5-curl",
	"php5-xdebug"
]

case node[:platform]
	when "debian","ubuntu"
		packages.each do |pkg|
			package pkg do
			action :upgrade
		end
	end
end

ini_files=[
	"xdebug_remote",
	"dateTimeZone",
	"maxValues"
]

ini_files.each do |ini_file|
	cookbook_file "/etc/php5/mods-available/#{ini_file}.ini" do
		source "#{ini_file}.ini"
		mode 644
	end
	execute "enable php-configuration" do
		command "php5enmod #{ini_file}"
	end
end

# xdebug-autostart-configuration is not enabled by default
cookbook_file "/etc/php5/mods-available/xdebug_autostart.ini" do
	source "xdebug_autostart.ini"
	mode 644
end

execute "reload apache" do
	command "/etc/init.d/apache2 reload"
end
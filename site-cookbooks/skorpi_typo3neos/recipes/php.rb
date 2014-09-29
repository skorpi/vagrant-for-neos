#
# Cookbook:: skorpi_typo3neos
# Recipe:: php.rb
#
# Copyright 2014, Irene Höppner
#
# Add php and configuration

include_recipe "php"

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
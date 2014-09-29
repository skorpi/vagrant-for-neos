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


# execute "install TYPO3 Neos" do
# 	command "composer install --quiet"
# 	cwd "/var/www/typo3flow"
# end
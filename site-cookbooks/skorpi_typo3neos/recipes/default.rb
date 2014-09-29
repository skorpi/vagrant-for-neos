#
# Cookbook:: skorpi_typo3neos
# Recipe:: default.rb
#
# Copyright 2014, Irene Höppner
#
# default recipe


include_recipe "apt"
include_recipe "git"
include_recipe "composer"
include_recipe "skorpi_typo3neos::apache2"

include_recipe 'skorpi_typo3neos::neos'
include_recipe 'skorpi_typo3neos::vhost'

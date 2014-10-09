========================================
Yet Another Vagrant Setup for TYPO3 Neos
========================================

Introduction
============

This is a Vagrant configuration you can simply add to your existing TYPO3 Neos distribution.

It takes care of the behat installation as well and provides some scripts to run or even debug the Neos behat tests.

This has been tested on Mac and is optimized for usage with Phpstorm (xdebug configuration). Feel free to try other setups and send me some feedback.

Requirements
============

These are the vagrant and VirtualBox versions this setup has been tested with. It might work with more current versions as well.

* Virtual Box *Version 4.3.14*: https://www.virtualbox.org/wiki/Download_Old_Builds_4_3 or https://www.virtualbox.org/wiki/Downloads
* Vagrant *Version 1.6.5*: http://www.vagrantup.com/download-archive/v1.6.5.html

The following vagrant plugins are used:

* librarian
* vagrant-vbguest
* vagrant-librarian-chef
* vagrant-hostmanager
* vagrant-omnibus

Use the command ``vagrant install <pluginname>`` to install the plugins

You can use the command ``vagrant plugin list`` to check if they are installed already.

You will also need a github account with your default ssh key configured. Otherwise you'll probably get an error during the installation of the chef recipies.

To use ssh key forwarding run the command ``ssh-add -K`` (Mac).

Usage
=====

Get the Neos Distribution
-------------------------

If you have a Neos distribution already you can skip this step.

Clone the neos distribution from https://git.typo3.org/Neos/Distributions/Base.git into a folder of your choice.

Add Vagrant Configuration
-------------------------

You can simply clone this repository into the ``Build/Vagrant``folder of your Distribution, go into this folder and run ``vagrant up``.

That will install neos with the default settings (see below).

If you want to override f.e. the hostname or the name of the vagrant box you might want to add a script to the root folder of your application that sets some environment variables.

Example vagrant.sh Script::

  #! /bin/bash
  
  if [ ! -d Build/Vagrant ]; then
  	echo clone vagrant setup
  	git clone https://github.com/skorpi/vagrant-for-neos.git Build/Vagrant
  fi
  
  export VAGRANT_project_name="myproject"
  export VAGRANT_ip_address="192.168.38.19"
  # Add your live hostname here. The subdomain (vagrant.) will be added automatically
  export VAGRANT_hostname="the.host.tld"
  
  cd Build/Vagrant
  
  vagrant $1 $2 $3

Start the installation with the command::

  $./vagrant.sh up

Hosts File
----------

Usually the hostamanager will take care of your hosts file. If that doesn't work, add the following line to your hosts file::

  192.168.38.17 vagrant.myneos.com behat.vagrant.myneos.com
  
Of course you might have to change the ip-address and host accordingly.

Folder Syncing / Windows
========================

This setup uses synced_folder of type "nfs" by default. Thus it won't work on windows.

There are some configurations for type "rsync" - which would work on windows - but they are not tested. If you want to give it a try I'm looking forward to your feedback.
You need to set the following environment variable before your run ``vagrant up``::

  export VAGRANT_use_nfs=FALSE

See http://docs.vagrantup.com/v2/synced-folders/rsync.html for windows requirements.

Using rsync as option you have to run ``composer install`` on your host machine before you run ``vagrant up``!

Rsync is syncing in one direction only (Host to Guest). Flow is creating some files (f.e. database migrations, cached code, kickstarted code).
With nfs I have this files in my Phpstorm on the fly. That's why I like nfs more and it is the default option.
You will have to type your hosts logon password using nfs. To avoid this see http://docs.vagrantup.com/v2/synced-folders/nfs.html.  


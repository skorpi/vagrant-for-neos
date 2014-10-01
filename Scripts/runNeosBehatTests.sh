#! /bin/bash

source Environment/basic

export BEHAT_PARAMS="extensions[Behat\MinkExtension\Extension][base_url]=http://behat.$VAGRANT_HOSTNAME/"

cd $VAGRANT_NEOS_ROOTPATH
bin/behat -c Packages/Application/TYPO3.Neos/Tests/Behavior/behat.yml.dist $1 $2 $3 $4 $5 $6
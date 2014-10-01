#! /bin/bash

SELENIUM_MINOR_VERSION="2.43"
SELENIUM_PATCH_VERSION="2.43.1"

PORT="2222"

# Dieses Script von der lokalen Maschine aus ausführen.
# Es baut einen Reverse-SSH-Tunnel auf, der die Selenium-Anfragen auf der Vagrant-Maschine an den Host weiter
# leitet, auf dem dann die Browser geöffnet werden.
# Dazu  muss der Selenium-Standalone-Server gestartet sein mit "java -jar selenium-server-standalone-xxx.jar"

# Download selenium-server if not exists
if [ ! -e selenium-server-standalone-$SELENIUM_PATCH_VERSION.jar ]
then
	curl -o selenium-server-standalone-$SELENIUM_PATCH_VERSION.jar http://selenium-release.storage.googleapis.com/$SELENIUM_MINOR_VERSION/selenium-server-standalone-$SELENIUM_PATCH_VERSION.jar
fi

# Passwort: vagrant
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -fN -R 4444:localhost:4444 -p $PORT vagrant@localhost

# start selenium server listener
java -jar selenium-server-standalone-$SELENIUM_PATCH_VERSION.jar
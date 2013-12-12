#!/bin/sh

LATEST_VAGRANT_32="https://dl.bintray.com/mitchellh/vagrant/vagrant_1.4.0_i686.deb"
LATEST_VAGRANT_64="https://dl.bintray.com/mitchellh/vagrant/vagrant_1.4.0_x86_64.deb"

## Vagrant
sudo apt-get install -y wget dpkg virtualbox
URL="$LATEST_VAGRANT_64"
ARCHITECTURE=`uname -m`
if [ "$ARCHITECTURE" != "x86_64" ]; then
	URL=$LATEST_VAGRANT_32
fi
FILE="vagrant.deb"; 
wget "$URL" -O $FILE && sudo dpkg -i $FILE; 
rm $FILE

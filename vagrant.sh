#!/bin/sh

LATEST_VAGRANT_32="http://files.vagrantup.com/packages/a40522f5fabccb9ddabad03d836e120ff5d14093/vagrant_1.3.5_i686.deb"
LATEST_VAGRANT_64="http://files.vagrantup.com/packages/a40522f5fabccb9ddabad03d836e120ff5d14093/vagrant_1.3.5_x86_64.deb"

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

#!/bin/sh

# this sucks but the only way i found that i could execute something 
# as the user and something as root
sudo echo essential things 
sudo apt-get install -qq -y build-essential checkinstall curl wget git

echo Instant Messaging
sudo apt-get install -qq -y irssi

echo java
sudo apt-get install -qq -y openjdk-7* icedtea-plugin

echo all that crappy non open source stuff
sudo apt-get install -qq -y ubuntu-restricted-extras

echo codecs
sudo apt-get install -qq -y libxvidcore4 gstreamer0.10-plugins-base gstreamer0.10-plugins-good gstreamer0.10-plugins-ugly gstreamer0.10-plugins-bad gstreamer0.10-plugins-bad-multiverse gstreamer0.10-ffmpeg gstreamer0.10-alsa gstreamer0.10-fluendo-mp3

echo various
sudo apt-get install -qq -y keepassx firefox

###Email Setup

## IMAP
# host: imap.pondati.net
# port: 143
# security: STARTTLS
# auth-method: normal password
# user: <user>@pondati.net
# pass: <pass>

## SMAP
# host: smtp.pondati.net
# port: 587
# security: STARTTLS
# auth-method: normal password
# user: <user>@pondati.net
# pass: <pass>
#!/bin/sh

echo essential things
apt-get install -qq -y build-essential checkinstall curl wget git

echo Instant Messaging
apt-get install -qq -y irssi

echo java
apt-get install -qq -y openjdk-7* icedtea-plugin

echo all that crappy non open source stuff
apt-get install -qq -y ubuntu-restricted-extras

echo codecs
apt-get install -qq -y libxvidcore4 gstreamer0.10-plugins-base gstreamer0.10-plugins-good gstreamer0.10-plugins-ugly gstreamer0.10-plugins-bad gstreamer0.10-plugins-bad-multiverse gstreamer0.10-ffmpeg gstreamer0.10-alsa gstreamer0.10-fluendo-mp3

echo various
apt-get install -qq -y keepassx firefox

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

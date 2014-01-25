#!/bin/sh

sudo add-apt-repository -y ppa:rquillo/ansible
sudo apt-get update
sudo apt-get install -qq -y ansible

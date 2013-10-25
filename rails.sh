#!/bin/sh
sudo apt-get -y install gawk libgdbm-dev pkg-config libffi-dev build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf libc6-dev libncurses5-dev automake libtool bison subversion python postgresql postgresql-contrib libpq-dev nodejs
curl -L https://get.rvm.io | bash -s stable --rails
source ~/.rvm/scripts/rvm

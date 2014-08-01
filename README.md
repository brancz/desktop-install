Overview
========

This script helps you to install and upgrade various software on an ubuntu based
system and lately also partly OS X. (see below for current OS X support)

This includes:

* Essential software (firefox, curl, git, vpn, java, musicplayer, etc)

* [Ruby + Ruby on Rails via rvm](http://rvm.io/)

* [Ansible](http://www.ansible.com/)

* [Vagrant](http://www.vagrantup.com/)

* [My dotfiles](https://github.com/FlopsKa/dotfiles)

* [fixubuntu](https://github.com/micahflee/fixubuntu)

* [heroku-toolbelt](https://toolbelt.heroku.com/debian)

* [nodejs, npm, karma](http://nodejs.org/)

* [chef](https://wiki.opscode.com/display/chef/Home)

Install instructions
--------------------

#### Ubuntu

To run the script just run:

	wget -qO- https://raw.github.com/flower-pot/desktop-install/master/install.sh | sudo bash

To use the script in silent mode use this command. (silent mode installs everything)

	wget -qO- https://raw.github.com/flower-pot/desktop-install/master/install.sh | sudo bash -s -- --silent

To only install vim, zsh and dotfiles in silent mode use the following command

	wget -qO- https://raw.github.com/flower-pot/desktop-install/master/install.sh | sudo bash -s -- --silent --dotfiles

#### OS X

Right now I have only converted the zsh, vim, dotfiles part to osx. Here's how you install it:

	curl https://raw.githubusercontent.com/flower-pot/desktop-install/master/osx.sh | sudo bash -s



That's it, have fun! :)

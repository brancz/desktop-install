Overview
========

This script helps you to install or upgrade various software on a debian based
system, preferably ubuntu.

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

To run the script just run:

	wget -qO- https://raw.github.com/flower-pot/desktop-install/master/install.sh | sudo bash

To use the script in silent mode use this command. (silent mode installs everything)

	wget -qO- https://raw.github.com/flower-pot/desktop-install/master/install.sh | sudo bash -s -- --silent

That's it, have fun! :)

#!/bin/bash

bold=`tput bold`
normal=`tput sgr0`

function echo_headline {
  size=${#1}
  v=$(printf "%-${size}s" "=")
  echo "${v// /=}"
  echo "${bold}$1${normal}"
  echo "${v// /=}"
}

function echo_bold {
  echo "${bold}$1${normal}"
}

function install_essentials() {
  echo_headline "INSTALLING ESSENTIALS"

  echo_bold "update apt cache"
  apt-get update

  echo_bold "install basic stuff"
  apt-get install -q -y build-essential checkinstall curl git xclip tree gparted screen

  echo_bold "install instant messanger"
  apt-get install -q -y irssi

  echo_bold "install webbrowsers"
  apt-get install -q -y firefox chromium-browser

  echo_bold "install java"
  apt-get install -q -y openjdk-7* icedtea-plugin

  echo_bold "install codecs"
  apt-get install -q -y libxvidcore4 gstreamer0.10-plugins-base gstreamer0.10-plugins-good gstreamer0.10-plugins-ugly gstreamer0.10-plugins-bad gstreamer0.10-plugins-bad-multiverse gstreamer0.10-ffmpeg gstreamer0.10-alsa gstreamer0.10-fluendo-mp3

  echo_bold "install musicplayer"
  apt-get install -q -y gmusicbrowser

  echo_bold "install desktop recording tool"
  apt-get install -q -y gtk-recordmydesktop

  echo_bold "install password depot: keepassx"
  apt-get install -q -y keepassx
}

function install_ruby() {
  echo_headline "INSTALLING RUBY"

  apt-get -q -y install curl
  su -l "${SUDO_USER}" -c "gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3"
  curl -L https://get.rvm.io | sudo -u "${SUDO_USER}" -H bash -s stable --ruby
  su -l "${SUDO_USER}" -c "source \"${homedir}/.rvm/scripts/rvm\""
}

function install_docker() {
  echo_headline "INSTALLING DOCKER AND DOCKER-COMPOSE"

  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
  sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
  apt-get update
  apt-get install -q -y lxc-docker
  curl -L https://github.com/docker/compose/releases/download/1.1.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
}

function install_vagrant() {
  echo_headline "INSTALLING VAGRANT"

  LATEST_VAGRANT_32="https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2_i686.deb"
  LATEST_VAGRANT_64="https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2_x86_64.deb"

  ## Vagrant
  apt-get install -q -y dpkg virtualbox
  URL="$LATEST_VAGRANT_64"
  ARCHITECTURE=`uname -m`
  if [ "$ARCHITECTURE" != "x86_64" ]; then
    URL=$LATEST_VAGRANT_32
  fi
  FILE="/tmp/vagrant.deb"; 
  wget "$URL" -O $FILE && dpkg -i $FILE; 
  rm $FILE
}

function install_salt() {
  echo_headline "INSTALLING SALT"

  echo_bold "update apt cache"
  apt-get update
  apt-get install -q -y curl

  curl -L https://bootstrap.saltstack.com | sudo sh
}

function install_dotfiles() {
  echo_headline "INSTALLING VIM, ZSH, AND DOTFILES"

  echo_bold "update apt cache"
  apt-get update

  apt-get install -q -y zsh ruby1.9.1 ruby1.9.1-dev git-core curl vim-nox

  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sudo -u "${SUDO_USER}" -H sh
  curl -L https://raw.github.com/maksimr/dotfiles/master/gnome-terminal-themes/molokai.sh | sudo -u "${SUDO_USER}" -H sh

  rm "${homedir}/.zshrc"
  sudo -u "${SUDO_USER}" -H git clone https://github.com/flower-pot/dotfiles.git "${homedir}/dotfiles"
  ln -s "${homedir}/dotfiles/zsh/flower-pot.zsh-theme" "${homedir}/.oh-my-zsh/themes/flower-pot.zsh-theme"
  ln -s "${homedir}/dotfiles/zsh/zshrc" "${homedir}/.zshrc"

  (
  cd ${homedir}/dotfiles
  git submodule init
  git submodule update

  ln -s "${homedir}/dotfiles/vim/.vim" "${homedir}/.vim"
  ln -s "${homedir}/dotfiles/vim/.vimrc" "${homedir}/.vimrc"
  )

  (
  cd ${homedir}/.vim/bundle/command-t/ruby/command-t/
  sudo ruby extconf.rb
  sudo make
  )

  chsh $SUDO_USER -s /bin/zsh
}

function install_fixubuntu() {
  echo_headline "FIXING UBUNTU"

  wget -qO- https://raw2.github.com/micahflee/fixubuntu/master/fixubuntu.sh | sudo -u "${SUDO_USER}" -H sh
}

function install_heroku_toolbelt() {
  echo_headline "INSTALLING HEROKU-TOOLBELT"

  wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
}

function install_nodejs() {
  echo_headline "INSTALLING NODE.JS"

  curl -sL https://deb.nodesource.com/setup | sudo bash -
  sudo apt-get -q -y install nodejs
}

function install_selected() {

  selected_items=$1

  if [[ ${selected_items[@]} =~ "essentials" ]]; then
    install_essentials
  fi
  
  if [[ ${selected_items[@]} =~ "ruby" ]]; then
    install_ruby
  fi
  
  if [[ ${selected_items[@]} =~ "docker" ]]; then
    install_docker
  fi
  
  if [[ ${selected_items[@]} =~ "vagrant" ]]; then
    install_vagrant
  fi
  
  if [[ ${selected_items[@]} =~ "salt" ]]; then
    install_salt
  fi

  if [[ ${selected_items[@]} =~ "dotfiles" ]]; then
    install_dotfiles
  fi

  if [[ ${selected_items[@]} =~ "fixubuntu" ]]; then
    install_fixubuntu
  fi

  if [[ ${selected_items[@]} =~ "heroku-toolbelt" ]]; then
    install_heroku_toolbelt
  fi

  if [[ ${selected_items[@]} =~ "nodejs" ]]; then
    install_nodejs
  fi
}

function usage {
  echo "usage: install.sh [[-s | --silent] [--dotfiles] | [-h | --help]]"
}

# Start of program

if [[ $USER != "root" ]]; then
  echo "You need to run this as root."
  exit 1
fi

homedir=`eval echo ~$SUDO_USER`

silent=
while [ "$1" != "" ]; do
  case $1 in
    ( -s | --silent )       silent=1
                            ;;
    ( --dotfiles )          dotfiles=1
                            ;;
    ( -h | --help )         usage
                            exit
  esac
  shift
done

if [ "$silent" = "1" ]; then
  echo_headline "Silent Mode"
  if [ "$dotfiles" = "1" ]; then
    install_dotfiles
  else
    install_selected "essentials ruby vagrant docker salt dotfiles fixubuntu heroku-toolbelt nodejs"
  fi
else
  selected_items=$(whiptail --separate-output --checklist "What do you want to install?" 15 60 9 \
  essentials "Essentials" on \
  ruby "Ruby via rvm" on \
  vagrant "Vagrant" on \
  docker "Docker & Docker-Compose" on \
  dotfiles "Vim, zsh, dotfiles" on \
  fixubuntu "fix ubuntu" on \
  heroku-toolbelt "heroku toolbelt" on \
  nodejs "Node.js & npm" on 3>&1 1>&2 2>&3)

  exitstatus=$?
  if [ $exitstatus = 0 ]; then
    install_selected "$selected_items"
  else
    echo "Cancelled."
  fi
fi

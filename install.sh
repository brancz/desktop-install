#!/bin/bash

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

function install_selected() {

  selected_items=$1

  if [[ ${selected_items[@]} =~ "essentials" ]]
  then
    echo_headline "INSTALLING ESSENTIALS"

    echo_bold "update apt cache"
    apt-get update

    echo_bold "install basic stuff"
    apt-get install -q -y build-essential checkinstall curl wget git xclip tree gparted nfs-common portmap pavucontrol screen

    echo_bold "install network manager vpn plugins"
    apt-get install -q -y network-manager-openvpn network-manager-pptp network-manager-vpnc

    echo_bold "install instant messanger"
    apt-get install -q -y irssi

    echo_bold "make sure firefox is installed"
    apt-get install -q -y firefox

    echo_bold "install java"
    apt-get install -q -y openjdk-7* icedtea-plugin

    echo_bold "install flash, ms fonts, etc"
    apt-get install -q -y ubuntu-restricted-extras

    echo_bold "install codecs"
    apt-get install -q -y libxvidcore4 gstreamer0.10-plugins-base gstreamer0.10-plugins-good gstreamer0.10-plugins-ugly gstreamer0.10-plugins-bad gstreamer0.10-plugins-bad-multiverse gstreamer0.10-ffmpeg gstreamer0.10-alsa gstreamer0.10-fluendo-mp3

    echo_bold "install musicplayer"
    apt-get install -q -y gmusicbrowser

    echo_bold "install desktop recording tool"
    apt-get install -q -y gtk-recordmydesktop

    echo_bold "install password depot: keepassx"
    apt-get install -q -y keepassx
  fi
  
  if [[ ${selected_items[@]} =~ "rails" ]]
  then
    echo_headline "INSTALLING RAILS"

    apt-get -y install gawk libgdbm-dev pkg-config libffi-dev build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf libc6-dev libncurses5-dev automake libtool bison subversion python postgresql postgresql-contrib libpq-dev redis-server
    curl -L https://get.rvm.io | sudo -u "${SUDO_USER}" -H bash -s stable --rails
    su -l "${SUDO_USER}" -c "source \"${homedir}/.rvm/scripts/rvm\""
  fi
  
  if [[ ${selected_items[@]} =~ "ansible" ]]
  then
    echo_headline "INSTALLING ANSIBLE"

    echo_bold "add required repository"
    add-apt-repository -y ppa:rquillo/ansible

    echo_bold "update apt cache"
    apt-get update  -q -y

    echo_bold "install ansible"
    apt-get install -q -y ansible
  fi
  
  if [[ ${selected_items[@]} =~ "vagrant" ]]
  then
    echo_headline "INSTALLING VAGRANT"

    LATEST_VAGRANT_32="https://dl.bintray.com/mitchellh/vagrant/vagrant_1.5.0_i686.deb"
    LATEST_VAGRANT_64="https://dl.bintray.com/mitchellh/vagrant/vagrant_1.5.0_x86_64.deb"

    ## Vagrant
    apt-get install -y wget dpkg virtualbox
    URL="$LATEST_VAGRANT_64"
    ARCHITECTURE=`uname -m`
    if [ "$ARCHITECTURE" != "x86_64" ]; then
      URL=$LATEST_VAGRANT_32
    fi
    FILE="/tmp/vagrant.deb"; 
    wget "$URL" -O $FILE && dpkg -i $FILE; 
    rm $FILE
  fi

  if [[ ${selected_items[@]} =~ "dotfiles" ]]
  then
    echo_headline "INSTALLING VIM, ZSH, AND DOTFILES"

    echo_bold "update apt cache"
    apt-get update

    apt-get install -q -y stow zsh libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev mercurial ruby1.9.1 ruby1.9.1-dev git build-essential curl

    hg clone https://vim.googlecode.com/hg/ /tmp/vim
    (cd /tmp/vim/src; ./configure --with-features=huge --enable-gui=gnome2 --enable-rubyinterp)
    make -C /tmp/vim/src
    make -C /tmp/vim/src install
    rm -rf /tmp/vim

    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sudo -u "${SUDO_USER}" -H sh
    curl -L https://raw.github.com/maksimr/dotfiles/master/gnome-terminal-themes/molokai.sh | sudo -u "${SUDO_USER}" -H sh

    rm "${homedir}/.zshrc"
    sudo -u "${SUDO_USER}" -H git clone https://github.com/flower-pot/dotfiles.git "${homedir}/dotfiles"
    ln -s "${homedir}/dotfiles/zsh/flopska.zsh-theme" "${homedir}/.oh-my-zsh/themes/flopska.zsh-theme"
    ln -s "${homedir}/dotfiles/zsh/zshrc" "${homedir}/.zshrc"

    (
    cd ${homedir}/dotfiles
    git submodule init
    git submodule update

    stow --target=$homedir vim
    )

    (
    cd ${homedir}/.vim/bundle/command-t/ruby/command-t/
    sudo ruby extconf.rb
    sudo make
    )

    chsh $SUDO_USER -s /bin/zsh
  fi

  if [[ ${selected_items[@]} =~ "fixubuntu" ]]
  then
    echo_headline "FIXING UBUNTU"

    wget -qO- https://raw2.github.com/micahflee/fixubuntu/master/fixubuntu.sh | sudo -u "${SUDO_USER}" -H sh
  fi

  if [[ ${selected_items[@]} =~ "heroku-toolbelt" ]]
  then
    echo_headline "INSTALLING HEROKU-TOOLBELT"

    wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
  fi

  if [[ ${selected_items[@]} =~ "nodejs" ]]
  then
    echo_headline "INSTALLING NODE.JS"

    apt-get install python-software-properties
    apt-add-repository -y ppa:chris-lea/node.js
    apt-get update -q -y
    apt-get install nodejs -q -y
    apt-get install npm -q -y
    npm install -g karma
    ln -s /usr/bin/nodejs /usr/bin/node &>/dev/null
  fi
}

function usage {
    echo "usage: install script [[-s] | [-h]]"
}

bold=`tput bold`
normal=`tput sgr0`

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
        ( -h | --help )         usage
                                exit
    esac
    shift
done

if [ "$silent" = "1" ]; then
  echo_headline "Silent Mode"
  install_selected "essentials rails ansible vagrant dotfiles fixubuntu heroku-toolbelt nodejs"
else
  selected_items=$(whiptail --separate-output --checklist "What do you want to install?" 15 60 8 \
  essentials "Essentials" on \
  rails "Rails" on \
  ansible "Ansible" on \
  vagrant "Vagrant" on \
  dotfiles "Vim, Zsh, Dotfiles" on \
  fixubuntu "Fix ubuntu" on \
  heroku-toolbelt "Heroku Toolbelt" on \
  nodejs "node.js, npm, karma" on 3>&1 1>&2 2>&3)

  exitstatus=$?
  if [ $exitstatus = 0 ]; then
    install_selected $selected_items
  else
    echo "Cancelled."
  fi
fi

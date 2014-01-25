#!/bin/bash

sudo apt-get install -y stow zsh libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev mercurial ruby1.9.1 ruby1.9.1-dev git build-essential

cd /tmp
hg clone https://vim.googlecode.com/hg/ vim
cd /tmp/vim/src
./configure --with-features=huge --enable-gui=gnome2 --enable-rubyinterp
sudo make
sudo make install

curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
curl -L https://raw.github.com/maksimr/dotfiles/master/gnome-terminal-themes/molokai.sh | sh

rm ~/.zshrc
git clone https://github.com/FlopsKa/dotfiles.git
cd ~/dotfiles
ln -s $(pwd)/zsh/flopska.zsh-theme ~/.oh-my-zsh/themes/flopska.zsh-theme
ln -s $(pwd)/zsh/zshrc ~/.zshrc

git submodule init
git submodule update

stow --target=$HOME vim

cd ~/.vim/bundle/command-t/ruby/command-t
ruby extconf.rb
sudo make

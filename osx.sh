#!/bin/bash

if [[ $USER != "root" ]]; then
  echo "You need to run this as root."
  exit 1
fi

homedir=`eval echo ~$SUDO_USER`

echo "INSTALLING VIM, ZSH, AND DOTFILES"

echo "Check if homebrew is installed"
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    # https://github.com/mxcl/homebrew/wiki/installation
    echo "Homebrew is not installed, I will take care of that"
    su -l "${SUDO_USER}" -c "ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\""
else
    brew update
fi

brew install zsh git vim

curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sudo -u "${SUDO_USER}" -H sh

rm "${homedir}/.zshrc"
sudo -u "${SUDO_USER}" -H git clone https://github.com/flower-pot/dotfiles.git "${homedir}/dotfiles"
ln -s "${homedir}/dotfiles/zsh/flopska.zsh-theme" "${homedir}/.oh-my-zsh/themes/flopska.zsh-theme"
ln -s "${homedir}/dotfiles/zsh/zshrc" "${homedir}/.zshrc"

(
cd "${homedir}/dotfiles"
git submodule init
git submodule update

ln -s "${homedir}/dotfiles/vim/.vim" "${homedir}/.vim"
ln -s "${homedir}/dotfiles/vim/.vimrc" "${homedir}/.vimrc"
)

(
cd "${homedir}/.vim/bundle/command-t/ruby/command-t/"
sudo ruby extconf.rb
sudo make
)

chsh -s /bin/zsh "${SUDO_USER}"

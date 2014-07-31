#!/bin/bash

if [[ $USER != "root" ]]; then
  echo "You need to run this as root."
  exit 1
fi

homedir=`eval echo ~$SUDO_USER`

echo "INSTALLING ZSH, AND DOTFILES"

echo "Check if homebrew is installed"
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    # https://github.com/mxcl/homebrew/wiki/installation
    echo "Homebrew is not installed, I will take care of that"
    echo "${SUDO_USER}"
    echo "curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install | ruby"
    su -l "${SUDO_USER}" -c "curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install | ruby"
else
    brew update
fi

brew install zsh git vim

curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sudo -u "${SUDO_USER}" -H sh
curl -L https://raw.github.com/maksimr/dotfiles/master/gnome-terminal-themes/molokai.sh | sudo -u "${SUDO_USER}" -H sh

rm "${homedir}/.zshrc"
sudo -u "${SUDO_USER}" -H git clone https://github.com/flower-pot/dotfiles.git "${homedir}/dotfiles"
ln -s "${homedir}/dotfiles/zsh/flopska.zsh-theme" "${homedir}/.oh-my-zsh/themes/flopska.zsh-theme"
ln -s "${homedir}/dotfiles/zsh/zshrc" "${homedir}/.zshrc"

chsh $SUDO_USER -s /bin/zsh

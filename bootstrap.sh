#!/bin/bash

# Detect OS
# Currently, I'm only using MacOS, Ubuntu and CentOS
function is_osx() {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}
function is_ubuntu() {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1
}
function is_centos() {
  [[ "$(cat /etc/*release 2> /dev/null | grep ^NAME | tr -d 'NAME=\"')" =~ CentOS ]] || return 1
}
function get_os() {
  for os in osx ubuntu centos; do
    is_$os; [[ $? == ${1:-0} ]] && echo $os
  done
}

# Detect Package manager
function get_packman() {
    OS=$(get_os)
    case $OS in
        "ubuntu")
            echo "apt"
            ;;
        "centos")
            echo "yum"
            ;;
        "osx")
            echo "brew"
            ;;
    esac
}

# Install specified package
function install() {
    PACKMAN=$(get_packman)

    if ! type "$1" > /dev/null 2>&1; then
        echo "Installing $1"
        if [[ $PACKMAN == "brew" ]]; then
            brew install $1
        else
            $PACKMAN -y install $1
        fi
    else
        echo "$1 already Installed"
    fi
}

# Install dependencies
install git
install zsh
install tmux
install neovim
install kitty
install bspwm
install rofi
install ruby

gem install tmuxinator

git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# Install polybar
snap install polybar-git --edge --devmode

# install terminfos
tic -x $HOME/.config/terminfo/xterm-256color-italic.terminfo
tic -x $HOME/.config/terminfo/tmux-256color.terminfo

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install starship prompt
curl -fsSL https://starship.rs/install.sh | bash


if [[ $OS == 'ubuntu' ]]; then
    #Install Zoom
    wget https://zoom.us/client/latest/zoom_amd64.deb
    apt install ./zoom_amd64.deb
    rm ./zoom_amd64.deb -f
fi



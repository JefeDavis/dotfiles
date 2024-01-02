#!/usr/bin/env bash

# change to homebrew zsh
grep -qxF "$(which zsh)" /etc/shells || echo "$(which zsh)" | sudo tee -a /etc/shells
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s $(which zsh)
fi

# Initialize zsh
grep -qF "ZDOTDIR" /etc/zshenv || echo 'export "ZDOTDIR=$HOME/.config/zsh"' | sudo tee /etc/zshenv



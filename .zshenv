# ZSH env configuration
export ZDOTDIR="$HOME/.config/zsh"
export ZSH_DISABLE_COMPFIX=true
export ZSH="$HOME/.oh-my-zsh"

export PATH="$GOPATH/bin:"$HOME"/.local/bin:"$HOME"/.cargo/bin:$PATH"
export EDITOR="nvim"
export GOPATH=$HOME/go
source "$HOME/.cargo/env"

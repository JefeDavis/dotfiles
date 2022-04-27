# XDG Base directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# ZSH Environment
# These are for variables that I want to adjust and be able to source a new shell and have pop up
# other more standard variables should go in .zprofile
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_DISABLE_COMPFIX=true
export HISTFILE="$XDG_DATA_HOME/zsh/history"
export HISTSIZE=1000000000
export HISTFILESIZE=1000000000
export SAVEHIST=1000000000

export CDPATH=.:/etc/srv/:$HOME:$HOME/Projects:$HOME/Documents

export EDITOR="nvim"
export BROWSER="firefox"
export MANPAGER="nvim +Man!"
export LESSHISTFILE="$XDG_DATA_HOME/lesshst"

for file in $(find $HOME/.config/env -name "*.env")
do
  source $file
done

export FZF_DEFAULT_OPTS='--reverse --ansi --color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD'

export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker" 
# ZOOM - What the hell is SSB?
export SSB_HOME="$XDG_DATA_HOME/zoom"

export PATH="$HOME/.local/bin:$PATH"

export THEME=$(cat $HOME/.config/current-theme)

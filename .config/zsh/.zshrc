# Configurationh for prompt
if [ -f $ZDOTDIR/promptrc ]; then
    source $ZDOTDIR/promptrc
fi

# Configuration for path variable (varies between mac and arch)
if [ -f $ZDOTDIR/pathrc ]; then
    source $ZDOTDIR/pathrc
fi

source $ZDOTDIR/zsh_aliases

source $ZSH/oh-my-zsh.sh

alias v="nvim"
alias vi="nvim"
alias vim="nvim"

# Task warrior tooling
alias t="task"
alias tap="task context personal"
alias taw="task context work"
alias in="task add +in"
alias chore="task add +personal +chore" 
alias d="delta"

tickle () {
    task $@ modify wait:soww
}

delta() {
  if [ "$1" = "launch" ]; then
    tmuxinator start $2
  fi
  
  if [ "$1" = "l" ]; then
    tmuxinator start $2
  fi

  if [ "$1" = "new" ]; then
    tmuxinator start launch name=${PWD##*/} root=$(pwd)
  fi
}

launch() {
  session_name=$(ls ~/Development | fzf) 
  tmuxinator start $session_name 2>/dev/null || tmuxinator start launch name=$session_name root=~/Development/$session_name
}

title="A NEW BATTLE AWAITS, GUARDIAN"
printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"

eval "$(direnv hook zsh)"

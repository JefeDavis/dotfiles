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

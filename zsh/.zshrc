ZSH_DISABLE_COMPFIX="true"
plugins=(git git-flow brew history kubectl)

autoload -Uz compinit
compinit
alias k=kubectl
#complete -F __start_kubectl k

export GOPATH=/Users/jeffda/go
export GOROOT=/usr/local/opt/go/libexec
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export GPG_TTY=$(tty)

alias vi=nvim
alias vim=nvim
export EDITOR=nvim

# nnn config
export NNN_OPTS="Hd"
export NNN_TRASH=1
export NNN_BMS="a:$HOME/Documents/Archive;D:$HOME/Documents;p:$HOME/Projects;c:$HOME/.config;o:$HOME/Downloads;w:$HOME/Pictures/Wallpapers"
BLK="00" CHAR="00" DIR="69" EXE="DE" REG="00" HLI="00" SLI="00" MIS="00" ORP="00" FIF="00" SOC="00" UNK="00"
export NNN_FCOLORS="$BLK$CHAR$DIR$EXE$REG$HLI$SLI$MIS$ORP$FIF$SOC$UNK"
export NNN_COLORS="#56565656"
export NNN_PLUG="p:preview-tui"
export NNN_FIFO=/tmp/nnn.fifo

alias mux=tmuxinator
alias muxd=tmuxinator start default

eval "$(starship init zsh)"

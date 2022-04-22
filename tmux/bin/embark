#!/bin/sh

set -eu

EMBARK=embark
VERSION=0.0.1

TARGET=$(ls -d ~/Projects/* ~/* /etc/srv/* ~/Documents/* | fzf)
NAME=$(basename $TARGET)

tmuxinator start $NAME || tmuxinator start default name=$NAME root=$TARGET

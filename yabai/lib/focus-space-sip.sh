#!/bin/sh

# Switch to the workspace by passing in the space id (with SIP enabled)

tgt_space=$1

cur_display=$(yabai -m query --displays --display | jq '.index')
tgt_display=$(yabai -m query --displays --space ${tgt_space} | jq '.index')

if [ $cur_display != $tgt_display ]
then
  yabai -m display --focus ${tgt_display} || exit 1
fi

skhd -k "cmd - ${tgt_space}"

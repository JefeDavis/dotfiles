# vim: set ft=tmux:
set -g @plugin 'christoomey/vim-tmux-navigator'
set -g @plugin 'fcsonline/tmux-thumbs'
set -g @plugin 'sainnhe/tmux-fzf'
set -g @plugin 'roosta/tmux-fuzzback'

# Thumbs
set -g @thumbs-key 'y'
set -g @thumbs-alphabet 'qwerty-left-hand'
set -g @thumbs-reverse enabled
set -g @thumbs-contrast 1
set -g @thumbs-upcase-command 'echo -n {} | pbcopy'

# fuzzback
set -g @fuzzback-popup 1
set -g @fuzzback-popup-size '90%'

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

# Theme
set -g @plugin 'jefedavis/catppuccin-tmux'
set -g @catppuccin_flavour 'mocha'
set -g @catppuccin_window_status_enable "yes"
set -g @catppuccin_window_status_icon_enable "yes"
set -g @catppuccin_window_left_separator "█"
set -g @catppuccin_window_right_separator "█"
set -g @catppuccin_window_number_position "left"
set -g @catppuccin_window_middle_separator "█"

set -g @catppuccin_window_default_fill "number"
 
set -g @catppuccin_window_current_fill "number"
set -g @catppuccin_window_current_text '#W'
set -g @catppuccin_window_default_text "#W"

set -g @catppuccin_status_fill "all"
set -g @catppuccin_status_connect_separator "yes"
set -g @catppuccin_status_right_separator_inverse "no"
set -g @catppuccin_status_left_separator "█"
set -g @catppuccin_status_right_separator "█"
set -g @catppuccin_status_modules_left_separator_left  " "
set -g @catppuccin_status_modules_right_separator_right " "
set -g @catppuccin_status_modules_left "session"
set -g @catppuccin_status_modules_right "application date_time"

set -g @catppuccin_icon_window_last "󰖰"
set -g @catppuccin_icon_window_current "󰖯"
set -g @catppuccin_icon_window_zoom "󰁌"
set -g @catppuccin_icon_window_mark "󰃀"
set -g @catppuccin_icon_window_silent "󰂛"
set -g @catppuccin_icon_window_activity "󰖲"
set -g @catppuccin_icon_window_bell "󰂞"

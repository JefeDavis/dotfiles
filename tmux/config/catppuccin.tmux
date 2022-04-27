# NOTE: you can use vars with $<var> and ${<var>} as long as the str is double quoted: ""
# WARNING: hex colors can't contain capital letters

# --> Catppuccin
thm_bg="#1e1e2e"
thm_fg="#dadae8"
thm_cyan="#c2e7f0"
thm_black="#15121c"
thm_gray="#332e41"
thm_magenta="#c6aae8"
thm_pink="#e5b4e2"
thm_red="#e38c8f"
thm_green="#b1e3ad"
thm_yellow="#ebddaa"
thm_blue="#a4b9ef"
thm_orange="#f9c096"
thm_black4="#575268"

# ----------------------------=== Theme ===--------------------------

# status
set -g status-interval 3
set -g status-position bottom

set -g status-bg "$thm_bg"
set -g status-right-length "80"
set -g status-left-length "100"

# messages
set -g message-style fg="brightcyan",bg="${thm_gray}",align="centre"
set -g message-command-style fg="brightcyan",bg="${thm_gray}",align="centre"

# panes
set -g pane-border-style fg="${thm_gray}"
set -g pane-active-border-style fg="blue"

# windows
set -g status-justify left
set -g window-status-separator ""

set -g window-status-activity-style fg="${thm_fg}",bg="${thm_bg}",none
set -g window-status-style fg="${thm_fg}",bg="${thm_bg}",none

# --------=== Statusline

set -g status-left "#[bg=$thm_gray,fg=$thm_fg italics] #(tmux run-shell 'tmux display-message -p \"#S\" | tr \"[:lower:]\" \"[:upper:]\"') #[fg=$thm_gray, bg=$thm_bg]"


set -g status-right "#[fg=$thm_pink,bg=$thm_bg]#[bg=$thm_pink,fg=$thm_bg] %Y-%m-%d #[fg=$thm_pink,bg=$thm_magenta] #[fg=$thm_bg,bg=$thm_magenta]%H:%M #[fg=$thm_magenta,bg=$thm_blue]#[bg=$thm_blue,fg=$thm_bg italics] @#H "

set -g window-status-format "#[fg=$thm_black4]#[fg=brightwhite,bg=$thm_black4] #{?window_zoomed_flag,  ,}#W #[bg=$thm_bg,fg=$thm_black4]"

set -g window-status-current-format "#[fg=$thm_green]#[bg=$thm_green,fg=$thm_bg] #W #{?window_zoomed_flag,  ,}#[fg=$thm_green,bg=$thm_bg]"

# --------=== Modes
setw -g clock-mode-colour "blue"
setw -g mode-style "fg=brightmagenta bg=${thm_black4} bold"

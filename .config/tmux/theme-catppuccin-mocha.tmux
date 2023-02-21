# NOTE: you can use vars with $<var> and ${<var>} as long as the str is double quoted: ""
# WARNING: hex colors can't contain capital letters

# --> Catppuccin (Mocha)
thm_bg="#1e1e2e"
thm_fg="#cdd6f4"
thm_cyan="#89dceb"
thm_black="#181825"
thm_gray="#313244"
thm_magenta="#cba6f7"
thm_pink="#f5c2e7"
thm_red="#f38ba8"
thm_green="#a6e3a1"
thm_yellow="#f9e2af"
thm_blue="#89b4fa"
thm_orange="#fab387"
thm_black4="#585b70"

# status
set-option -g status "on"
set-option -g status-bg "${thm_bg}"
set-option -g status-justify "left"
set-option -g status-left-length "100"
set-option -g status-right-length "100"

# messages
set-option -g message-style "fg=${thm_cyan},bg=${thm_gray},align=centre"
set-option -g message-command-style "fg=${thm_cyan},bg=${thm_gray},align=centre"

# panes
set-option -g pane-border-style "fg=${thm_gray}"
set-option -g pane-active-border-style "fg=${thm_blue}"

# windows
set-window-option -g window-status-activity-style "fg=${thm_fg},bg=${thm_bg},none"
set-window-option -g window-status-separator ""
set-window-option -g window-status-style "fg=${thm_fg},bg=${thm_bg},none"

# --------=== Statusline

# NOTE: Checking for the value of @catppuccin_window_tabs_enabled
wt_enabled="$(get-tmux-option "@catppuccin_window_tabs_enabled" "off")"

# These variables are the defaults so that the setw and set calls are easier to parse.
show_directory="#[fg=$thm_pink,bg=$thm_bg,nobold,nounderscore,noitalics]#[fg=$thm_bg,bg=$thm_pink,nobold,nounderscore,noitalics]  #[fg=$thm_fg,bg=$thm_gray] #{b:pane_current_path} #{?client_prefix,#[fg=$thm_red]"
show_window="#[fg=$thm_pink,bg=$thm_bg,nobold,nounderscore,noitalics]#[fg=$thm_bg,bg=$thm_pink,nobold,nounderscore,noitalics] #[fg=$thm_fg,bg=$thm_gray] #W #{?client_prefix,#[fg=$thm_red]"
show_session="#[fg=$thm_green]}#[bg=$thm_gray]#{?client_prefix,#[bg=$thm_red],#[bg=$thm_green]}#[fg=$thm_bg] #[fg=$thm_fg,bg=$thm_gray] #S "
show_directory_in_window_status="#[fg=$thm_bg,bg=$thm_blue] #I #[fg=$thm_fg,bg=$thm_gray] #{b:pane_current_path} "
show_directory_in_window_status_current="#[fg=$thm_bg,bg=$thm_orange] #I #[fg=$thm_fg,bg=$thm_bg] #{b:pane_current_path} "
show_window_in_window_status="#[fg=$thm_fg,bg=$thm_bg] #W #[fg=$thm_bg,bg=$thm_blue] #I#[fg=$thm_blue,bg=$thm_bg]#[fg=$thm_fg,bg=$thm_bg,nobold,nounderscore,noitalics] "
show_window_in_window_status_current="#[fg=$thm_fg,bg=$thm_gray] #W #[fg=$thm_bg,bg=$thm_orange] #I#[fg=$thm_orange,bg=$thm_bg]#[fg=$thm_fg,bg=$thm_bg,nobold,nounderscore,noitalics] "

# Right column 1 by default shows the Window name.
right_column1=$show_window

# Right column 2 by default shows the current Session name.
right_column2=$show_session

# Window status by default shows the current directory basename.
window_status_format=$show_directory_in_window_status
window_status_current_format=$show_directory_in_window_status_current

# NOTE: With the @catppuccin_window_tabs_enabled set to on, we're going to
# update the right_column1 and the window_status_* variables.
right_column1=$show_directory
window_status_format=$show_window_in_window_status
window_status_current_format=$show_window_in_window_status_current

set-option -g status-left ""

set-option -g status-right "${right_column1},${right_column2}"

set-window-option -g window-status-format "${window_status_format}"
set-window-option -g window-status-current-format "${window_status_current_format}"

# --------=== Modes
#
set-window-option -g clock-mode-colour "${thm_blue}"
set-window-option -g mode-style "fg=${thm_pink} bg=${thm_black4} bold"

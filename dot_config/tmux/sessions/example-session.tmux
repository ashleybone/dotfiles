# Initial session
set-option -g history-limit 10000
new-session -s desktop-session -n "host" "bash"

set-option -g history-limit 0
split-window -t 0.0 -h "emacs"

set-option -g history-limit 10000
split-window -t 0.0 -v "bash"

select-pane -t host.2

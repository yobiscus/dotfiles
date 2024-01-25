if status is-interactive
    # Commands to run in interactive sessions can go here
end

pyenv init - | source
bind \cd delete-char  # don't exit on <C-d>

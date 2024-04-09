if status is-interactive
    bind \cd delete-char  # don't exit on <C-d>
end

# tools
type -q pyenv; and pyenv init - | source
type -q zoxide; and zoxide init fish | source

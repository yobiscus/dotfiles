if status is-interactive
    bind \cd delete-char  # don't exit on <C-d>
    keychain --eval id_ed25519 | source
end

# tools
type -q pyenv; and pyenv init - | source
type -q zoxide; and zoxide init fish | source

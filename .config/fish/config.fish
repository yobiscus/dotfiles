if status is-interactive
    bind \cd delete-char  # don't exit on <C-d>

    if test -f $HOME/.ssh/id_ed25519.pub
        keychain --eval id_ed25519 | source
    else
        keychain --eval id_rsa | source
    end
end

# tools
type -q pyenv; and pyenv init - | source
type -q zoxide; and zoxide init fish | source

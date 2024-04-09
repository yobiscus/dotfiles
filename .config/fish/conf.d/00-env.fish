# universal config
set -qU XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config
set -qU XDG_DATA_HOME; or set -Ux XDG_DATA_HOME $HOME/.local/share
set -qU XDG_CACHE_HOME; or set -Ux XDG_CACHE_HOME $HOME/.cache

# global config
set -gx EDITOR nvim
set -gx VISUAL nvim

# PATH
fish_add_path $HOME/.cargo/bin

# OS specific PATH
switch (uname)
	case Darwin
		fish_add_path /opt/homebrew/bin
end

# tools
type -q pyenv; and pyenv init - | source

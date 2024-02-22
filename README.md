# Instructions

## Install dotfiles and config

```bash
# download config
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
echo ".cfg" >> .gitignore
git clone --bare git@github.com:yobiscus/dotfiles.git $HOME/.cfg
config config --local status.showUntrackedFiles no

# Avoid cloning certain files, e.g. README.md
config config core.sparseCheckout true
echo '/*' >> ~/.cfg/info/sparse-checkout
echo '!README.md' >> ~/.cfg/info/sparse-checkout

# apply config
config checkout
~/.cfg-init.sh
```

More info available at:
<https://www.atlassian.com/git/tutorials/dotfiles>

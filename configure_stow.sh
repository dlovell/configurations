set -eu
# we don't actually run stow here: this repo is all about generating the dotfiles

# NOTE: this will require password interaction
DOTFILES_REPO_URL=https://github.com/dlovell/dotfiles
DOTFILES=\$HOME/.dotfiles
# if you use this, be careful when you switch branches: you will impact the machine you're running on
DOTFILES_REPO_DIR=${1:-$DOTFILES}

git clone $DOTFILES_REPO_URL $DOTFILES_REPO_DIR
[ $DOTFILES_REPO_DIR = $DOTFILES ] || ln -s $DOTFILES_REPO_DIR $DOTFILES
echo "\
alias stow-dotfiles='stow --target=\$HOME --dir=$DOTFILES'
# https://unix.stackexchange.com/a/38691
alias find-broken-symlinks='find -maxdepth 1 -xtype l'
" >> ~/.bash_aliases

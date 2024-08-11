export ZSH_DISABLE_COMPFIX="true"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(thefuck terraform python colorize iterm2)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias python=python3
alias pip=pip3

alias g=git
alias dk=docker
alias ti='terraform init'
alias tv='terraform validate'
alias tp='terraform plan'
alias tap='terraform apply --auto-approve'
alias tf='terraform fmt --recursive'
alias tha=fuck

if [ -f ~/dotfiles/_local/.zshrc_local ]; then
    source ~/dotfiles/_local/.zshrc_local
fi

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\W\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

alias -='cd -'
alias ..='cd ..'

alias ls='ls -G'
alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias lsa='ls -lah'

alias md='mkdir -p'
alias rd=rmdir

alias python=python3
alias pip=pip3

alias g=git
alias dk=docker

if [ -f ~/dotfiles/local/.bashrc_local ]; then
    source ~/dotfiles/local/.bashrc_local
fi

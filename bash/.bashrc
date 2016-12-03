#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='\[\033[1;32m\]\u@\h: \[\033[1;36m\]\w $ \[\033[0m\] '

export VISUAL=vim


# Some additional aliases
alias ll='ls -l'
alias la='ls -a'
alias ..='cd ..'
alias rm="mv -t ~/.trash/ --backup=t --verbose"



#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

eval `dircolors ~/.dircolors`

alias ls='ls --color=auto'
PS1='\[\e[1;38;5;29m\]\u@\h: \[\e[1;38;5;166m\]\w $ \[\e[0m\] '
export VISUAL=vim


# Some additional aliases
alias ll='ls -l'
alias la='ls -a'
alias ..='cd ..'
alias rm="mv -t ~/.trash/ --backup=t --verbose"
alias octave="octave --no-gui"
alias python="python2"
alias ipython="ipython2"


#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH="$HOME/.emacs.d/bin:$PATH"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
PS1='[\u@\h \W]\$ '

eval "$(oh-my-posh init bash --config $HOME/.config/ohmyposh/ohmyposh.json)"

# Add custom binaries to PATH
export JAVA_HOME=/usr/lib/jvm/java-23-openjdk
export PATH=$JAVA_HOME/bin:$PATH
export BAT_THEME="gruvbox-dark"
export PATH=$HOME/.local/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=$HOME/.cache/pokemon-icat:$PATH
export PATH=$HOME/.config/scripts:$PATH
export PATH=$HOME/.config/emacs/bin:$PATH
export PATH="$PATH":"$HOME/.pub-cache/bin"

# Go blueprint
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

export _JAVA_AWT_WM_NONREPARENTING=1
export BROWSER=zen-browser

# Language
export LANG=en_US.UTF-8

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Aliases
alias ls='ls --color'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias cd='z'
alias ls='exa'
alias ll='exa -la --icons'
alias tree='eza -1A --group-directories-first --color=always --git-ignore --tree'
alias vim='nvim'
alias v='nvim'
alias ff='nvim $(fzf -m --preview="bat --color=always {}")'
alias ft='~/.config/scripts/fzf-tmux.sh'
alias c='clear'
alias zed='zeditor'

# Tmux aliases
alias t='~/.config/scripts/start-tmux.sh'
alias ta='tmux attach'
alias tl='tmux list-sessions'
alias tn='tmux new-session -s'

# XAMPP aliases
alias xampp-start='sudo /opt/lampp/lampp start'
alias xampp-stop='sudo /opt/lampp/lampp stop'
alias xampp-restart='sudo /opt/lampp/lampp restart'
alias xampp-status='sudo /opt/lampp/lampp status'

# Git aliases
alias ga='git add'
alias gap='ga --patch'
alias gb='git branch'
alias gba='gb --all'
alias gc='git commit'
alias gca='gc --amend --no-edit'
alias gce='gc --amend'
alias gco='git checkout'
alias gcl='git clone --recursive'
alias gd='git diff --output-indicator-new=" " --output-indicator-old=" "'
alias gds='gd --staged'
alias gi='git init'
alias gl='git log --graph --pretty=format:"%C(magenta)%h %C(white)%an  %ar%C(blue)  %D%n%s%n"'
alias gm='git merge'
alias gn='git checkout -b'  # new branch
alias gp='git push'
alias gr='git reset'
alias gs='git status --short'
alias gu='git pull'

# Man colors
man() {
  GROFF_NO_SGR=1 \
  LESS_TERMCAP_mb=$'\e[31m' \
  LESS_TERMCAP_md=$'\e[34m' \
  LESS_TERMCAP_me=$'\e[0m' \
  LESS_TERMCAP_se=$'\e[0m' \
  LESS_TERMCAP_so=$'\e[1;30m' \
  LESS_TERMCAP_ue=$'\e[0m' \
  LESS_TERMCAP_us=$'\e[35m' \
  command man "$@"
}

# Oh my posh setup
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/ohmyposh.json)"
eval "$(zoxide init zsh)"

# Pluginmanager zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Add plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Load completions
autoload -U compinit && compinit

# Keybindings emacs mode
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-color "${(s.:.)LS_COLORS}"

# Pokemon
pokemon-icat

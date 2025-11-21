# =========================
# 1. Environment Variables
# =========================

export JAVA_HOME="/usr/lib/jvm/java-25-openjdk"
export GOPATH="$HOME/go"
export _JAVA_AWT_WM_NONREPARENTING=1
export BROWSER="zen-browser"
export LANG="en_US.UTF-8"
export BAT_THEME="gruvbox-dark"
export POKEMON_ICAT_DATA="$HOME/.local/share/pokemon-icat"

# =========================
# 2. PATH Setup (Einzeln)
# =========================

export PATH="$JAVA_HOME/bin:$PATH"                       # Java
export PATH="$HOME/.local/bin:$PATH"                     # User scripts
export PATH="$HOME/.cargo/bin:$PATH"                     # Rust/Cargo
export PATH="$HOME/.cache/pokemon-icat:$PATH"            # Pokemon iCat
export PATH="/usr/local/go/bin:$PATH"                    # Go
export PATH="$GOPATH/bin:$PATH"                          # Go user binaries

export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"


source $HOME/.askai-env

# =========================
# 3. Aliases
# =========================

# General
alias ..='cd ..'
alias ...='cd ../..'
alias cd='z'
alias c='clear'
alias zed='zeditor'

# File/Directory Listing
alias ls='eza'
alias ll='eza -la --icons'
alias tree='eza -1A --group-directories-first --color=always --git-ignore --tree'

# Search/Editor
alias grep='grep --color=auto'
alias vim='nvim'
alias v='nvim'
alias ff='nvim $(fzf -m --preview="bat --color=always {}")'
alias ft='~/.config/scripts/fzf-tmux.sh'

# Tmux
alias ta='tmux attach'
alias tl='tmux list-sessions'
alias tn='tmux new-session -s'

# XAMPP
alias xampp-start='sudo /opt/lampp/lampp start'
alias xampp-stop='sudo /opt/lampp/lampp stop'
alias xampp-restart='sudo /opt/lampp/lampp restart'
alias xampp-status='sudo /opt/lampp/lampp status'

# Git
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
alias gla='serie'
alias glf='$HOME/.config/scripts/git-logs.sh'
alias gm='git merge'
alias gn='git checkout -b'  
alias gp='git push'
alias gr='git reset'
alias gs='git status --short'
alias gu='git pull'

# PDF
alias to-pdf='abiword --to=pdf'

# =========================
# 4. Functions
# =========================

# Color man pages
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

# =========================
# 5. App Integrations
# =========================

source <(fzf --zsh)
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/ohmyposh.json)"
# eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
# eval "$(direnv hook zsh)"

# =========================
# 6. Zinit Plugin Manager
# =========================

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# =========================
# 7. Zinit Plugins
# =========================

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# =========================
# 8. Completion System
# =========================

autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-color "${(s.:.)LS_COLORS}"

# =========================
# 9. Keybindings (Emacs Mode)
# =========================

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# =========================
# 10. History Settings
# =========================

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

# =========================
# 11. Extras
# =========================

pokemon-icat 

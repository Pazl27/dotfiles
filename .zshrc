# Created by newuser for 5.9

# Add custom binaries to PATH
export PATH="$HOME/.emacs.d/bin:$PATH"

export JAVA_HOME=/usr/lib/jvm/java-22-openjdk
export PATH=$JAVA_HOME/bin:$PATH
export PATH=$PATH:/opt/intellij-idea-ultimate-edition/bin



# Aliases
alias ls='ls --color'
alias grep='grep --color=auto'
alias ..='cd ..'

# Oh my posh setup
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/ohmyposh.json)"

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

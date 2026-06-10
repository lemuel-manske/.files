export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

bindkey '^H' backward-kill-word

autoload -U colors && colors

if command -v neofetch >/dev/null 2>&1; then
  neofetch
fi

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

setopt autocd              # cd just by typing directory name
setopt correct             # auto-correct minor typos in commands
setopt histignoredups      # no duplicates in history
setopt sharehistory        # share history across terminals
setopt extendedglob

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PATH="$HOME/.nvm/versions/node/v24.12.0/bin:$PATH"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

HISTSIZE=1000
SAVEHIST=2000
setopt HIST_IGNORE_DUPS
setopt HIST_APPEND

source ~/.aliases

if [ -f ~/.hidden_variables ]; then
  source ~/.hidden_variables
fi

export EDITOR="nvim"

export PATH=~/.opencode/bin:/opt/nvim:/opt/obsidian:$PATH

export PATH=/opt/sqlcl/bin:$PATH

export PATH=$HOME/.devcontainers/bin:$PATH

export PATH=/usr/local/go/bin:$PATH
export PATH=$HOME/go/bin:$PATH

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

export NODE_OPTIONS=--max-old-space-size=8192
export NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt

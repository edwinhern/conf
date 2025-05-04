# Powerlevel10k configuration
typeset -g POWERLEVEL9K_INSTANT_PROMPT_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh"

if [[ -r "$POWERLEVEL9K_INSTANT_PROMPT_CACHE" ]]; then
  source "$POWERLEVEL9K_INSTANT_PROMPT_CACHE"
fi

# ASDF
export ASDF_DATA_DIR="$HOME/.config/asdf"
export PATH="$ASDF_DATA_DIR/shims:$PATH"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  git
  git-auto-fetch
  asdf
  docker
  kubectl
  docker-compose
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-bat
)
source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Aliases
alias o="open ."
alias l="ls"
alias ll="ls -al"
alias update="brew update; brew upgrade; omz update; asdf plugin update --all"
alias openzsh="code ~/.zshrc"
alias openohmyzsh="code ~/.oh-my-zsh"

# macOS
alias port="lsof -i"
alias stop="kill -9"

if [[ -o interactive ]]; then
  fastfetch
fi

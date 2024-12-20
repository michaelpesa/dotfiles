# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set home directory for zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone 'https://github.com/zdharma-continuum/zinit.git' "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

#zinit light zdharma-continuum/zinit-annex-bin-gem-node
#zinit light zinit-zsh/z-a-patch-dl

zinit ice depth=1; zinit load romkatv/powerlevel10k
zinit load zsh-users/zsh-syntax-highlighting
zinit load zsh-users/zsh-completions
zinit load zsh-users/zsh-autosuggestions

export EDITOR=nvim
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ANALYTICS=1        # Disable Homebrew telemetry
export SAM_CLI_TELEMETRY=0            # Disable AWS SAM telemetry
export AZURE_CORE_COLLECT_TELEMETRY=0 # Disable Azure telemetry

if [[ -d "$HOME/.bin" ]]; then
  export PATH="$HOME/.bin:$PATH"
fi

if [[ -d "$HOME/.cargo/bin" ]]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# Enable Homebrew autocomplete functions
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
fi

# Load Angular CLI autocompletion.
if type ng &>/dev/null; then
  source <(ng completion script)
fi

# Use Emacs keybindings
set -o emacs

alias ls='lsd --long --git'
alias cat='bat'
alias vi='nvim'
alias k='kubectl'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(fzf --zsh)"
source ~/Developer/fzf-git.sh/fzf-git.sh

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

show_file_or_dir_preview="if [ -d {} ]; then lsd --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'lsd --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \$' {}" "$@" ;;
    ssh)          fzf --preview 'dig {}' "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Kubernetes settings
if command -v kubectl 2>&1 >/dev/null; then
  # Krew kubectl plugin support
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

  # Use color kubectl output if available
  if command -v kubecolor 2>&1 >/dev/null; then
    alias kubectl=kubecolor
  fi

  # Enable kubectl autocompletion
  source <(kubectl completion zsh)
  compdef kubecolor=kubectl
fi

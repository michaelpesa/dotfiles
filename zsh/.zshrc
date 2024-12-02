# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# oh-my-zsh configuration.
export ZSH="$HOME/.oh-my-zsh"
if [[ "$(uname)" = "Darwin" ]]; then
  plugins=(macos git)
else
  plugins=(git)
fi

source $ZSH/oh-my-zsh.sh

export EDITOR=nvim
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ANALYTICS=1        # Disable Homebrew telemetry
export SAM_CLI_TELEMETRY=0            # Disable AWS SAM telemetry
export AZURE_CORE_COLLECT_TELEMETRY=0 # Disable Azure telemetry

if [[ -d "$HOME/.bin" ]]; then
  export PATH="$HOME/.bin:$PATH"
fi

# Enable Homebrew autocomplete functions
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
fi

# Use color kubectl output if available
if command -v kubecolor 2>&1 >/dev/null; then
  alias kubectl=kubecolor
fi

# Load Angular CLI autocompletion.
if type ng &>/dev/null; then
  source <(ng completion script)
fi

alias ls='lsd --long --git'
alias vi='nvim'
alias k='kubectl'

# OS-specific settings
case "$(uname)" in
  Darwin)
    source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ;;
  Linux)
    source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ;;
esac

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Krew kubectl plugin support
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

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

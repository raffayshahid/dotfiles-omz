
# ---------- PATH ----------
export PATH="$HOME/.local/bin:$PATH"

# ---------- History ----------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=5000
SAVEHIST=5000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY

# ---------- Shell ----------
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# ---------- Zinit ----------
export ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
if [[ -r "$ZINIT_HOME/zinit.zsh" ]]; then
    source "$ZINIT_HOME/zinit.zsh"
fi

# ---------- Plugins ----------

# Autocomplete: initializes completion itself
# Completion settings
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''

# Real-time autocomplete
# Load highlighter before autocomplete
zinit light zdharma-continuum/fast-syntax-highlighting
# ---------- Enhanced completion ----------

# Show as many completion lines as fit in the terminal
zstyle -e ':autocomplete:*:*' list-lines 'reply=( $(( LINES - 5 )) )'

# Allow more time for completions
zstyle ':autocomplete:*' timeout 3

# Group and describe completions
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'

# Match case-insensitively
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

zinit light marlonrichert/zsh-autocomplete

# Fish-style command suggestions
zinit light zsh-users/zsh-autosuggestions

# Oh My Zsh Git plugin (without the framework)
zinit snippet OMZP::git

# Fast syntax highlighting: load last
# Disabled conflicting highlighter: zinit light zdharma-continuum/fast-syntax-highlighting

# ---------- Prompt ----------
export STARSHIP_LOG=error
# Disabled Starship: eval "$(starship init zsh)"


# Load fast syntax highlighting last

# ---------- Restored configuration ----------

# Original aliases
alias c="clear"
alias l="ls -la"

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# Powerlevel10k theme
if [[ -f "$HOME/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
    source "$HOME/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme"
elif [[ -f "$HOME/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
    source "$HOME/powerlevel10k/powerlevel10k.zsh-theme"
fi

# Original Powerlevel10k configuration
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# ---------- Completion restoration ----------

# Load kubectl completion if kubectl is installed
if (( $+commands[kubectl] )); then
    source <(kubectl completion zsh)
fi

# Open the interactive completion menu with Tab
bindkey '^I' menu-select
[[ -n "$terminfo[kcbt]" ]] && bindkey "$terminfo[kcbt]" menu-select


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

# ---------- Rich command completions ----------
# Prefer flags and commands in completion listings
zstyle ':completion:*:' group-order options commands     subcommands executables directories aliases functions builtins

# Show descriptions and group results
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'

# Allow the menu to use the available terminal height
zstyle -e ':autocomplete:*:*' list-lines     'reply=( $(( LINES > 8 ? LINES - 5 : 3 )) )'

# Start showing suggestions after one character
zstyle ':autocomplete:*' min-input 1
zstyle ':autocomplete:*' delay 0.05
zstyle ':autocomplete:*' timeout 2

zinit light marlonrichert/zsh-autocomplete

# Fish-style command suggestions
zinit light zsh-users/zsh-autosuggestions

# Oh My Zsh Git plugin (without the framework)
zinit snippet OMZP::git

# ---------- Additional developer plugins ----------

# Kubernetes aliases and completions
zinit snippet OMZP::kubectl

# Docker helpers
zinit snippet OMZP::docker

# Rust / Cargo completions
zinit snippet OMZP::rust

# Discover existing aliases
zinit snippet OMZP::alias-finder

# Homebrew helpers
zinit snippet OMZP::brew

# GitHub helpers
zinit snippet OMZP::gh

# Readable man pages
zinit snippet OMZP::colored-man-pages

# Smart directory navigation
eval "$(zoxide init zsh)"

# Fuzzy finding
source <(fzf --zsh)


# Fast syntax highlighting: load last
# Disabled conflicting highlighter: zinit light zdharma-continuum/fast-syntax-highlighting

# ---------- Prompt ----------
export STARSHIP_LOG=error
# Disabled Starship: eval "$(starship init zsh)"


# Load fast syntax highlighting last

# ---------- Restored configuration ----------

# Original aliases
alias c="clear"

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

# ---------- Colored command output ----------
export CLICOLOR=1
export LSCOLORS="GxFxCxDxBxegedabagaced"
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# ---------- Modern file listings (eza) ----------
if (( $+commands[eza] )); then
    alias ls='eza --icons=auto --color=auto --group-directories-first'
    alias l='eza -la --icons=auto --color=auto --group-directories-first --git'
    alias ll='eza -l --icons=auto --color=auto --group-directories-first --git'
    alias la='eza -a --icons=auto --color=auto --group-directories-first'
    alias lt='eza --tree --level=2 --icons=auto --color=auto --group-directories-first'
fi

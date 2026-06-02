clear

# -----------------------------
# Safety
# -----------------------------
set +e

# -----------------------------
# Prompt
# -----------------------------
autoload -Uz promptinit
promptinit

setopt histignorealldups sharehistory
bindkey -e

# -----------------------------
# History
# -----------------------------
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# -----------------------------
# Completion (fast cached)
# -----------------------------
autoload -Uz compinit
compinit -C

# -----------------------------
# Syntax highlighting
# -----------------------------
source ~/.local/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# colors to match your theme
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#922828'         # invalid command → dark red
ZSH_HIGHLIGHT_STYLES[command]='fg=#c2beb8'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#c2beb8'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#c2beb8'
ZSH_HIGHLIGHT_STYLES[function]='fg=#c2beb8'
ZSH_HIGHLIGHT_STYLES[string]='fg=#609272'                # strings → sage green
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#609272'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#609272'
ZSH_HIGHLIGHT_STYLES[path]='fg=#d2b272'                  # paths → warm gold
ZSH_HIGHLIGHT_STYLES[option]='fg=#c2beb8'                # flags → bone
ZSH_HIGHLIGHT_STYLES[comment]='fg=#504c58'               # comments → void

# -----------------------------
# Autosuggestions
# -----------------------------
source ~/.local/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#504c58"
bindkey '^ ' autosuggest-accept   # Ctrl+Space to accept suggestion

# -----------------------------
# Aliases
# -----------------------------
alias zen="/home/seramaro/Apps/zen/zen"
alias ls="/home/seramaro/Apps/ezaa/eza --icons=always -ah"
alias die="clear && ff"
alias mat="/home/seramaro/Apps/cmatrix/cmatrix"
alias xo="/home/seramaro/Apps/nvim-linux-x86_64/bin/nvim"
alias ff="/home/seramaro/Apps/fastfetch"
alias glow="/home/seramaro/Apps/glow/glow"
alias 42="cd ~/AXL/"
alias cya="ft_lock"
alias ghostty="/home/seramaro/Apps/Ghostty-1.3.1-x86_64.AppImage"
alias play="cd /home/seramaro/Apps && python3 minicava.py"
alias weza="curl wttr.in/antananarivo"
alias bye="kill SIGINT -1"
alias grep='grep --color=auto'
alias py="python3.13"
alias obsidian="/home/seramaro/Apps/Obsidian-1.12.7.AppImage"
alias conky="/home/seramaro/Apps/conky-ubuntu-22.04-x86_64-v1.23.0-release.AppImage -c /home/seramaro/.config/conky/config.conf"

# -----------------------------
# Environment
# -----------------------------
export USER=seramaro
export MAIL="seramaro@student.42antananarivo.mg"

# base PATH
export PATH="/usr/local/bin:/usr/bin:/bin:$HOME/.local/bin:$HOME/bin:$PATH"

export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin:$HOME/.local/go/bin"

export PKG_CONFIG_PATH="$HOME/.local/lib/pkgconfig:$PKG_CONFIG_PATH"
export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"

PROMPT=$'%F{#505468}%~%f\n%F{#e8f0ff}❯ %f'

# -----------------------------
# pyenv
# -----------------------------
export PYENV_ROOT="/opt/pyenv"
export PYENV_SKIP_REHASH=1
export PATH="$PYENV_ROOT/bin:$PATH"

export PATH="$PATH:$HOME/AXL/git_utils"

pyenv() {
  unset -f pyenv
  eval "$(command pyenv init -)" 2>/dev/null
  pyenv "$@"
}

# -----------------------------
# nvm (stable Node)
# -----------------------------
export NVM_DIR="$HOME/.nvm"
__load_nvm() {
  unset -f __load_nvm nvm node npm npx corepack
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
}

nvm() { __load_nvm; nvm "$@"; }
node() { __load_nvm; command node "$@"; }
npm() { __load_nvm; command npm "$@"; }
npx() { __load_nvm; command npx "$@"; }
corepack() { __load_nvm; command corepack "$@"; }

# -----------------------------
# Terminal title
# -----------------------------
set_win_title() {
  print -Pn "\e]0;%n@%m:%~\a"
}
precmd_functions+=(set_win_title)

# -----------------------------
# fastfetch (startup)
# -----------------------------
[[ -x /home/seramaro/Apps/fastfetch ]] && /home/seramaro/Apps/fastfetch
export FLATPAK_USER_DIR=/home/seramaro/goinfre/flatpak
export PATH="/home/seramaro/goinfre:$PATH"
export FLATPAK_USER_DIR=/home/seramaro/goinfre/flatpak
export EDITOR="xo"
export FLATPAK_USER_DIR=/goinfre/$USER/flatpak

# Germinette PATH
export PATH="$HOME/.local/bin:$PATH"

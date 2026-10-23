# Created by newuser for 5.9

# ---------- History ----------
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000          # entries kept in memory
SAVEHIST=50000          # entries written to the file
setopt SHARE_HISTORY          # share history live across terminals (implies INC_APPEND_HISTORY)
setopt EXTENDED_HISTORY       # store timestamps + duration
setopt HIST_IGNORE_DUPS       # skip consecutive duplicates
setopt HIST_IGNORE_SPACE      # commands starting with a space aren't saved
setopt HIST_REDUCE_BLANKS

# ---------- Vi mode (starts in insert mode) ----------
bindkey -v
export KEYTIMEOUT=1           # default 40 = 0.4s lag after pressing Esc
bindkey '^?' backward-delete-char   # backspace past the point where insert started
bindkey '^H' backward-delete-char
bindkey '^R' history-incremental-search-backward  # keep Ctrl-R in insert mode

# Cursor shape: blinking block = insert, steady block = normal
function zle-keymap-select {
  case $KEYMAP in
    vicmd) print -n '\e[2 q' ;;   # steady block
    *)     print -n '\e[1 q' ;;   # blinking block
  esac
}
function zle-line-init { zle -K viins; print -n '\e[1 q' }
zle -N zle-keymap-select
zle -N zle-line-init

# ---------- Prompt: directory + git branch on line 1, arrow on line 2 ----------
autoload -Uz vcs_info add-zsh-hook
setopt PROMPT_SUBST
add-zsh-hook precmd vcs_info

git_icon=$'\uec6f'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats " (%F{magenta}${git_icon} %b%f)"
zstyle ':vcs_info:git:*' actionformats " (%F{magenta}${git_icon} %b|%a%f)"

# aliases

# gcc
c99() {
    local src="$1"
    shift
    gcc -std=c99 -Wall -Wextra -Wpedantic "$src" "$@" -o main -lm
}

# zathura pdf viewer
zt() { setsid -f zathura "$@" >/dev/null 2>&1; }

PROMPT='%F{blue}%~%f${vcs_info_msg_0_}
%F{15}➜%f '

# ---------- PATH ----------
export PATH="$HOME/.local/bin:$PATH"

# bun completions
[ -s "/home/hisyam/.bun/_bun" ] && source "/home/hisyam/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

alias proj="cd /home/hisyam/Personal/projects/"

# go
export PATH="$PATH:$(go env GOPATH)/bin"

# ---------- Plugins (syntax-highlighting must be sourced last) ----------
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

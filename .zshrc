################## PROMPT ##################
# Enable colors and change prompt:
autoload -U colors && colors

git_prompt() {
    local branch="$(git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3)"
    local branch_truncated="${branch:0:30}"
    if (( ${#branch} > ${#branch_truncated} )); then
        branch="${branch_truncated}..."
    fi

    [ -n "${branch}" ] && echo " ( ${branch})"
}
setopt PROMPT_SUBST
autoload -Uz promptinit; promptinit
PROMPT='%B%{$fg[blue]%}%~%{$fg[green]%}$(git_prompt) %{$reset_color%}$prompt_newline➜%b '
# PROMPT='%B%{$fg[blue]%}%~%{$fg[green]%}$(git_prompt) %{$reset_color%}➜%b '
# PROMPT='%B%{$fg[blue]%}%~%{$fg[green]%}$(git_prompt) %{$reset_color%}➜%b '
# PROMPT='%B%{$fg[red]%}[%{$fg[white]%}%n%{$fg[blue]%}@%{$fg[white]%}%M %{$fg[blue]%}%~%{$fg[red]%}]%{$fg[green]%}$(git_prompt) %{$reset_color%}%(?.$.%{$fg[red]%}$)%b '
# PROMPT="%B%{$fg[red]%}[%{$fg[white]%}%n%{$fg[blue]%}@%{$fg[white]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$fg[red]%}$(git_prompt)%{$reset_color%} %(?.$.%{$fg[red]%}$)%b"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin
export IDEA=HOME"/opt/idea-IU-233.11799.241"
export PATH=$PATH:$IDEA_HOME/bin
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit

################# VI-MODE #################
bindkey -v
# export KEYTIMEOUT=1
# # Change cursor shape for different vi modes.
function zle-keymap-select {
    case $KEYMAP in
        vicmd) echo -ne '\e[2 q';;      # block
        viins|main) echo -ne '\e[1 q';; # beam
    esac
}

function yy() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
	cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[1 q"
}
# echo -ne '\e[1 q' # Use beam shape cursor on startup.

zle -N zle-keymap-select
zle -N zle-line-init
# preexec() { echo -ne '\e[1 q' ;} # Use beam shape cursor for each new prompt.

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/hisyam/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Prompt zsh
autoload -Uz promptinit
promptinit

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

################## KEYMAPPING ##################
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# run fastfetch on terminal startup
# fastfetch

################## ALIASES ##################
alias appname="xprop WM_CLASS"
alias wifion="nmcli radio wifi on"
alias wifioff="nmcli radio wifi off"
alias ls="ls --color=auto"
alias kctl="kubectl"
## Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
## confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'
## easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB
# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'
# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'
## config
alias zshrc="nvim ~/.zshrc"
alias nvimrc="cd ~/.config/nvim"
alias polybarrc="cd ~/.config/polybar"
alias bspwmrc="cd ~/.config/bspwm"
alias sxhdkdrc="cd ~/.config/sxhkd"
alias dunstrc="cd ~/.config/dunst"
alias picomrc="nvim ~/.config/picom.conf"
alias weztermrc="cd ~/.config/"
alias kittyrc="cd ~/.config/kitty"
alias yzrc="cd ~/.config/yazi/"
alias rofirc="cd ~/.config/rofi/"
alias dotfiles="cd ~/dotfiles/dotfiles"
## run docker with privileges
alias docker="sudo docker"
alias docker-compose="sudo docker-compose"
## makefile
alias make="sudo make"
alias sudo-nvim="sudo -E -s nvim"
## shortcut
alias myprojects="cd ~/Personal/projects"
alias start-pgadmin="python3 -m venv pgadmin4;source pgadmin4/bin/activate"
## reload polybar
alias reload-polybar="cd ~/.config/polybar/ && sh launch.sh &"
## kill port
killport() {
  kill $(lsof -t -i:"$1")
}

with_env () {
  eval "$(grep -vE '^#' "$1" | xargs)" "${@:2}"
}

crun() {
    flags="$2"

    if [[ -n "$flags" ]]; then
        gcc "$1" $flags -o temp_program && ./temp_program && rm -f temp_program
    else
        gcc "$1" -o temp_program && ./temp_program && rm -f temp_program
    fi
}

source /home/hisyam/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/hisyam/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# eval "$(fnm env --use-on-cd)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/hisyam/Downloads/gcp/google-cloud-sdk/path.zsh.inc' ]; then . '/home/hisyam/Downloads/gcp/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/hisyam/Downloads/gcp/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/hisyam/Downloads/gcp/google-cloud-sdk/completion.zsh.inc'; fi

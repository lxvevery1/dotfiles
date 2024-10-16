#
# ~/.zshrc
#

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%{$fg[magenta]%}%~%{$fg[white]%}%{$reset_color%}%b > "                                                 # Only Path
# PS1="%}[%{$fg[yellow]%}%n %{$fg[magenta]%}%~%{$fg[white]%}]%{$reset_color%}$%b > "                        # Path + UserName
# PS1="%}[%{$fg[yellow]%}%n%{%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[white]%}]%{$reset_color%}$%b > "    # Path + UserName + OSname
PS2=" > "
# If not running interactively, don't do anything
# [[ $- != *i* ]] && return

# Icons path
source "/home/stanik/.config/lf/icons"
# Aliases path
source "/home/stanik/.config/aliasrc"

# Custom config path
export XDG_CONFIG_HOME="/home/stanik/.config"

export FrameworkPathOverride="/lib/mono/4.7.2-api"

# Default editor
export EDITOR=/sbin/nvim

# Omnisharp PATH
# export PATH=$PATH:"/home/stanik/.cache/omnisharp-vim/OmniSharp/omnisharp"

# Keyboard input read rate
xset r rate 250 50

# fzf init
eval "$(fzf --zsh)"
# zoxide init
eval "$(zoxide init --cmd cd zsh)"

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
# bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey '^?' backward-delete-char
bindkey '^[[3~' delete-char

# Use lf to switch directories and bind it to ctrl-o
# lfcd () {
#     tmp="$(mktemp)"
#     lf -last-dir-path="$tmp" "$@"
#     if [ -f "$tmp" ]; then
#         dir="$(cat "$tmp")"
#         rm -f "$tmp"
#         [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
#     fi
# }
# bindkey -s '^o' 'lfcd\n'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
bindkey -s '^o' 'y\n'


# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
# [ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
# [ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets pattern cursor)

# Default terminal
export TERMINAL=kitty

# Chat GPT KEY
source /home/stanik/Documents/exec/chatgpt-key

parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}
COLOR_DEF='%f'
COLOR_USR='%F{243}'
COLOR_DIR='%F{208}'
COLOR_GIT='%F{196}'
# About the prefixed `$`: https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_03.html#:~:text=Words%20in%20the%20form%20%22%24',by%20the%20ANSI%2DC%20standard.
NEWLINE=$'\n'
# Set zsh option for prompt substitution
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n@%M ${COLOR_DIR}%d ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}${NEWLINE} > '


source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

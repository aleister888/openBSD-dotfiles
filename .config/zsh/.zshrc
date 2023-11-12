# aleister888 zsh config file

source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
source ~/.config/zsh/ohmyzsh/dirhistory.plugin.zsh

bindkey -e

# aliases
source $HOME/.config/zsh/aliasrc
#source $HOME/.sshalias
#compiling
function smk() { sudo make install }
function smu() { sudo make uninstall }

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# delete till word-break
autoload -U select-word-style
select-word-style bash

# lf switching directories
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# history file location
HISTSIZE=100
SAVEHIST=100
HISTFILE=/tmp/zsh_history

bindkey  "^[[3~"  delete-char

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

function get_local_ip {
	if [ "$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | tail -1 | awk '{print $2}' 2>&1)" = "127.0.0.1" ]; then
		echo "NO CONNECTION"
	else
		if [ "$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep 192.168 | awk '{print $2}' 2>&1)" = "" ]; then
			ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | tail -1 | awk '{print $2}'
		else
			ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep 192.168 | awk '{print $2}'
		fi
	fi | tail -n 1
}

function get_time {
	date +'%H:%M'
}

setopt promptsubst

PROMPT="%B%F{red}[%f%b%B%F{yellow}%n%f%b%B%F{green}@%f%b%B%F{blue}%m%f%b %B%F{magenta}%~%f%b%B%F{red}] "
RPROMPT='%F{red}[%F{yellow}$(get_time)%F{green}/%F{blue}$(get_local_ip)%F{red}]'

printf '\033[?1h\033=' >/dev/tty

pfetch

# Plugins
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
source ~/.config/zsh/ohmyzsh/dirhistory.plugin.zsh

bindkey -e

# Aliases
source $HOME/.config/zsh/aliasrc
source $HOME/.config/ssh_hosts

# Autocompletación con TAB
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Incluir archivos ocultos

# Tipo de autocompletación
autoload -U select-word-style
select-word-style bash

# Cambiar directorios con lf
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

# Historial en directorio temporal
HISTSIZE=256
SAVEHIST=128
HISTFILE=/tmp/zsh_history

# Bindings de teclado
bindkey  "^[[3~"  delete-char

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Funcion para imprimir la dirección IP local en el prompt
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

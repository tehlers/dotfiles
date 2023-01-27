setopt nobeep auto_cd complete_in_word correct rm_star_wait cdable_vars transient_rprompt append_history extended_history hist_no_store hist_ignore_all_dups
eval `dircolors`

PROMPT='%n@%m:%7~%1(j. (%j%).)%# '

export EDITOR=vim
export PAGER=less

autoload -U compinit && compinit

autoload -Uz vcs_info

precmd() {
  psvar=()
  vcs_info
  [[ -n $vcs_info_msg_0_ ]] && psvar[1]="$vcs_info_msg_0_"
}

zstyle ':vcs_info:*' formats "(%s)[%b]"
zstyle ':vcs_info:*' actionformats "(%s|%a)[%b]"
RPROMPT="%(1v.%F{green}%1v%f.)"

# History
HISTFILE=~/.zsh_history
SAVEHIST=100000
HISTSIZE=120000

# Menu completion
zmodload -i zsh/complist
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:kill:*' command 'ps xf -u $USER -o pid,%cpu,cmd'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

for k in ${(k)key} ; do
    # $terminfo[] entries are weird in ncurses application mode...
    [[ ${key[$k]} == $'\eO'* ]] && key[$k]=${key[$k]/O/[}
done
unset k

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Emacs-like history
bindkey '^R' history-incremental-search-backward

# Vi-Keybindings
bindkey -v

# Host-specific configuration
source $HOME/.zshrc.local 

# Kubectl completion
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/mcli mc

if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

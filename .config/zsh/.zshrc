#!/bin/sh
bindkey "^[[3~" delete-char #seriously zsh, when i press Delete, I MEAN DELETE!
bindkey -r "^H"
bindkey -r "^J"
bindkey -r "^K"
bindkey -r "^L"
bindkey -r "^Z"
zle_highlight=("paste:none")
unsetopt beep
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef

(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

zstyle ":completion:*" menu select
zstyle ":completion:*:*:git:*" script $ZDOTDIR/git-completion.bash
fpath=($ZDOTDIR $fpath)
autoload -Uz compinit && compinit
zmodload zsh/complist
_comp_options+=(globdots)

autoload -Uz colors && colors

source "$HOME/.config/zsh/zshfunc"

zsh_add_file "aliases"
zsh_add_file "local_aliases"
zsh_add_file "prompts/c-at-m"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
#I want to start in tmux, and exit when I'm done!!!! I'm lazy!!!!
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

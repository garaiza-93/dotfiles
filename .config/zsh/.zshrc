unsetopt beep
bindkey -v
zstyle :compinstall filename '/home/gustavo/.zshrc'
autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/zcompdump-$ZSH_VERSION

#Terminal
export TERM=alacritty

if [ -f $ZDOTDIR/.zsh_aliases ]; then
  source $ZDOTDIR/.zsh_aliases
fi

#I want to start in tmux, and exit when I'm done!!!! I'm lazy!!!!
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi



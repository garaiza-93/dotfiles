unsetopt beep
bindkey -v
zstyle :compinstall filename '.config/zsh/.zshrc'
zstyle ':completion:*:git:*' script ./git-completion.bash
autoload -U compinit
zmodload -i zsh/complist
compinit -C -d $XDG_CACHE_HOME/zcompdump-$ZSH_VERSION

fpath=($ZDOTDIR $fpath)
#Terminal
export TERM=alacritty

if [ -f $ZDOTDIR/.zsh_aliases ]; then
  source $ZDOTDIR/.zsh_aliases
fi

#I want to start in tmux, and exit when I'm done!!!! I'm lazy!!!!
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi



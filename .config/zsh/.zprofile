#
# ~/.zprofile
#
HISTSIZE=1000
SAVEHIST=1000
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export ZSH_COMPDUMP='$HOME/.cache/zcompdump-$ZSH_VERSION'
export EDITOR=/usr/bin/nvim
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export __GL_SHADER_DISK_CACHE_PATH=$XDG_CACHE_HOME
export HISTFILE="$XDG_CACHE_HOME/zsh_history"
export LESSHISTFILE="$XDG_CACHE_HOME/less_history"
export NODE_REPL_HISTORY="$XDG_CACHE_HOME/node_repl_history"
export GNUPGHOME="$HOME/.local/share/gnupg"
export WINEPREFIX="$HOME/.local/share/wine"
export TERM=alacritty

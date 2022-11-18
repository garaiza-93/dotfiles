#!/bin/bash

#clean temp
if [ -d "~/temp_dotfiles_install" ]; then rm -r ~/temp_dotfiles_install; fi
#0. detect repo to install openssl. makes life easier
REPO_ID=`cat /etc/*-release | grep ^ID_LIKE=`

case $REPO_ID in #feel free to add more distros to this statement, i"m only including what i use
  *ubuntu*)
    UPDATECMD=$(sudo apt update && sudo apt upgrade -y)
    INSTALLCMD=$(sudo apt install libssl-dev autotools-dev automake pkg-config bison -y)
  ;;
  *arch* | *manjaro*)
    UPDATECMD=$(sudo pacman -Sy)
    INSTALLCMD=$(sudo pacman --needed --quiet -S openssl) #sorry, not a hands-off approach. the tradeoff of rolling release distros.
  *nix*)
    UPDATECMD=$(sudo nix-env -u)
    INSTALLCMD=$(sudo nix-env -iA nixos.openssl)
  ;;
  #and so on...
esac

$UPDATECMD
$INSTALLCMD
sudo -k

mkdir ~/temp_dotfiles_install
cd ~/temp_dotfiles_install
#1. install dependencies (libevent, ncurses)
echo "Finding latest libevent"
wget --no-check-certificate -q "https://libevent.org/" -O libevent.out
LIBEVENT=`grep -Pom 1 "(?<=>libevent-)[\d\.]+(?=-stable\.tar\.gz)" libevent.out`
rm libevent.out

echo "Finding latest ncurses library"
wget --no-check-certificate -q "https://invisible-mirror.net/archives/ncurses/?C=M;O=D" -O ncurses.out
NCURSES=`grep -Pom 1 "(?<=>ncurses-)[\d\.]+(?:\w)(?=\.tar\.gz)" ncurses.out`
rm ncurses.out

echo "Installing libevent version $LIBEVENT"
wget -q https://github.com/libevent/libevent/releases/download/release-$LIBEVENT-stable/libevent-$LIBEVENT-stable.tar.gz
tar xvzf libevent-$LIBEVENT-stable.tar.gz
cd libevent-$LIBEVENT-stable
echo 'in libevent dir'
./configure --prefix=$HOME/.local --disable-shared
make -j
make install
cd ..

echo "Installing ncurses version $LIBEVENT"
wget -q https://invisible-mirror.net/archives/ncurses/ncurses-$NCURSES.tar.gz
tar xvzf ncurses-$NCURSES.tar.gz
cd ncurses*/
echo 'in ncurses dir'
./configure --prefix=$HOME/.local
make -j 
make install 
cd ..

#2. install tmux
echo "Finding latest tmux"
wget --no-check-certificate -q "https://github.com/tmux/tmux/tags" -O tmux.out
TMUX=`grep -Pom 1 "[\d\.]+(?:\w)(?=\.tar\.gz)" tmux.out`
rm tmux.out

echo "Installing tmux version $TMUX"
wget --output-document=tmux-${TMUX}.tar.gz -q https://github.com/tmux/tmux/archive/refs/tags/${TMUX}.tar.gz
tar xvzf tmux-${TMUX}.tar.gz
cd tmux-${TMUX}
sh ./autogen.sh
./configure CFLAGS="-I$HOME/.local/include -I$HOME/.local/include/ncurses" LDFLAGS="-L$HOME/.local/lib -L$HOME/.local/include/ncurses -L$HOME/.local/include" CPPFLAGS="-I$HOME/.local/include -I$HOME/.local/include/ncurses" LDFLAGS="-static -L$HOME/.local/include -L$HOME/.local/include/ncurses -L$HOME/.local/lib" 
make -j
cp -f tmux $HOME/.local/bin
cd ..

#3. install zsh
#4. sudo echo "export ZDOTDIR="$HOME/.config/zsh"" > /etc/zsh/zshenv
#5. clone repo, but bare. see https://www.atlassian.com/git/tutorials/dotfiles
#6. if all goes well, repo files should go in their right spot!

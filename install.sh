#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage:"
  echo "  install.sh [distro] [options]"
  echo " "
  echo "Example:"
  echo "  install.sh pop aiml"
  exit
fi

# start installing
sudo apt install -y guake
guake &
sudo apt install -y code flex bison llvm llvm-dev llvm-14-examples python3 cmake clang libc++-dev
sudo apt install -y chrome-gnome-shell
if [ $1 == "pop" ]; then
  sudo apt install gnome-shell-extensions -y
fi

# misc
sudo apt install dia -y
sudo apt install -y libgtk-4-1 libgtk-4-dev libgtk-4-doc gtk-4-examples
sudo apt install retext -y

#dev
sudo apt install -y qemu doxygen graphviz meld
sudo snap install flutter --classic
sudo apt install -y android-sdk android-sdk-helper
sudo snap install android-studio --classic
flutter config --enable-web
sudo apt install -y npm
wget https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip
#extract
export CHROME_EXECUTABLE=/usr/bin/chrome-gnome-shell

sudo apt install -y virtualbox-guest-x11

# qt
sudo apt install -y qtcreator

# snaps
sudo snap install pycharm-community --classic
sudo apt install -y python3-pip

#aiml
if [ $2 == "aiml" ]; then
  lastconda=$(wget -l1 -np -nd  "https://repo.anaconda.com/archive/" -O - | grep -Po "\".*Linux-x86_64\.sh\"" | sort -u | tail -1)
  lastconda=${lastconda#*\"}
  lastconda=${lastconda%\"*}
  echo -n "Last Anaconda = "
  echo $lastconda
  wget -l1 -np -nd  "https://repo.anaconda.com/archive/$lastconda"
  sudo chmod +x $lastconda
  ./$lastconda -b -p ~/anaconda3
  sudo apt install -y jupyter-notebook
  
  #ros
  sudo apt install -y ros-robot ros-desktop-full-dev
fi

# Aliases for git
echo 'alias glo="git log --oneline"' >> ~/.bash_aliases
echo 'alias gs="git status"' >> ~/.bash_aliases
echo 'alias gd="git diff"' >> ~/.bash_aliases
echo 'alias gpa="git patch apply"' >> ~/.bash_aliases
echo 'alias gch="git checkout"' >> ~/.bash_aliases
echo 'alias gc="git commit"' >> ~/.bash_aliases
source ~/.bash_aliases


#!/bin/bash
# Setup dotfiles using symlinks to home directory, and git config
# Rajesh Raheja
# October 2015

echo Getting latest version of files...
git pull origin master

for dotfile in * .[^.] .??*
do
  if [ $dotfile != ".git" ] && 
     [ $dotfile != ".[^.]" ] && 
     [ $dotfile != ".??*" ] && 
     [ $dotfile != "README.md" ] &&
     [ $dotfile != "LICENSE" ] &&
     [ $dotfile != "setup.sh" ]
  then
  	if [ -f ~/"$dotfile" ] || [ -d ~/"$dotfile" ] 
	then 
		if [ -h ~/"$dotfile" ]
		then
			echo Removing existing link ~/"$dotfile"
			rm -f ~/"$dotfile"
		else
			echo Backing up existing ~/"$dotfile"
			mv ~/"$dotfile" ~/"$dotfile".bak
		fi
	fi

  	if [[ "$1" != "-d" ]]
	then 
		echo Linking `pwd`/$dotfile to "$HOME"/$dotfile
		ln -s `pwd`/$dotfile "$HOME"/$dotfile
	fi
  else
    	echo Skipping $dotfile
  fi
done

echo Linking .ssh to Dropbox folder ~/Documents/Dropbox/.ssh
ln -s ~/Documents/Dropbox/.ssh "$HOME"/.ssh

osname=`uname`
if [[ "$osname" == 'Darwin' ]]; then
	echo Install remaining applications and tools using scripts in the scripts folder.
elif [[ "$osname" == 'Linux' ]]; then
	echo Start conky using : conky -c ~/.conky/conkyrc &
	echo Start x11vnc using: ssh -t -L 5900:localhost:5900 'x11vnc -localhost -display :0'
fi

echo Dotfiles setup complete on `date`.

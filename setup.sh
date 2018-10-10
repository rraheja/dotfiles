#!/bin/bash
# Setup dotfiles using symlinks to home directory, and git config
# Rajesh Raheja
# September 2018

cd ~/Github/dotfiles

for dotfile in * .[^.] .??*
do
  if [ $dotfile != ".git" ] && 
     [ $dotfile != ".[^.]" ] && 
     [ $dotfile != ".??*" ] && 
     [ $dotfile != "README.md" ] &&
     [ $dotfile != "LICENSE" ] &&
     [ $dotfile != "setup.sh" ]
  then
  	if [ -h $HOME/"$dotfile" ] || [ -f $HOME/"$dotfile" ] || [ -d $HOME/"$dotfile" ] 
	then 
		if [ -h $HOME/"$dotfile" ]
		then
			echo Removing existing link $HOME/"$dotfile"
			rm -f $HOME/"$dotfile"
			mv $HOME/"$dotfile".bak $HOME/"$dotfile"
		else
			echo Backing up existing $HOME/"$dotfile"
			mv $HOME/"$dotfile" $HOME/"$dotfile".bak
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

echo Linking .ssh folder
mv "$HOME"/.ssh "$HOME"/.ssh.bak
ln -fs $HOME/Documents/Google\ Drive/Software/ssh "$HOME"/.ssh

osname=`uname`
if [[ "$osname" == 'Darwin' ]]; then
	echo Install remaining applications and tools using scripts in the "workstation" repo.
elif [[ "$osname" == 'Linux' ]]; then
	echo Start conky using : conky -c $HOME/.conky/conkyrc &
	echo Start x11vnc using: ssh -t -L 5900:localhost:5900 'x11vnc -localhost -display :0'
fi

echo Dotfiles setup complete on `date`.
exit 0

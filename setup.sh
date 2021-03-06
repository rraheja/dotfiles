#!/bin/bash
# Setup dotfiles using symlinks to home directory, and git config
# Rajesh Raheja
# July 2019

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

# Removing auto setup of ssh to avoid security issues
# if [ -d $HOME/Google\ Drive ]
# then
#	echo Linking .ssh folder from Google Drive
#	mv "$HOME"/.ssh "$HOME"/.ssh.bak
#	ln -fs $HOME/Google\ Drive/Software/ssh "$HOME"/.ssh
# else
#	echo Google Drive not installed. Skipping linking of .ssh
# fi

osname=`uname`
if [[ "$osname" == 'Darwin' ]]; then
	echo Install remaining applications and tools using scripts in the "workstation" repo.
elif [[ "$osname" == 'Linux' ]]; then
	echo Start conky using : conky -c $HOME/.conky/conkyrc &
	echo Start x11vnc using: ssh -t -L 5900:localhost:5900 'x11vnc -localhost -display :0'
fi

echo Dotfiles setup complete on `date`.
exit 0

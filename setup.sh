#!/bin/bash
# Setup dotfiles using symlinks to home directory
# Rajesh Raheja 08/09/2013

echo ==== Getting latest version of files
git pull origin master

for dotfile in * .[^.] .??*
do
  if [ $dotfile != ".git" ] && 
     [ $dotfile != ".[^.]" ] && 
     [ $dotfile != ".??*" ] && 
     [ $dotfile != "README.md" ] &&
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

echo Start conky using : conky -c ~/.conky/conkyrc &
echo Start x11vnc using: ssh -t -L 5900:rraheja-nas.local:5900 'x11vnc -localhost -display :0'

echo Dotfiles setup complete on `date`.

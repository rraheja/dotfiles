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
		echo Backing up existing ~/"$dotfile"
		mv ~/"$dotfile" ~/"$dotfile".bak
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

echo Dotfiles setup complete on `date`.

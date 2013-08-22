#!/bin/bash
# Setup dotfiles using symlinks to home directory, and git config
# Rajesh Raheja 08/21/2013

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

# Setup git
echo Setting up Git global configuration.
git config --global user.name  "Rajesh Raheja"
git config --global user.email "rajesh.raheja@gmail.com"
git config --global credential.helper 'cache --timeout=3600'
git config --global push.default simple
git config --global http.proxy  $http_proxy
git config --global https.proxy $https_proxy
git config --global no.proxy    $no_proxy
git config --global --list

echo Start conky using : conky -c ~/.conky/conkyrc &
echo Start x11vnc using: ssh -t -L 5900:rraheja-nas.local:5900 'x11vnc -localhost -display :0'

echo Dotfiles setup complete on `date`.

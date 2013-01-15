#!/bin/bash
#
# Install dotfiles by soft linking them to their original program locations
#
# Rajesh Raheja
#
# Note that "shopt -s dotglob" would also work but make this bash specific.
# Instead, the combination below matches all dotfiles two characters and above
# and specifically ignores ".."
# If a two character file starting with "." does not exist e.g. ".a" then
# a hard coded .[^.] listing is produced which is then filtered out.
#
# Note that in Windows the soft link will effectively copy the file.

if [ "$1" == "-h" ]
then
	echo Dotfiles by Rajesh Raheja
	echo Usage: ./install.sh [-d]
	exit;
fi


if [ ! -d "$HOME" ]
then
	echo Cannot find directory "$HOME"
	exit 1;
else
	echo Installing dotfiles in "$HOME"
fi

for dotfile in * .[^.] .??*
do
  if [ $dotfile != ".git" ] && 
     [ $dotfile != ".[^.]" ] && 
     [ $dotfile != ".??*" ] && 
     [ $dotfile != "README.md" ] &&
     [ $dotfile != "install.sh" ]
  then
  	if [ -f "$HOME"/$dotfile ]
	then 
		echo Removing "$HOME"/$dotfile
		rm "$HOME"/$dotfile 2>/dev/null 
	fi

  	if [ -d "$HOME"/$dotfile ]
	then 
		echo Removing directory "$HOME"/$dotfile
		rm -rf "$HOME"/$dotfile 2>/dev/null 
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

# Copy gVim startup files to program directory if on Windows

if [ "$OS" == "Windows_NT" ] && [[ "$1" != "-d" ]]
then
	echo Copying "$HOME"/.vimrc to "/c/Program Files (x86)/Vim/_vimrc"
	cp "$HOME"/.vimrc "/c/Program Files (x86)/Vim/_vimrc"
fi

# Finished

if [ "$1" != "-d" ]
then
	echo "Dotfiles successfully installed."
else
	echo "Dotfiles successfully uninstalled."
fi

sudo ./scripts/setup_filesharing.sh
./scripts/setup_git.sh

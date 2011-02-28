DotFiles
========

Description
-----------

These are utility scripts and configuration files that make development productive. Feel free to fork if it is useful.

Installation
------------
To install on any new development machine (replace "rraheja" with username if forked):

> git clone git://github.com/rraheja/dotfiles ~/.dotfiles
> cd ~/.dotfiles
> install.sh

Windows considerations
----------------------
1. Use of msysGit is required.
2. Windows scripts require various PortableApps applications as well as Truecrypt and Microsoft Robocopy.
3. On Windows, scripts are "copied" and not soft linked, hence source of truth is still the projects/dotfiles. Make any changes to the dotfiles and redeploy the changes using install.sh

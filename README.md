dotfiles
========

Description
-----------

These are utility scripts and configuration files that make development productive. Feel free to fork if it is useful.

Install
-------
To install on any new development machine (replace "rraheja" with username if forked):

> git clone git://github.com/rraheja/dotfiles ~/dotfiles
> cd ~/dotfiles
> install.sh

UnInstall
---------

To uninstall:

> cd ~/dotfiles
> install.sh -d


Windows considerations
----------------------
1. Use of msysGit is assumed on Windows.
2. On Windows, scripts are "copied" and not soft linked, hence any changes made to the dotfiles should be redeployed using install.sh
3. Windows scripts require various PortableApps applications as well as Truecrypt and Microsoft Robocopy.

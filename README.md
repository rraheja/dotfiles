dotfiles
========

Description
-----------

These are utility scripts and configuration files that make my development productive.

Install
-------
To install on any new development machine (replace "rraheja" with username if forked):

> git clone --bare git@github.com:rraheja/dotfiles.git ~/gitrepo/dotfiles.git --origin github

> git clone ~/gitrepo/dotfiles.git mywork/dotfiles

> cd mywork/dotfiles

> chmod +x install.sh

> ./install.sh

This sets up the bare repository as the local source of truth, with its "origin" pointing to github.
The "mywork/dotfiles" directory is the working repository with its "origin" pointing to the bare repository. 
Add another remote to be able to sync changes to both the local bare source of truth, as well as github.

> git remote add github git@github.com:rraheja/dotfiles.git

UnInstall
---------

To uninstall and remove broken links:

> cd mywork/dotfiles

> ./install.sh -d

> find ~ -L -type l -delete

Edit
----
Use the bare repository ~/gitrepo/dotfiles.git as the local source of truth

> git pull github master

> git pull

Resolve any conflicts and commit changes.

> git push

> git push github master

> git status

Windows considerations
----------------------
1. Use of msysGit is assumed on Windows.
2. On Windows, scripts are "copied" and not soft linked, hence any changes made to the dotfiles should be redeployed using install.sh

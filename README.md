dotfiles
========

Description
-----------

Configuration files, and their setup scripts, for a productive development environment.

Installation
------------
To install on a new machine, clone the repository under `~/Projects/dotfiles` (or any other location):

Using SSL
```bash
cd ~/Projects && git clone git@github.com:rraheja/dotfiles.git && cd dotfiles && source ./setup.sh
````

Using HTTPS
```bash
cd ~/Projects && git clone https://github.com/rraheja/dotfiles.git && cd dotfiles && source ./setup.sh
````

Using wget

````bash
mkdir -p ~/Projects/dotfiles && cd ~/Projects/dotfiles
wget -O - https://github.com/rraheja/dotfiles.git | tar -xzv --strip-components 1
source ./setup.sh
````
Setup creates symlinks from the home directory to the dotfiles directory, so any updates are immediately effective.
Once dotfiles are installed, install the software applications using the scripts in the "scripts" subdirectory.

UnInstall
---------

To restore setup and remove broken links, simply remove the symlinks:

```bash
cd && find ~ -L -type l -delete
```

dotfiles
========

Description
-----------

Configuration files, and their setup scripts, for a productive development environment.

Installation
------------
To install on a new machine, clone the repository under `~/.dotfiles` (or any other location):

Using SSL
```bash
git clone git@github.com:rraheja/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && ./setup.sh
````

Using HTTPS
```bash
git clone https://github.com/rraheja/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && ./setup.sh
````

Using wget

````bash
mkdir -p ~/.dotfiles && cd ~/.dotfiles
wget -O - https://github.com/rraheja/dotfiles.git | tar -xzv --strip-components 1
./setup.sh
````
Setup creates symlinks from the home directory to the dotfiles directory, so any updates are immediately effective.

*OPTIONAL:* Install software applications for a productive workstation experience using the "workstation" repo.

UnInstall
---------

To restore setup and remove broken links, simply remove the symlinks:

```bash
cd && find ~ -L -type l -delete
```

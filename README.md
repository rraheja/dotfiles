dotfiles
========

Description
-----------

Configuration files, and their setup scripts, for a productive development environment.

Installation
------------
To install on a new machine, clone the repository under `~/Projects/dotfiles` (or any other location):

```bash
cd ~/Projects && git clone https://github.com/rraheja/dotfiles.git && cd dotfiles && source ./setup.sh
````

If `git` is not available (fresh install), use `wget` to retrieve the repository:

````bash
mkdir -p ~/Projects/dotfiles
cd ~/Projects/dotfiles
wget -O - https://github.com/rraheja/dotfiles.git | tar -xzv --strip-components 1
source ./setup.sh
````
Setup creates symlinks from the home directory to the dotfiles directory, so any updates are immediately effective.

UnInstall
---------

To restore setup and remove broken links, simply remove the symlinks:

```bash
cd && find ~ -L -type l -delete
```

#!/bin/bash
# Install apps script -- takes package list file as input
# Rajesh Raheja 08/09/2013

exec > >(tee /tmp/install_packages.log)
exec 2>&1

echo ==== Installing packages in $1

if [ ! -f "$1" ]
then
	echo Package list file $1 not found. No changes done.
	echo Usage: sudo ./install_packages.sh package_list_filename
	exit 1
fi

echo ==== Copying PPA sources and updating repository

aptitude install mintsources

rm -f /etc/apt/sources.list.d/google.list
rm -f /etc/apt/sources.list.d/webmin.list
# Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
# Google Music Manager
echo "deb http://dl.google.com/linux/musicmanager/deb/ stable main" >> /etc/apt/sources.list.d/google.list
# Google Earth
echo "deb http://dl.google.com/linux/earth/deb/ stable main" >> /etc/apt/sources.list.d/google.list
# Webmin
wget -q -O - http://www.webmin.com/jcameron-key.asc | apt-key add -
echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list.d/webmin.list
echo "deb http://webmin.mirror.somersettechsolutions.co.uk/repository sarge contrib" >> /etc/apt/sources.list.d/webmin.list

echo Installing new PPAs. To continue press ENTER.
# NixNote (Evernote for Linux)
add-apt-repository ppa:vincent-c/nevernote
# Handbrake
add-apt-repository ppa:stebbins/handbrake-releases

aptitude update

echo ==== Upgrading system - first a safe-upgrade then full-upgrade to isolate changes
aptitude -y -f --show-deps safe-upgrade
aptitude -y -f --show-deps full-upgrade

echo ==== Installing packages from $1
aptitude install -y -f --without-recommends --show-deps `cat "$1"`

echo ==== Remove packages no longer needed and resolve missing dependencies
aptitude -y --purge-unused autoclean
aptitude -f -y install

echo === Apps installation complete on `date`.

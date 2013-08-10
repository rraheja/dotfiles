#!/bin/bash
# Install apps script -- takes package list file as input
# Rajesh Raheja 08/09/2013

exec > >(tee /tmp/install_packages.log)
exec 2>&1

echo ==== Installing packages in $1

if [ ! -f $1 ]
then
	echo Package list file $1 not found. No changes done.
	echo Usage: sudo ./install_packages.sh <list file containing package names>
	exit 1
fi

echo ==== Copying PPA sources and updating repository
cp -y custom.sources.list /etc/apt/sources.list.d/
aptitude update

echo ==== Upgrading system - first a safe-upgrade then full-upgrade to isolate changes
aptitude -y -f --show-deps safe-upgrade
aptitude -y -f --show-deps full-upgrade

echo ==== Installing packages from $1
aptitude install -y -f --without-recommends --show-deps `cat "$1"`

echo ==== Remove packages no longer needed and resolve missing dependencies
aptitude -y autoclean
aptitude -y --purge-unused
aptitude -f -y --show-deps install

echo === Apps installation complete on `date`.

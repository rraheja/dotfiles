#!/bin/bash
# Install Crashplan script
# Rajesh Raheja 08/09/2013

exec > >(tee /tmp/install_crashplan.log)
exec 2>&1

echo ==== Installing CrashPlan for backups

CRASHPLAN_ARCHIVE="CrashPlan_3.5.3_Linux.tgz"
cd ~/Downloads

if [ ! -f $CRASHPLAN_ARCHIVE ]
then
	echo ==== Downloading archive...
	wget http://download.crashplan.com/installs/linux/install/CrashPlan/"$CRASHPLAN_ARCHIVE"
else
	echo ==== Existing archive found...
fi

tar -C ~/Downloads -xzvf $CRASHPLAN_ARCHIVE
cd ~/Downloads/CrashPlan-install

echo ==== Starting CrashPlan install script. Choose data location /mnt/Share/Backups/Crashplan
./install.sh

echo CrashPlan install completed on `date`.

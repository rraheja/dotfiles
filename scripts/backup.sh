#!/bin/bash
# Backup script - backup location can be passed in as first argument.
# Rajesh Raheja 08/21/2013

HOSTNAME=`hostname`
BACKUPDIR=${1:-rraheja@rraheja-nas.local:/mnt/Share/Backups/"$HOSTNAME"}

exec > >(tee /tmp/backup.log)
exec 2>&1

echo Exporting APT keys
apt-key exportall > /etc/apt/repo.keys

echo Archiving /etc configuration files
tar -cvzf "$BACKUPDIR"/backup.tgz -T backup.list --exclude-caches-all --ignore-failed-read

echo Backup complete on `date`.

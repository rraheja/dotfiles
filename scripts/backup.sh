#!/bin/bash
# Backup script - backup location can be passed in as first argument.
# Rajesh Raheja 08/09/2013

HOSTNAME=`hostname`
BACKUPDIR=${1:-rraheja@rraheja-nas.local:/mnt/Share/Backups/"$HOSTNAME"}

exec > >(tee /tmp/backup.log)
exec 2>&1

echo Backing up "$HOSTNAME" homes
rsync -avhRHX --delete --stats /home "$BACKUPDIR" --exclude='Downloads' --exclude='*[Cc]ache' --exclude='nepomuk*' --exclude='.wine' --exclude='.local' --exclude='Trash' --exclude='lost+found'

echo Exporting APT keys
apt-key exportall > /etc/apt/repo.keys

echo Archiving /etc configuration files
tar -cvzf "$BACKUPDIR"/etc.tgz -T backup.list --exclude-caches-all --ignore-failed-read

echo ==== COMMANDS FOR RESTORE
echo Restore home directory: sudo rsync -avHX --stats "$BACKUPDIR"/home /home
echo Restore config files: sudo tar -C / -xvzf "$BACKUPDIR"/etc.tgz

echo Backup complete on `date`.
scp /tmp/backup.log "$BACKUPDIR"

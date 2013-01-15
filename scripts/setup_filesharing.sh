#!/bin/sh
# Run this script using sudo

echo Starting file sharing services FTP and SAMBA.
echo 'anon_root=/scratch/rraheja/downloads' >> /etc/vsftpd/vsftpd.conf
/sbin/service vsftpd restart
/sbin/chkconfig smb on 
/sbin/service smb restart
echo Enter password for SAMBA service -- use same password as Windows to avoid prompts.
smbpasswd -a rraheja

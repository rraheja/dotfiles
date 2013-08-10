scripts
========

Description
-----------

Environment setup for packages and system configuration files.

'backup.sh' archives files listed in 'backup\_files.list' and copies the home directories. It logs the commands for use in restoring the files and archive.

'install\_packages.sh' takes in list file containing packages and installs it. Example package files are install\_nas.list for packages required for a NAS setup, and install\_workstation.list for packages required for a workstation use.

'install\_crashplan.sh' downloads and installs Crashplan.

'setup\_user.sh` performs user setup activities. Execute only after restoring/editing etc configuration files.

* To install a fresh workstation environment, install packages then setup user.

* To install a fresh home server, install packages, restore the etc configuration files, then setup user.

* To restart servers, use the following commands:
```bash
mount -a
service ssh restart
service nfs-kernel-server restart
service vsftpd restart
service pptpd restart
sysctl -p
service xrdp restart
service crashplan restart
service crashplan status
netstat -an | grep ':424.'
testparm
restart smbd
service minidlna restart
service minidlna force-reload
```

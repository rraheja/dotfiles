scripts
========

Description
-----------

Environment setup for packages and system configuration files.

`backup.sh` archives select /etc configuration files and copies the home directories to a backup directory location. It logs the commands to be used for restoration.

`backup_files.list` contains the list of /etc configuration files to backup that is used by the backup shell script.

`install_packages.sh` takes in list file containing packages and installs it.

`install_nas.list` contains packages for a home NAS server setup.

`install_workstation.list` contains packages for development workstation setup.

`install_crashplan.sh` downloads and installs Crashplan.

`custom.sources.list` contains a list of non-official repositories required to install software packages.

`setup_user.sh` performs user setup activities. Execute only after restoring/editing etc configuration files.

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

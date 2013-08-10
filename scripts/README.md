scripts
========

Description
-----------

Environment setup for packages and system configuration files.

`backup.sh` archives home directory and select /etc configuration files listed in `backup_files.list` to a backup directory location. It logs the commands to be used for restoration.

`install_packages.sh` installs packages listed in a specified file e.g. `install_nas.list` (home NAS server setup) or `install_workstation.list` (development workstation setup).

`install_crashplan.sh` downloads and installs Crashplan.

`setup_user.sh` performs user setup activities. Execute only after restoring/editing etc configuration files.

To Install
----------

* For a fresh workstation installation, install packages then setup user.

* For a fresh home server install, install packages, restore the etc configuration files, then setup user.

* Servers for home server install can be restarted using the following commands:
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

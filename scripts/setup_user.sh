#!/bin/bash
# Setup system script
# Rajesh Raheja 08/09/2013

exec > >(tee /tmp/setup_user.log)
exec 2>&1

# Copy certificates to root to enable password-less logins as sudo
mkdir -p /root/.ssh
cp ~/.ssh/id_rsa* /root/.ssh/

# Setup git
echo Setting up Git global configuration.
git config --global user.name  "Rajesh Raheja"
git config --global user.email "rajesh.raheja@gmail.com"
git config --global credential.helper 'cache --timeout=3600'
git config --global push.default simple
git config --global http.proxy  $http_proxy
git config --global https.proxy $https_proxy
git config --global no.proxy    $no_proxy
git config --global --list

if [ -f ~/bin/corkscrew ]
then
	echo Setting up SSH access to Github via corkscrew
	echo "Host github.com" >> ~/.ssh/config
	echo "  ProxyCommand ~/bin/corkscrew $http_proxy 80 %h %p" >> ~/.ssh/config
fi

echo Testing github ssh access...
ssh -T git@github.com

# Setup user for sudo
echo Adding sudo access for user
rm -rf /etc/sudoers.d/rraheja.sudoers.list
echo "rraheja ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/rraheja.sudoers.list
chmod 440 /etc/sudoers.d/rraheja.sudoers.list

# Setup VM user and shared folders
echo ==== Adding user to Virtualbox group for VM support. Changes take effect after logout.
usermod -a -G vboxsf rraheja

echo ==== Linking VM shared folder to home directories
ln -s /media/sf_Documents ~/Documents

# Setup Samba password if server configuration found (using FTP server since /etc/samba probably always exists)
if [ -f /etc/vsftpd.conf ]
then
	echo ==== Setting SAMBA server password. Enter SMB Password and press ENTER.
	smbpasswd -a rraheja
fi

# Setup VPN server password if server configuration found
if [ -f /etc/pptpd.conf ]
then
	echo ==== Setting VPN server password
	read -p "Enter PPTPD Password and press ENTER: " PPTPD_PASSWORD
	sed -i -e "s/CHANGEME/$PPTPD_PASSWORD/g" /etc/ppp/chap-secrets
fi

# Setup CrashPlan server for headless configuration
if [ -f /usr/local/crashplan/conf/ui.properties ]
then
	echo ==== Updating CrashPlan configuration for headless server
	sed -i -e 's/#serviceHost=127\.0\.0\.1/serviceHost=rraheja-nas\.local/g' /usr/local/crashplan/conf/ui.properties
	sed -i -e 's/127\.0\.0\.1/0\.0\.0\.0/g' /usr/local/crashplan/conf/my.service.xml
fi

echo === System setup completed on `date`.

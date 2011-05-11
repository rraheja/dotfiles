@echo off
REM Backup for Windows v2.0 - Rajesh Raheja
REM
REM This script assumes the topology of a Documents directory (sync'ed to Dropbox) and Backups directory (sync'ed to Google Docs).
REM It backs up the local truecrypt container contents to a container in the Backups directory, and zips up PortableApps to Backups.
REM It also backs up the entire NAS drive to external USB HDD (if attached).

echo Starting backup... (pause SyncDocs syncing for reliable backups)

set BAK_DIR=D:\Documents\Archives\Backups
set TC_BIN=D:\Portableapps\Truecrypt\truecrypt.exe
set TC_VOL=D:\Documents\Dropbox\Vault\docvault.tc
set TC_BAK=%BAK_DIR%\docvault.tc
set ZIP_BIN=D:\PortableApps\PortableApps.com\App\7-Zip\7za.exe
set PA_DIR=D:\PortableApps\
set PA_BAK=PortableApps.7z
set RC_BIN=D:\Portableapps\Robocopy\robocopy.exe
set NAS_DIR=\\simpleshare\netfolder
set USB_DIR=M:

echo Backing up TrueCrypt volume...

%TC_BIN% /q /l r /v %TC_VOL% /m rm /c y
start %TC_BIN% /q /l v /v %TC_BAK% /m rm /c y
@ping 127.0.0.1 -n 7 -w 1000 > nul
%RC_BIN% "R:" "V:" -MIR -FFT -R:1 -W:10 -TS -NDL %1 %2 %3
start %TC_BIN% /q /d /f /b

echo Backing up PortableApps archive...

REN %BAK_DIR%\%PA_BAK% %PA_BAK%.tmp
%ZIP_BIN% a -t7z -r -aoa %BAK_DIR%\%PA_BAK% %PA_DIR% -xr!Cache* -xr!*.lock
DEL /F /Q %BAK_DIR%\%PA_BAK%.tmp

echo Local backup complete. Enable Dropbox and SyncDocs syncing to start uploading to the cloud.

echo Backing up NAS to USB HDD...

dir %NAS_DIR%
%RC_BIN% %NAS_DIR% %USB_DIR% -MIR -Z -FFT -R:3 -W:10 -TS -NDL %1 %2 %3
@echo Backup completed on %DATE% %TIME% > %USB_DIR%\Backup.log

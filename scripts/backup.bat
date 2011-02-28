@echo off
REM Backup for Windoes
REM Rajesh Raheja
REM
REM This script uses Microsoft Robocopy to back up the TrueCrypt volume CONTENTS (not the file container) to a NAS
REM Requires that NAs contains the local TrueCrypt volume to be setup once
REM Also backs up the PortableApps directory to NAS and then proceeds to back up the entire NAS drive to external USB HDD (if attached)
REM
REM Robocopy options:
REM
REM -TS  = Show source file timestamps in log ouput.
REM -NDL = Do not show empty directories, instead show full path name for every file on each line.
REM -Z   = Restartable mode. Slower, but network resilient.
REM -FFT = Use Fat File Times with 2 second granularity. Needed for non-NTFS systems e.g. NAS/Linux/FAT.
REM -MIR = Mirror mode. Warning: will delete destination files/folders if they do not exist on source.
REM -S   = Copy Subdirectories, excluding empty ones. To include empty ones, use -E instead.
REM -R   = Retry 3 times in case of failure. Default is 1 million if this is not specified.
REM -W   = Wait 30 seconds between retries.
REM -LOG = Output to log file.
echo -TEE = Display output to console as well as log file.
REM -M   = Only copy files with Archive attribute set, and then unset the attribute. Use if timestamp does not work.
REM -NP  = Do not show progress indicator for percentage complete. Useful if logging to file.
REM -L   = Preview Mode: just list files, do not copy/remove anything.
REM -XD  = Exclude source directories matching pattern
REM -XF  = Exclude source files matching pattern
REM %n   = first is source directory, second is destination directory, rest are additional parameters

REM Configuration Settings

set TC_BIN=D:\portableapps\truecrypt\truecrypt.exe
set RC_BIN=D:\portableapps\robocopy\robocopy.exe
set NAS_DIR=\\simpleshare\netfolder
set TC_VOL=D:\Documents\Dropbox\Vault\docvault.tc
set TC_BAK=%NAS_DIR%\Archives\Vault\docvault.tc
set PA_DIR=D:\PortableApps
set PA_BAK=%NAS_DIR%\Software\PortableApps 
set USB_DIR=M:

echo Backing up TrueCrypt Volume to NAS version of the TrueCrypt Volume

REM List directory so that network drive is established (without this TrueCrypt may not find the NAS volume)
dir %NAS_DIR%


REM Mount local TrueCrypt volume
%TC_BIN% /q /l r /v %TC_VOL% /m rm /c y

REM Mount NAS TrueCrypt volume - needs to be done async using start, otherwise previous command does not return
start %TC_BIN% /q /l v /v %TC_BAK% /m rm /c y

REM Mounting remote volume and drive letter assignment takes a few seconds, so sleeping for 7 seconds
@ping 127.0.0.1 -n 7 -w 1000 > nul

REM Syncing remote volume directories with local directories
%RC_BIN% "R:" "V:" -MIR -FFT -R:1 -W:10 -TS -NDL %1 %2 %3

REM Unmount all TrueCrypt volumes
start %TC_BIN% /q /d /f /b

REM Backup PortableApps to NAS

%RC_BIN% %PA_DIR% %PA_BAK% -MIR -FFT -R:3 -W:10 -TS -NDL -Z -XD Cache -XF *.lock %1 %2 %3
@echo Backup completed on %DATE% %TIME% > %NAS_DIR%\Backup.log

REM Backup NAS to external USB HDD

%RC_BIN% %NAS_DIR% %USB_DIR% -MIR -Z -FFT -R:3 -W:10 -TS -NDL %1 %2 %3
@echo Backup completed on %DATE% %TIME% > %USB_DIR%\Backup.log
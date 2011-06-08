@echo off
REM Backup for Windows v2.0 - Rajesh Raheja
REM
REM This script assumes the topology of a Documents directory (sync'ed to Dropbox) and Backups directory (stored manually to Google Docs).
REM It backs up the local truecrypt container contents to a container in the Backups directory, and zips up PortableApps to Backups.
REM It also backs up the entire NAS drive to external USB HDD (if attached).

echo Starting backup...
set BAK_DIR=N:\Backups
set TC_BIN=C:\Program Files\Truecrypt\truecrypt.exe
set TC_VOL=D:\Documents\Dropbox\Vault\docvault.tc
set TC_BAK=%BAK_DIR%\docvault.tc
set RC_BIN=C:\windows\robocopy.exe

echo Backing up TrueCrypt volume...
%TC_BIN% /q /l r /v %TC_VOL% /m rm /c y
start %TC_BIN% /q /l v /v %TC_BAK% /m rm /c y
@ping 127.0.0.1 -n 7 -w 1000 > nul
%RC_BIN% "R:" "V:" -MIR -FFT -R:1 -W:10 -TS -NDL %1 %2 %3
start %TC_BIN% /q /d /f /b

echo Backing up NAS to USB HDD...
%RC_BIN% \\simpleshare\netfolder M:\ -MIR -Z -FFT -TS -NDL %1 %2 %3
@echo Backup completed on %DATE% %TIME% > M:\Backup.log

REM If zipping is needed, use following command:
REM 7za a -t7z -r -aoa %BAK_DIR%\backup.7z C:\test -xr!Cache* -xr!*.lock

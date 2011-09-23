@echo off
REM Backup for Windows v3.0 - Rajesh Raheja

echo Backing up TrueCrypt volume...
set TC_BIN=C:\Progra~1\Truecrypt\truecrypt.exe
%TC_BIN% /q /l r /v D:\Documents\Dropbox\docs-vault\docvault.tc /m rm /c y
start %TC_BIN% /q /l v /v \\rraheja-nas\MyHome\Backups\docvault.tc /m rm /c y
@ping 127.0.0.1 -n 7 -w 1000 > nul
robocopy "R:" "V:" -MIR -FFT -R:1 -W:10 -TS -NDL %1 %2 %3
start %TC_BIN% /q /d /f /b

echo Backing up NAS to USB HDD...
robocopy \\rraheja-nas\MyHome G:\ -MIR -Z -FFT -TS -NDL %1 %2 %3
echo Backup completed on %DATE% %TIME% > G:\Backup.log

REM If zipping is needed, use following command:
REM 7za a -t7z -r -aoa %BAK_DIR%\backup.7z C:\test -xr!Cache* -xr!*.lock

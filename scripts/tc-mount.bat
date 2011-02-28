@echo off
REM Mount TrueCrypt Volume
REM Rajesh Raheja

REM Configuration Settings

set TC_BIN=D:\portableapps\truecrypt\truecrypt.exe
set TC_VOL=D:\Documents\Dropbox\Vault\docvault.tc

start %TC_BIN% /q background /e /c y /l r /m rm /v %TC_VOL%
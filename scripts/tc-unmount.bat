@echo off
REM UnMount TrueCrypt Volume
REM Rajesh Raheja

REM Configuration Settings

set TC_BIN=D:\portableapps\truecrypt\truecrypt.exe

start %TC_BIN% /b /q /f /d r
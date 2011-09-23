@echo off
REM Backup for Windows v3.0 - Rajesh Raheja

echo Backing up from NAS to Local Drive...
robocopy \\rraheja-nas\MyHome\Videos\Originals D:\Videos\Originals -MIR -FFT -TS -NDL -COPY:T %1 %2 %3
robocopy \\rraheja-nas\MyHome\Videos\Originals D:\Videos\Originals -MIR -FFT -TS -NDL %1 %2 %3
robocopy \\rraheja-nas\MyHome\Backups D:\Backups -MIR -FFT -TS -NDL -COPY:T %1 %2 %3
robocopy \\rraheja-nas\MyHome\Backups D:\Backups -MIR -FFT -TS -NDL %1 %2 %3
@echo Backup completed on %DATE% %TIME% > D:\Videos\Originals\Backup.log

echo Backing up from NAS to Media USB...
robocopy \\rraheja-nas\MyHome E:\ -MIR -FFT -TS -NDL -XD Originals -XD Backups -COPY:T %1 %2 %3
robocopy \\rraheja-nas\MyHome E:\ -MIR -FFT -TS -NDL -XD Originals -XD Backups %1 %2 %3
@echo Backup completed on %DATE% %TIME% > E:\Backup.log

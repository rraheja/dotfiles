echo %date% %time% : "%cd%\mount.bat" >> C:\cp-nas-mount.log 2>&1 

net use /delete M: 2>&1
net use M: \\rraheja-nb\Media /USER:rraheja-nb\guest welcome >> C:\cp-nas-mount.log 2>&1
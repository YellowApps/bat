@echo off
cd %~dp0
title Return Your Access
chcp 65001 > nul
setlocal EnableDelayedExpansion

echo Возврат доступа...

echo Перетягивание прав владельца...
title Перетягивание прав владельца...
takeown /f %SystemDrive%\ /r /d Y
cls
echo Перетягивание прав владельца^:	OK

echo Получение доступа...
title Получение доступа...
icacls %SystemDrive%\ /grant:r %UserName%:F /t

cls
echo Доступ получен.
title Доступ получен.
pause > nul
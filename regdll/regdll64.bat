@echo off
cd %~dp0
chcp 65001 > nul
title RegDLL (64-bit) v0.0.0
setlocal EnableDelayedExpansion

echo Регистрация DLL...
echo.

for %%i in (*.dll) do (
	copy %%i > !windir!\system32
	regsvr32 /s "!windir!\system32\%%i"
	if !errorlevel! equ 0 (
		echo %%i		OK
	) else (
		echo %%i		ERROR
	)
)

echo.
echo Нажмите любую клавишу для перезагрузки...
pause > nul
shutdown /r /t 0
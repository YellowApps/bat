@echo off
cd %~dp0
title MAKE
chcp 65001 > nul
setlocal EnableDelayedExpansion

set /p "app=Введите название приложения: "
md %app%
echo.

for %%i in (%app%.*.bat) do (
	move %%i !app! > nul
	if !errorlevel! equ 0 (
		echo %%i		OK
		bat2exe /bat !app!\%%i /exe !app!\%%i.exe /x64
		echo.
	) else (
		echo %%i		ERROR
	)
)

echo.
echo Готово
pause > nul
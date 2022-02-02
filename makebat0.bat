@echo off
cd %~dp0
title MAKE
chcp 1251 > nul
setlocal EnableDelayedExpansion

echo Введите название приложения:
set /p "app="
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
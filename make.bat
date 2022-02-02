@echo off
cd %~dp0
title MAKE
chcp 65001 > nul
setlocal EnableDelayedExpansion

set /p "app=Введите название приложения: "
md %app%

for %%i in (%app%.*.*) do (
	move %%i !app! > nul
	if !errorlevel! equ 0 (
		echo %%i		OK
	) else (
		echo %%i		ERROR
	)
)

pause > nul
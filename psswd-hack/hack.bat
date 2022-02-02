@echo off
cd %~dp0
title Hack
chcp 65001 > nul
setlocal EnableDelayedExpansion

for /f %%i in (passwords.txt) do (
	call checkpsswd %%i
	if "!errorlevel!" equ "0" (
		echo Found password: %%i
		pause > nul
		exit
	)
)
@echo off
title YPLM
setlocal EnableDelayedExpansion

set "in=test.txt"
set "out=out.txt"
rem set /p in=<%in%

copy files\start.txt %out%

for /f "tokens=1,2* delims= " %%a in (!in!) do (
	for /f "tokens=1,2* delims==" %%i in (files\config.txt) do (
		find !in! "%%i" > nul
		if !errorlevel! equ 0 (
			echo %%j %%b >> !out!
		)
		rem echo i=%%i		j=%%j 		a=%%a 		b=%%b
	)
)
rem pause
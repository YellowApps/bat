@echo off
title YML
cd %~dp0
chcp 65001 > nul
setlocal EnableDelayedExpansion

if "%1" equ "" (
	set /p "in=YML Filename: "
) else (
	set in=%1
)
if "%2" equ "" (
	set /p "out=HTML Filename: "
) else (
	set out=%2
)

copy html0.txt %out%

for /f "delims=# tokens=1,2,3*" %%i in (%in%) do (
	if "%%k" equ ";" (
		echo 		^<%%i %%j^> >> !out!
	) else (
		echo 		^<%%i %%j^>%%k^</%%i^> >> !out!
	)
)

type html1.txt >> %out%
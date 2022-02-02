@echo off
cd %~dp0
title Add folder to PATH
chcp 65001 > nul
setlocal EnableDelayedExpansion

if "%1" equ "" (
	set /p "folder=Enter folder name: "
) else (
	set "folder=%1"
)

setx /m PATH "%PATH%;%folder%"

if %errorlevel% equ 0 (
	echo OK
) else (
	echo Error
)

if %1 equ "" (
	pause > nul
)
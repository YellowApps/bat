@echo off
title Change Background

if "%1" equ "" (
	set /p "addr=Enter the address of Background: "
) else (
	set addr=%1
)

reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "" /f 
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%addr%" /f 
reg delete "HKCU\Software\Microsoft\Internet Explorer\Desktop\General" /v WallpaperStyle /f
reg add "HKCU\Control Panel\Desktop" /v WallpaperStyle /t REG_SZ /d 2 /f
rundll32 user32, UpdatePerUserSystemParameters

taskkill /f /im explorer.exe
start explorer

if %errorlevel% equ 0 (
	echo Completed
) else (
	echo Error
)

if "%1" equ "" pause > nul
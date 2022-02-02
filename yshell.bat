@echo off

::подготовка
cd %~dp0
title YShell 2.0
color 1f
chcp 65001 > nul
setlocal EnableDelayedExpansion

::инициализация переменных
set /a counter=0
set currfile=

::получение списка файлов
for /f "usebackq tokens=*" %%i in (`dir /b`) do (
	set files[!counter!]=%%i
	set /a "counter+=1"
)

set currfile=0
set c=currfile
set currfiletxt=%files[0]%
set /a "counter-=1"

::основной цикл
:loop
cls

::получение текущего файла
for /f "tokens=*" %%a in ("%currfile%") do (
	set currfiletxt=!files[%%a]!
)

echo %~dp0
echo.

::отображение файлов
for /l %%j in (0,1,%counter%) do (
	if !currfile! equ %%j ( 
		echo ^[!files[%%j]!^]
	) else (
		echo !files[%%j]!
	)
)

::запрос
choice /c swoq /m "" > nul

if %errorlevel% equ 1 (
	::вперед
	set /a "currfile+=1"
) else if %errorlevel% equ 2 (
	::назад
	set /a "currfile-=1"
) else if %errorlevel% equ 3 (
	::запуск файла
	start %~dp0%currfiletxt%
) else if %errorlevel% equ 4 (
	::выход
	exit
)

goto loop
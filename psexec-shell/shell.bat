@echo off
cd %~dp0
color 0a
title PsExec Shell
chcp 1251 > nul
setlocal EnableDelayedExpansion

echo Добро пожаловать в PsExec Shell!
echo (Сделано на базе PsTools (https://docs.microsoft.com/en-us/sysinternals/downloads/pstools))

echo.
echo Введите IP или имя хоста удаленного ПК:
set /p "addr=>"

:loop
cls

echo Выберите опцию:
echo.
echo [C] Запустить консоль Cmd
echo [P] Запустить консоль PowerShell
echo [L] Вывести список процессов
echo [F] Запустить EXE с этого ПК
echo.
echo.


choice /c CPLF /m "Введите букву: "

if %errorlevel% equ 1 (
	start cmd /c "psexec \\%addr% cmd.exe"
) else if %errorlevel% equ 2 (
	start cmd /c "psexec \\%addr% powershell.exe"
) else if %errorlevel% equ 3 (
	start cmd /c "psexec \\%addr% tasklist & pause > nul"
) else if %errorlevel% equ 4 (
	echo Введите команду:
	set /p "cmd=>"
	psexec \\%addr% -c %cmd%
)
goto loop

pause > nul
@echo off
chcp 1251 > nul

set "dirName=temp%random%%random%%random%"

if "%~1"=="/?" (
	echo MKTEMP [/N] [/P] [/?]
	echo Создает временную папку.
	echo [/N] Вывести имя созданной папки
	echo [/P] Вывести полный путь к созданной папке
	echo [/?] Вывести справку
) else (
	md %dirName%
	cd /d %dirName%
)

if "%~1"=="/n" (
	echo %dirName%
	shift /1
)
if "%~1"=="/p" (
	echo %cd%\%dirName%
	shift /1
)
exit /b
@echo off
chcp 1251 > nul
setlocal EnableExtensions, EnableDelayedExpansion

set format=csv
set outputFile=wifi_passwords
set nextStr=0

if "%~1"=="/?" (
	echo %~n0 [/F ^<csv^|text^|echo^>] [/O ^<имя файла^>]
	echo Получает сохраненные в системе пароли от Wi-Fi-сетей.
	echo.
	echo /F ^<csv^|text^|echo^>    Формат данных:
	echo                               CSV    Сохранить результат в csv-файл; 
	echo                               TEXT   Сохранить результат в текстовый файл; 
	echo                               ECHO   Вывести результат в консоль.
	echo                       По умолчанию - csv.
	echo.
	echo /O ^<имя файла^>   Имя выходного файла. Если формат данных - echo, этот параметр игнорируется.
	exit /b
)

if "%~1"=="/f" (
	if not "%~2"=="csv" if not "%~2"=="text" if not "%~2"=="echo" (
		echo Неправильный формат! 
		echo Допустимые форматы: csv, text, echo.
		exit /b
	)
	set "format=%~2"
	shift /1
	shift /1
)
if "%~1"=="/o" (
	set "outputFile=%~2"
)

if "%format%"=="csv" for /f "tokens=*" %%a in ("%outputFile%") do (
	if not "%%~xa"==".csv" set "outputFile=!outputFile!.csv"
)
if "%format%"=="text" for /f "tokens=*" %%a in ("%outputFile%") do (
	if not "%%~xa"==".txt" set "outputFile=!outputFile!.txt"
)

if "%format%"=="csv" echo Имя сети;Пароль > "%outputFile%"

for /f "tokens=1,2* delims=:" %%i in ('netsh wlan show profile') do (
	if !nextStr!==2 (
		set "name=%%j"
		set "name=!name:~1!"
		for /f "tokens=1,2 delims=:" %%k in ('netsh wlan show profile "!name!" key^=clear ^| find "Содержимое ключа"') do (
			set "key=%%l"
			set "key=!key:~1!"
			if "!format!"=="csv" echo !name!;!key! >> "!outputFile!"
			if "!format!"=="text" echo Пароль от сети "!name!": !key! >> "!outputFile!"
			if "!format!"=="echo" echo !name!:!key!
		)
	)
	if !nextStr!==1 set nextStr=2
	if "%%i"=="Профили пользователей" set nextStr=1
)

endlocal
exit /b
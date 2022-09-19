@echo off
chcp 1251 > nul
setlocal EnableExtensions, EnableDelayedExpansion

set format=echo
set outputFile=wifi_passwords
set nextStr=0

if "%~1"=="/?" (
	echo %~n0 [/F ^<csv^|text^|echo^|bat^>] [/O ^<��� �����^>]
	echo �������� ����������� � ������� ������ �� Wi-Fi-�����.
	echo.
	echo /F ^<csv^|text^|echo^|bat^>    ������ ������:
	echo                               CSV    ��������� ��������� � csv-����; 
	echo                               TEXT   ��������� ��������� � ��������� ����; 
	echo                               ECHO   ������� ��������� � �������.
	echo                               BAT    ������� ��������� � ������� � ������� ���_����:������ ^(��� ������������� � �������� ������^).
	echo                           �� ��������� - echo.
	echo.
	echo /O ^<��� �����^>   ��� ��������� �����. ���� ������ ������ - echo ��� bat, ���� �������� ������������.
	exit /b
)

if "%~1"=="/f" (
	if not "%~2"=="csv" if not "%~2"=="text" if not "%~2"=="echo" if not "%~2"=="bat" (
		echo ������������ ������! 
		echo ���������� �������: csv, text, echo, bat.
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

if "%format%"=="csv" echo ��� ����;������ > "%outputFile%"

for /f "tokens=1,2* delims=:" %%i in ('netsh wlan show profile') do (
	if !nextStr!==2 (
		set "name=%%j"
		set "name=!name:~1!"
		for /f "tokens=1,2 delims=:" %%k in ('netsh wlan show profile "!name!" key^=clear ^| find "���������� �����"') do (
			set "key=%%l"
			set "key=!key:~1!"
			if "!format!"=="csv" echo !name!;!key! >> "!outputFile!"
			if "!format!"=="text" echo ������ �� ���� "!name!": !key! >> "!outputFile!"
			if "!format!"=="echo" echo ������ �� ���� "!name!": !key!
			if "!format!"=="bat" echo !name!:!key!
		)
	)
	if !nextStr!==1 set nextStr=2
	if "%%i"=="������� �������������" set nextStr=1
)

endlocal
exit /b
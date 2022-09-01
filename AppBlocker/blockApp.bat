::t.me/nekit270

@echo off
chcp 1251 > nul
setlocal EnableExtensions

if "%~1"=="" ( set /p "file=Введите имя EXE-файла программы: " ) else ( set "file=%~1" )
for /f "tokens=*" %%i in ("%file%") do set "file=%%~nxi"

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%file%" /v Debugger /d "rundll32.exe" /t REG_SZ /f > nul 2> nul

if "%errorlevel%"=="0" (
	echo %file% успешно заблокирован.
) else (
	 echo Ошибка!
	 net helpmsg %errorlevel% 2> nul
	 echo Код: %errorlevel%
)

if "%~1"=="" pause > nul

endlocal
exit /b
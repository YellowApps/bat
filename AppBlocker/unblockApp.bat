::t.me/nekit270

@echo off
chcp 1251 > nul
setlocal EnableExtensions

if "%~1"=="" ( set /p "file=������� ��� EXE-����� ���������: " ) else ( set "file=%~1" )

for /f "tokens=*" %%i in ("%file%") do (
	set "file=%%~nxi"
	if "%%~ni"=="%%~nxi" set "file=%file%.exe"
)

reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%file%" /f > nul 2> nul

if "%errorlevel%"=="0" (
	echo %file% ������� �������������.
) else (
	 echo ������!
	 echo ���: %errorlevel%
)

if "%~1"=="" pause > nul

endlocal
exit /b
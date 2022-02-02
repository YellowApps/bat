@echo off
cd %~dp0
title app
chcp 65001 > nul
setlocal EnableDelayedExpansion

call :test lol xd

pause > nul

:test
	echo %1 %2
goto :eof
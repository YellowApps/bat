@echo off
cd %~dp0\frames
title app
chcp 65001 > nul
setlocal EnableDelayedExpansion

for /l %%i in (1,1,100) do (
	cls
	type %%i.txt
	if !errorlevel! neq 0 exit
	timeout /t 1 /nobreak > nul
)

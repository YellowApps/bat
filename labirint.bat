@echo off

::подготовка
cd %~dp0
chcp 65001 > nul
title Лабиринт (Счет: 0)
setlocal EnableDelayedExpansion
mode con cols=50 lines=17

::объявление переменных
set sizeX=35
set sizeY=10
set playerX=1
set playerY=1
set score=1
set circles=0
set maxCircles=5

::генерация лабиринта
for /l %%y in (1,1,%sizeY%) do (
	for /l %%x in (1,1,!sizeX!) do (
		call :rand
		set "lab[%%y][%%x]=!rand!"
	)
)

::основной цикл
:loop
	::отображение лабиринта
	call :drawlab
	
	::запрос
	choice /c wasd > nul
	
	::сохранение координат
	set pplayerX=%playerX%
	set pplayerY=%playerY%
	
	if %errorlevel% equ 1 (
		::w - наверх
		set /a "playerY-=1"
	) else if %errorlevel% equ 2 (
		::a - налево
		set /a "playerX-=1"
	) else if %errorlevel% equ 3 (
		::s - вниз
		set /a "playerY+=1"
	) else if %errorlevel% equ 4 (
		::d - направо
		set /a "playerX+=1"
	)
	
	::блок проверок
	if "!lab[%playerY%][%playerX%]!" equ "█" (
		::игрок в стене, возвращение на место
		set playerX=%pplayerX%
		set playerY=%pplayerY%
	) else if "!lab[%playerY%][%playerX%]!" equ "●" (
		::игрок нашёл круг
		set /a "score+=1"
		set "lab[%playerY%][%playerX%]=░"
		title Лабиринт (Счет: %score%^)
	)
	
	::выигрыш
	if %score% gtr %maxCircles% (
		cls
		title Вы выиграли!
		echo Вы выиграли!
		pause > nul
		exit
	)

goto loop

::::::::::::::::
::БЛОК ФУНКЦИЙ::
::::::::::::::::

::получение случайного текста
:rand
	if %RANDOM:~-2% gtr 70 (
		set "rand=█"
	) else if %RANDOM:~-2% lss 5 (
		::если кругов меньше, чем нужно, сгененрировать круг
		if %circles% lss %maxCircles% (
			set "rand=●"
			set /a "circles+=1"
		)
	) else (
		set "rand=░"
	)
goto :eof

::рисование лабиринта
:drawlab
	cls
	for /l %%y in (1,1,%sizeY%) do (
		set /p "temp=|" < nul
		for /l %%x in (1,1,!sizeX!) do (
			if %%y equ !playerY! if %%x equ !playerX! set isPlayer=1
			if !isPlayer! equ 1 (
				::если игрок стоит здесь, нарисовать смайлик
				set /p "temp=☺" < nul
			) else (
				set /p "temp=!lab[%%y][%%x]!" < nul
			)
			set isPlayer=0
		)
		set /p "temp=|" < nul
		echo.
	)
goto :eof
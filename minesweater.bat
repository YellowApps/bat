@echo off

::подготовка
cd %~dp0
title Mine Sweater :3 (Score: 0)
chcp 65001 > nul
setlocal EnableDelayedExpansion
mode con cols=50 lines=17

::открываем меню
call :menu

::начало игры
:start

::задаем размер поля
set size=8

::обнуляем счет
set score=0
title Mine Sweater :3 (Score: 0)

::создаем поле с минами 
for /l %%i in (1,1,%size%) do (
	for /l %%j in (1,1,%size%) do (
		call :getrandtxt
		set pole[%%i][%%j]=!randtxt!
	)
)

::основной цикл
:loop
cls

::рисуем поле
call :drawpole
echo.

::получаем координаты
set /p "input=Y,X: "

::обрабатываем координаты
for /f "delims=, tokens=1,2" %%m in ("%input%") do (
	call :getpoint %%m %%n
	echo !point! %%m %%n
	if !point! equ m (
		::мина - выход в меню
		cls
		echo Boom! 
		echo Score: !score!
		call :menu nologo
	) else (
		::мины нет, обновляем счет
		set "pole[%%m][%%n]=□"
		call :check %%m %%n
		set /a "score+=1"
		title Mine Sweater :3 (Score: !score!^)
	)
)

goto loop

:::::::::::::::::::::::
::блок описания функций
:::::::::::::::::::::::

::выдача случайного числа
:getrandnum
	set randnum=%random:~-2%
goto :eof

::выдача буквы: n - пусто, m - мина
:getrandtxt
	call :getrandnum
	if %randnum% gtr 70 (
		set "randtxt=m"
	) else (
		set "randtxt=n"
	)
goto :eof

::получение буквы по координатам
:getpoint
	set point=!pole[%1][%2]!
goto :eof

::рисуем поле
:drawpole
	::переменная с текстом поля
	set "text="
	
	::печатаем верхнюю строку
	set "up=  "
	for /l %%a in (1,1,%size%) do (
		set "up=!up! %%a"
	)
	echo %up%
	
	for /l %%k in (1,1,%size%) do (
		if %%k lss 10 (
			set "text= %%k"
		) else (
			set "text=%%k"
		)
		for /l %%l in (1,1,%size%) do (
			if !pole[%%k][%%l]! equ n (
				::ячейка закрыта - добавляем ■
				set "text=!text! ■"
			) else if !pole[%%k][%%l]! equ m (
				::ячейка закрыта - добавляем ■
				set "text=!text! ■"
			) else (
				::ячейка открыта - добавляем символ ячейки
				set "text=!text! !pole[%%k][%%l]!"
			)
		)
		::вывод поля на экран
		echo !text!
	)
goto :eof

::меню игры
:menu
	::если не передан параметр nologo, печатаем название игры
	if "%1" neq "nologo" (
		echo MINE SWEATER
		echo.
	)
	echo ^[S^] Start new game
	echo ^[E^] Exit
	::запрос
	choice /c se /m "" > nul
	if %errorlevel% equ 1 (
		::новая игра
		goto start
	) else (
		::выход
		exit
	)
goto :eof

::проверка ячеек
:check
	::переменные для хранения координат
	set y=%1
	set x=%2
	
	::переменные для различных вариантов координат
	set /a "ym2=y-2"
	set /a "xm2=x-2"
	set /a "ym1=y-1"
	set /a "xm1=x-1"
	set /a "yp2=y+2"
	set /a "xp2=x+2"
	set /a "yp1=y+1"
	set /a "xp1=x+1"
	
	::проверки мин
	
	::верх
	if !pole[%ym1%][%x%]! equ m		set "pole[%y%][%x%]=1"
	if !pole[%ym2%][%x%]! equ m		set "pole[%ym1%][%x%]=1"
	::низ
	if !pole[%y%][%xp1%]! equ m		set "pole[%y%][%x%]=1"
	if !pole[%yp2%][%x%]! equ m		set "pole[%yp1%][%x%]=1"
	::лево
	if !pole[%y%][%xm1%]! equ m		set "pole[%y%][%x%]=1"
	if !pole[%y%][%xm2%]! equ m		set "pole[%y%][%xm1%]=1"
	::право
	if !pole[%y%][%xp1%]! equ m		set "pole[%y%][%x%]=1"
	if !pole[%y%][%xp2%]! equ m		set "pole[%y%][%xp1%]=1"
	
goto :eof
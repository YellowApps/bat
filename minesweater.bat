@echo off

::подготовка
cd %~dp0
title Mine Sweater :3 (Score: 0)
chcp 65001 > nul
setlocal EnableDelayedExpansion

::открываем меню
call :menu

::начало игры
:start

::обнуление счета
set score=0
title Mine Sweater :3 (Score: 0)

::создаем поле с минами 
for /l %%i in (1,1,5) do (
	for /l %%j in (1,1,5) do (
		call :getrandtxt
		set pole[%%i][%%j]=!randtxt!
	)
)

::основной цикл
:loop
cls

::рисуем поле
call :drawpole

::получаем координаты
set /p "input=Y,X: "

::обрабатываем координаты
for /f "delims=, tokens=1,2" %%m in ("%input%") do (
	call :getpoint %%m %%n
	echo !point! %%m %%n
	if !point! equ m (
		::мина - выход в меню
		cls
		echo Boom!
		echo Score: !score!
		call :menu nologo
	) else (
		::мины нет, обновляем счет
		set "pole[%%m][%%n]=o"
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
	for /f "tokens=*" %%y in ("%1") do (
		for /f "tokens=*" %%x in ("%2") do ( 
			set point=!pole[%%y][%%x]!
		)
	)
goto :eof

::рисуем поле
:drawpole
	::переменная с текстом поля
	set "text="
	echo   1 2 3 4 5
	for /l %%k in (1,1,5) do (
		set "text=%%k"
		for /l %%l in (1,1,5) do (
			if !pole[%%k][%%l]! neq o (
				::ячейка закрыта - добавляем ?
				set "text=!text! ?"
			) else (
				::ячейка открыта - добавляем □
				set "text=!text! □"
			)
		)
		::вывод поля на экран
		echo !text!
	)
goto :eof

::меню игры
:menu
	::если не передан параметр nologo, печатем назвние игры
	if "%1" neq "nologo"	echo MINE SWEATER
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

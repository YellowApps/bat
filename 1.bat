@echo off
chcp 65001 > nul
setlocal EnableDelayedExpansion

for /l %%i in (1,1,15) do (
	set fn=temp.!random!!random!.bat
	echo @echo off > !fn!
	echo pause >> !fn!
)

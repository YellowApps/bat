@echo off
chcp 1251 > nul

echo ^@explorer shell^:^:^:^{ED834ED6-4B5A-4BFE-8F11-A626DCB6A921^} > "%windir%\personalize.bat"

reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Персонализация Win7" /v Icon /d "%windir%\system32\themecpl.dll,-1" /t REG_SZ /f
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Персонализация Win7" /v Position /d Bottom /t REG_SZ /f
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Персонализация Win7\command" /ve /d "%windir%\personalize.bat" /t REG_SZ /f
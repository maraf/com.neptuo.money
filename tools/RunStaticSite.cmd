@echo off&setlocal
for %%i in ("%~dp0..") do set "folder=%%~fi"
echo %folder%

"c:\Program Files (x86)\IIS Express\iisexpress" /path:"%folder%\output" /port:9000 /clr:v4.0
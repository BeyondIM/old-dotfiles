@echo off
::------------------------------------------------------------------------------
:: The latest working version is 0.5.1 - http://nodejs.org/dist/v0.5.1/node.exe

:: Path to node.exe
set nodejs_exe="c:\Users\Administrator\bin\node.exe"

:: Path to doctorjs installation directory
set doctorjs_install=c:\Users\Administrator\.vim\bundle\doctorjs_1062dd3

::------------------------------------------------------------------------------
set NODE_PATH=%doctorjs_install%\lib\jsctags
%nodejs_exe% %doctorjs_install%\bin\jsctags.js %*

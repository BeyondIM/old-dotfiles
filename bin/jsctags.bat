@echo off
::------------------------------------------------------------------------------
 
:: Path to node.exe
set nodejs_exe="c:\Program Files\nodejs\node.exe"
 
:: Path to doctorjs installation directory
set doctorjs_install=c:\Users\Administrator\.vim\bundle\doctorjs
 
::------------------------------------------------------------------------------
set NODE_PATH=%doctorjs_install%\lib\jsctags
%nodejs_exe% %doctorjs_install%\bin\jsctags.js %*

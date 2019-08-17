@echo off

:: no arguments, go home
if "%~1"=="" (
  chdir /D %USERPROFILE%
  exit /B 0
)

set dirname=%*
set orig_dirname=%*

:: remove quotes - will re-attach later.
set dirname=%dirname:\"=%
set dirname=%dirname:/"=%
set dirname=%dirname:"=%

:: restore dirnames that contained only "/"
if "%dirname%"=="" set dirname=%orig_dirname:"=%

:: strip trailing slash, if longer than 3
if defined dirname if NOT "%dirname:~3%"==""  (
    if "%dirname:~-1%"=="\" set dirname="%dirname:~0,-1%"
    if "%dirname:~-1%"=="/" set dirname="%dirname:~0,-1%"
)

set dirname=%dirname:"=%

:: if starts with ~, then replace ~ with userprofile path
if %dirname:~0,1%==~ (
    set dirname="%USERPROFILE%%dirname:~1%"
)
set dirname=%dirname:"=%

:: replace forward-slashes with back-slashes
set dirname="%dirname:/=\%"
set dirname=%dirname:"=%

chdir /D "%dirname%"

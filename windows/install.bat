@echo off

:: Startup Paths:
::  C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp
::  C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\

set dotfiles_path=%~dp0%

pushd "C:\Users\%USERNAME%\Documents\"
  if exist AutoHotKey.ahk (del AutoHotKey.ahk)
  mklink AutoHotKey.ahk "%dotfiles_path%AutoHotKey.ahk"
popd

pushd "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\"
  if exist startup.bat (del startup.bat)
  mklink /H startup.bat "%dotfiles_path%startup.bat"

  if exist env.bat (del env.bat)
  mklink /H env.bat "%dotfiles_path%env.bat"
popd

@echo off

pushd "C:\Users\%USERNAME%\Documents\"
  if exist AutoHotKey.ahk (del AutoHotKey.ahk)
  mklink AutoHotKey.ahk "C:\Users\%USERNAME%\dotfiles\windows\AutoHotKey.ahk"
popd

pushd "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
  if exist startup.bat (del startup.bat)
  mklink startup.bat "C:\Users\%USERNAME%\dotfiles\windows\startup.bat"
  
  if exist AutoHotKey.ahk (del AutoHotKey.ahk)
  mklink AutoHotKey.ahk "C:\Users\%USERNAME%\dotfiles\windows\AutoHotKey.ahk"
popd

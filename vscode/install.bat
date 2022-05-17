@echo off

if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

set cwd=%~dp0%

pushd "%APPDATA%\Code\User\"
  if exist settings.json (del settings.json)
  mklink settings.json "%cwd%settings.json"

  if exist keybindings.json (del keybindings.json)
  mklink keybindings.json "%cwd%keybindings.json"
popd
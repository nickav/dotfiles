@echo off

set cwd=%~dp0%

pushd "%APPDATA%\Code\User\"
  if exist settings.json (del settings.json)
  mklink settings.json "%cwd%settings.json"

  if exist keybindings.json (del keybindings.json)
  mklink keybindings.json "%cwd%keybindings.json"
popd
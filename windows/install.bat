@echo off

pushd "C:\Users\%USERNAME%\Documents\"
del AutoHotKey.ahk
mklink AutoHotKey.ahk "C:\Users\%USERNAME%\dotfiles\windows\AutoHotKey.ahk"
popd

pushd "C:\Users\%USERNAME%\AppData\Roaming\"
del .emacs
mklink .emacs "C:\Users\%USERNAME%\dotfiles\.emacs"
popd

pushd "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
del startup.bat
mklink startup.bat "C:\Users\%USERNAME%\dotfiles\windows\startup.bat"
popd

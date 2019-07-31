pushd "C:\Users\%USERNAME%\Documents\"
mklink AutoHotKey.ahk "C:\Users\%USERNAME%\dotfiles\windows\AutoHotKey.ahk"
popd

pushd "C:\Users\%USERNAME%\AppData\Roaming\"
mklink .emacs "C:\Users\%USERNAME%\dotfiles\.emacs"
popd

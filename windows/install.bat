@echo on

if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

:: Startup Paths:
::  C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp
::  C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\

:: Run PowerShell in admin mode:
::  set-executionpolicy remotesigned

set dotfiles_path=%~dp0%

pushd "C:\Program Files\AutoHotkey\"
  if exist AutoHotKey.ahk (del AutoHotKey.ahk)
  mklink /H AutoHotKey.ahk "%dotfiles_path%AutoHotKey.ahk"
popd

::
:: NOTE(nick): in Windows 11, the $profile path is:
::
:: C:\Users\mango\OneDrive\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
::
:: You can invoke the old thing like this:
::
:: New-item –type file –force $profile
:: . "C:\Users\mango\Documents\WindowsPowerShell\Profile.ps1"
::

pushd "C:\Users\%USERNAME%\Documents\WindowsPowerShell\"
  if exist Profile.ps1 (del Profile.ps1)
  mklink /H Profile.ps1 "%dotfiles_path%Profile.ps1"
popd

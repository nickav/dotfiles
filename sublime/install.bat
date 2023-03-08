@echo off

if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

set cwd=%~dp0%

pushd "%APPDATA%\Sublime Text\Packages\User\"

  for %%x in (
    Adaptive.sublime-theme
    Build.sublime-build 
    C++11.sublime-settings
    C++11.sublime-syntax
    Default.sublime-keymap
    Default.sublime-mousemap
    DefinitionPreview.py
    Monokai.sublime-color-scheme
    Preferences.sublime-settings
    Node.sublime-build
    Shell.sublime-build
  ) do (
    if exist %%x del %%x
    mklink /H %%x "%cwd%%%x"
  )

popd

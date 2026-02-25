@echo off

if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

set cwd=%~dp0%

pushd "%APPDATA%\Sublime Text\Packages\User\"

  for %%x in (
    Adaptive.sublime-theme
    Build.sublime-build 
    BuildZig.sublime-build 
    BuildOdin.sublime-build 
    C++11.sublime-syntax
    C++11.sublime-settings
    C11.sublime-syntax
    C11.sublime-settings
    Odin.sublime-syntax
    Default.sublime-keymap
    Default.sublime-mousemap
    DefinitionPreview.py
    Monokai.sublime-color-scheme
    Preferences.sublime-settings
    Node.sublime-build
    Shell.sublime-build
    BuildBat.sublime-snippet 
    BuildSh.sublime-snippet 
    C_Enum.sublime-snippet
    C_Flags.sublime-snippet
    C_Struct.sublime-snippet
  ) do (
    if exist %%x del %%x
    mklink /H %%x "%cwd%%%x"
  )

popd

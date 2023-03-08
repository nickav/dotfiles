cwd="$(cd "$(dirname "$0")" && pwd -P)"

echo $cwd

pushd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

  files="
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
  "

  for x in $files;
  do
    rm -f $x
    ln -s $cwd/$x $x
  done

popd

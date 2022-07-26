cwd="$(cd "$(dirname "$0")" && pwd -P)"

echo $cwd

pushd ~/Library/Application\ Support/Sublime\ Text/Packages/User

  files="
    Build.sublime-build
    C++11.sublime-settings
    C++11.sublime-syntax
    Default.sublime-keymap
    Default.sublime-mousemap
    Preferences.sublime-settings
    Node.sublime-build
    Shell.sublime-build
  "

  for x in $files;
  do
    rm $x
    ln -s $cwd/$x $x
  done

popd

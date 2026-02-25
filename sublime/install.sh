cwd="$(cd "$(dirname "$0")" && pwd -P)"

echo $cwd

# NOTE(nick): strategy 2 - symlink entire directory
rm -rf "/Users/nick/Library/Application Support/Sublime Text/Packages/User"
ln -s $cwd "/Users/nick/Library/Application Support/Sublime Text/Packages/User"
exit

# NOTE(nick): strategy 1 - link individual files

pushd ~/Library/Application\ Support/Sublime\ Text/Packages/User

  files="
    Adaptive.sublime-theme
    Build.sublime-build
    BuildZig.sublime-build
    BuildOdin.sublime-build
    C++11.sublime-settings
    C++11.sublime-syntax
    Odin.sublime-syntax
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
    #ln -s $cwd/$x $x
    cp -f $cwd/$x $x
  done

popd

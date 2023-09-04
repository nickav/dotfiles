#
# NOTE(nick): you need to run this (in Power Shell admin):
# Set-ExecutionPolicy RemoteSigned
#

$env:Path += ";C:\Program Files\nodejs;C:\Users\Nick\AppData\Roaming\npm"
$env:Path += ";C:\apps"
$env:Path += ";C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\Llvm\bin"

Set-Location C:\dev

function mv { move $Args }
function cp { copy $Args }
function rm { del $Args }
function which { Get-Command $Args }

function mklink ($target, $link) {
  New-Item -Path $link -ItemType SymbolicLink -Value $target
}

function .. { cd .. }
function ... { cd ..\.. }
function .... { cd ..\..\.. }
function ..... { cd ..\..\..\.. }
function ~ { cd ~ }
function doc { cd ~\Documents }
function dev { cd C:\dev }
function dow { cd ~\Downloads }
function dot { cd C:\dev\dotfiles }
function dots { cd C:\dev\dotfiles }

function e { exit $Args }
function vi { vim $Args }

function g { git $Args }
function ga { git add $Args }
function ga. { git add . $Args }
function gam { git commit --amend $Args }
function gau { git add -u  $Args }
function gs { git status $Args }
function gb { git branch $Args }

Remove-Item alias:gc -Force
function gc { git checkout $Args }

Remove-Item alias:gci -Force
function gci { git commit -m $Args }

Remove-Item alias:gcm -Force
function gcm { git checkout master $Args }

function gcd { git checkout dev $Args }
function gd { git diff $Args }
function gdm { git diff master $Args }
function gdh { git diff HEAD $Args }
function gdh1 { git diff HEAD~1 $Args }
function gdh2 { git diff HEAD~2 $Args }
function gdh3 { git diff HEAD~3 $Args }
function gdh4 { git diff HEAD~4 $Args }

Remove-Item alias:gl -Force
function gl { git log $Args }

function gpu { git push -u origin $(git rev-parse --abbrev-ref HEAD) $Args }

Remove-Item alias:gp -Force
function gp { git push $Args }

function gpf { git push --force-with-lease $Args }
function gpl { git pull $Args }
function gsh { git stash $Args }
function gsp { git stash pop $Args }

function grbm { git rebase main $Args }

function open { explorer.exe $Args }

function touch { New-Item -ItemType file $Args }

function ys { yarn start }

function build { .\build.bat }

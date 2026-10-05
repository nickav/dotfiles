#
# NOTE(nick): you need to run this (in Power Shell admin):
# Set-ExecutionPolicy RemoteSigned
#
# To install this profile (runs in every PowerShell host/tab), run in both powershell and pwsh:
# New-Item -ItemType Directory -Force (Split-Path $PROFILE.CurrentUserAllHosts)
# Set-Content $PROFILE.CurrentUserAllHosts '. C:\dev\dotfiles\windows\Profile.ps1'
# (don't hard link it, git replaces the file and the link goes stale)
#

$env:Path += ";C:\Program Files\nodejs;C:\Users\Nick\AppData\Roaming\npm"
$env:Path += ";C:\apps"
$env:Path += ";C:\Program Files\LLVM\bin"
$env:Path += ";C:\Program Files\Go\bin\;C:\Users\Nick\go\bin"
$env:Path += ";C:\Users\Nick\.cargo\bin"
$env:Path += ";C:\Users\Nick\.local\bin"

$ExecutionContext.SessionState.Path.SetLocation("C:\dev") > $null

foreach ($line in [IO.File]::ReadAllLines("C:\dev\dotfiles\windows\post.env")) {
  if ($line -match '^([^=]+)=(.*)$') {
    # Set-Variable -Name $matches[1] -Value $matches[2] -Scope Global
    [Environment]::SetEnvironmentVariable($matches[1], $matches[2], 'Process')
  }
}

function mv { move $Args }
function cp { copy $Args }
function rm { Remove-Item -Path $Args }
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

$ExecutionContext.SessionState.InvokeProvider.Item.Remove("alias:\gc", $false, $true, $true)
function gc { git checkout $Args }

$ExecutionContext.SessionState.InvokeProvider.Item.Remove("alias:\gci", $false, $true, $true)
function gci { git commit -m $Args }

$ExecutionContext.SessionState.InvokeProvider.Item.Remove("alias:\gcm", $false, $true, $true)
function gcm { git checkout master $Args }

function gcd { git checkout dev $Args }
function gd { git diff $Args }
function gdm { git diff master $Args }
function gdh { git diff HEAD $Args }
function gdh1 { git diff HEAD~1 $Args }
function gdh2 { git diff HEAD~2 $Args }
function gdh3 { git diff HEAD~3 $Args }
function gdh4 { git diff HEAD~4 $Args }

$ExecutionContext.SessionState.InvokeProvider.Item.Remove("alias:\gl", $false, $true, $true)
function gl { git log $Args }

function gpu { git push -u origin $(git rev-parse --abbrev-ref HEAD) $Args }

$ExecutionContext.SessionState.InvokeProvider.Item.Remove("alias:\gp", $false, $true, $true)
function gp { git push $Args }

function gpf { git push --force-with-lease $Args }
function gpl { git pull $Args }
function gsh { git stash $Args }
function gsp { git stash pop $Args }

function grbm { git rebase main $Args }

#function open { explorer.exe $Args }
function open { FPilot.exe $Args }

function touch { New-Item -ItemType file $Args }

function ys { yarn start }
function ns { npm start }

function build { .\build.bat }

function l { dir }
function ll { dir }
function la { dir }

function grep { ag $Args }

function rmrf { Remove-Item -Path $Args -Recurse -Force }

function appify {
  param(
    [Parameter(Mandatory)][string]$SourcePath,
    [string]$AppName = (Split-Path $SourcePath -Leaf)
  )
  & "C:\ProgramData\chocolatey\tools\shimgen.exe" --output="C:\apps\$AppName" --path="$SourcePath"
}

function b { .\build.bat }
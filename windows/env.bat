:: Run regedit and go to HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor
:: Add String Value entry with the name AutoRun and the full path of your .bat/.cmd file.
:: For example: C:\dev\dotfiles\windows\env.bat
@echo off

set dotfiles_path=%~dp0%

:: Linux commands
doskey alias=doskey $* $^^*
doskey sudo=runas /user:nick $*
doskey l=dir /w
doskey ls=dir /w
doskey ll=dir
doskey la=dir
doskey ls=dir
doskey ll=wsl ls -l --color $*
doskey la=wsl ls -al --color $*
doskey mv=move $*
doskey cp=copy $*
doskey cpr=xcopy $*
doskey cat=type $*
doskey ln=mklink $*
doskey clear=cls
doskey grep=find $*
doskey history=doskey /history
doskey kill=taskkill /PID $*
doskey man=help $*
doskey ps=tasklist $*
doskey pwd=cd
doskey rm=del $*
doskey rmr=deltree $*
doskey touch=copy nul $* > nul
doskey which=where $*

:: Easier navigation
doskey open=start $*
doskey ..    = cd ..\$*
doskey ...   = cd ..\..\$*
doskey ....  = cd ..\..\..\$*
doskey ..... = cd ..\..\..\..\$*
doskey ~=cd %homepath%
::doskey cd=%dotfiles_path%\cdtilde.bat $*

doskey docs = cd C:\docs
doskey dev = cd C:\dev
doskey dots = cd C:\dotfiles

:: Git shortcuts
doskey g=git $*
doskey ga=git add $*
doskey ga.=git add . $*
doskey gam=git amend $*
doskey gb=git branch $*
doskey gau=git add -u $*
doskey gs=git status $*
doskey gci=git commit -m $*
doskey gc=git checkout $*
doskey gc-=git checkout - $*
doskey gcm=git checkout master $*
doskey gcd=git checkout dev $*
doskey gd=git diff $*
doskey gdm=git diff master $*
doskey gdh=git diff HEAD $*
doskey gdh1=git diff HEAD~1 $*
doskey gdh2=git diff HEAD~2 $*
doskey gdh3=git diff HEAD~3 $*
doskey grbm=git rebase master $*
doskey grb-=git rebase - $*
doskey gl=git log $*
doskey gps=git push $*
doskey gpu=git push -u origin $(git rev-parse --abbrev-ref HEAD) $*
doskey gp=git push $*
doskey gpf=git push --force-with-lease $*
doskey gpl=git pull $*
doskey gup=git pull --rebase $*
doskey gsh=git stash $*
doskey gsp=git stash pop $*
doskey gm=git merge $*
doskey gm-=git merge - $*
doskey gu=git pull $*
doskey gg=git grep $*

:: My bash aliases
doskey e=exit
doskey em=emacs -nw $*
doskey vi=vim $*

:: cl commands
:: "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" x64
:: "C:\Program Files (x86)\Microsoft Visual Studio\2017\WDExpress\VC\Auxiliary\Build\vcvarsall.bat" x64
:: "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" x64

:: generate with: set > post.env
FOR /F "tokens=*" %%i in (%dotfiles_path%\post.env) do set %%i

:: NOTE(nick): this breaks things like vim and npm install
::cd C:\dev


::
:: NOTE(nick): you can create "shims" that are like symlinks that set the path variables
:: using Chocholately's built-in program like such:
::
:: C:\ProgramData\chocolatey\tools\shimgen.exe --output=C:\apps\bfxr.exe --path="C:\apps\Bfxr\Bfxr.exe"
::


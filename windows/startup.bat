@echo off

subst w: C:\Users\nick\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState\rootfs\home\nick

call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" x64

:: Linux commands
doskey alias=doskey $* $^^*
doskey sudo=runas /user:administrator $*
doskey ls=dir /w
doskey la=dir
doskey ll=dir
doskey ls=wsl ls --color $*
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

:: Easier navigation
doskey open=start $*
doskey ..    = cd ..\$*
doskey ...   = cd ..\..\$*
doskey ....  = cd ..\..\..\$*
doskey ..... = cd ..\..\..\..\$*

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

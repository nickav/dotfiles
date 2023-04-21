@echo off

subst w: C:\dev
subst n: C:\Users\Nick

:: NOTE(nick): mapping WSL (POSIX-compliant) drives to windows FS is super slow (sometimes)!
::subst u: \\wsl$\Ubuntu\home\nick

; --------------------------------------------------------------
; MacOSX keymap emulator for Windows
; --------------------------------------------------------------
#NoEnv
#SingleInstance force
#InstallKeybdHook

SetWorkingDir %A_ScriptDir%
SendMode, Input
; --------------------------------------------------------------
; Notes
; --------------------------------------------------------------
; ! = ALT
; ^ = CTRL
; + = SHIFT
; # = WIN

; permanantly disable capslock
SetCapsLockState, AlwaysOff

; map capslock+hjkl to arrow keys
CapsLock::LCtrl
LCtrl & h:: send {Left}
LCtrl & l:: send {Right}
LCtrl & j:: send {Down}
LCtrl & k:: send {Up}

;Reverse Position of Win and Alt to mimic a macs Command and Option
;LWin::LAlt
;LAlt::LWin

; Disable start menu on left winkey
LWin::return

; spectacle emulation
#!v::FullActiveWindow()
#!c::CenterActiveWindow()
#!Left::LeftSplitActiveWindow()
#!Right::RightSplitActiveWindow()

; --------------------------------------------------------------
; OS X system shortcuts
; --------------------------------------------------------------
; ctrl+backspace -> delete
^BS:: send ^+{left}{delete}

; spotlight
LAlt & Space::Send ^{Esc}
LWin & Space::Send ^{Esc}

;^Left:: send {Home}
;^Right:: send {End}

; Remap Windows + Tab to Alt + Tab.
LWin & Tab::AltTab

; command-delete deletes whole line
#BS::Send {LShift down}{Home}{LShift Up}{Del}

; alt-function-delete deletes next word
!Delete::Send {LShift down}{LCtrl down}{Right}{LShift Up}{Lctrl up}{Del}

; alt-delete deletes previous word
!BS::Send {LShift down}{LCtrl down}{Left}{LShift Up}{Lctrl up}{Del}

; arrow keys
!Up::Send {Home}
!Down::Send {End}
!Left::^Left
!Right::^Right

; letters and numbers:
#a::Send ^a
#b::Send ^b
#c::Send ^c
#d::Send ^d
#e::Send ^e
#f::Send ^f
#g::Send ^g
#h::Send ^h
#i::Send ^i
#j::Send ^j
#k::Send ^k
#l::Send ^l
#m::WinMinimize,a
#n::Send ^n
#o::Send ^o
#p::Send ^p
#q::Send !{F4}
#r::Send ^r
#s::Send ^s
#t::Send ^t
#u::Send ^u
#v::Send ^v
#w::Send ^w
#x::Send ^x
#y::Send ^y
#z::Send ^z
#1::Send ^1
#2::Send ^2
#3::Send ^3
#4::Send ^4
#5::Send ^5
#6::Send ^6
#7::Send ^7
#8::Send ^8
#9::Send ^9
#0::Send ^0

; special letters and numbers
#+r::Send ^+r
#+t::Send ^+t
#+n::Send ^+n

; lock screen
#!Pause::DllCall("LockWorkStation")

; --------------------------------------------------------------
; Application specific
; --------------------------------------------------------------

if WinActive("ahk_class Chrome_WidgetWin_1") {
  ; Show Web Developer Tools with cmd + alt + i
  #!i::Send {F12}

  ; Show source code with cmd + alt + u
  #!u::Send ^u

  ; Open History
  #+y::Send ^j
}

if WinActive("ahk_class Emacs") {
  #+v::Send +{Insert}
}

DisableLockWorkstation(value) {
  RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, %value%
}

FullActiveWindow() {
  SysGet, WA_, MonitorWorkArea
  ScreenWidth := WA_Right - WA_Left
  ScreenHeight := WA_Bottom - WA_Top
  WinGetTitle, Title, A
  WinMove, %Title%, , 0, 0, ScreenWidth, ScreenHeight
}

CenterActiveWindow() {
  ; get the actual work area. That is, screen size w/o the taskbar
  SysGet, WA_, MonitorWorkArea
  ScreenWidth := WA_Right - WA_Left
  ScreenHeight := WA_Bottom - WA_Top

  WinGetActiveStats, Title, Width, Height, X, Y
  WinMove, %Title%, , ((ScreenWidth - Width) / 2), ((ScreenHeight - Height) / 2), Width, Height
}

LeftSplitActiveWindow() {
  SysGet, WA_, MonitorWorkArea
  ScreenWidth := WA_Right - WA_Left
  ScreenHeight := WA_Bottom - WA_Top
  WinGetTitle, Title, A
  WinMove, %Title%, , 0, 0, ScreenWidth / 2, ScreenHeight
}

RightSplitActiveWindow() {
  SysGet, WA_, MonitorWorkArea
  ScreenWidth := WA_Right - WA_Left
  ScreenHeight := WA_Bottom - WA_Top
  WinGetTitle, Title, A
  WinMove, %Title%, , ScreenWidth / 2, 0, ScreenWidth / 2, ScreenHeight
}
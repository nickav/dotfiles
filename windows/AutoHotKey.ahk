; --------------------------------------------------------------
; MacOSX keymap emulator for Windows
; AutoHotkey Version 1.1.30.03
; --------------------------------------------------------------
#NoEnv
#SingleInstance force
#InstallKeybdHook

SetWorkingDir %A_ScriptDir%
SendMode, Input

; Note:
; ! = ALT
; ^ = CTRL
; + = SHIFT
; # = WIN

Init() {
  static DidInit = 0

  if (!DidInit) {
    ; Needs to be run as admin to write to registry
    if (!A_IsAdmin) {
      Run, % "*RunAs " (A_IsCompiled ? "" : A_AhkPath " ") Chr(34) A_ScriptFullPath Chr(34)
    }

    DisableLockWorkstation(1)
    DidInit = 1
  }
}

Init()

OnExit("ExitFunc")

ExitFunc(ExitReason, ExitCode) {
  DisableLockWorkstation(0)
}

; reload this script
^!r::Reload

; permanantly disable capslock, make it act like control
SetCapsLockState, AlwaysOff
CapsLock::LCtrl

; map ctrl+hjkl to arrow keys
LCtrl & h:: send {Left}
LCtrl & l:: send {Right}
LCtrl & j:: send {Down}
LCtrl & k:: send {Up}

; bind cmd+click to open in new tab
LWin & LButton::Send {MButton}

; spectacle emulation
#!v::FullActiveWindow()
#!c::CenterActiveWindow()
#!Left::LeftSplitActiveWindow()
#!h::LeftSplitActiveWindow()
#!Right::RightSplitActiveWindow()
#!l::LeftSplitActiveWindow()
^`::MoveActiveWindowToNextMonitor()

; media keys
; alt+fn
!F7::Send {Media_Prev}
!F8::Send {Media_Play_Pause}
!F9::Send {Media_Next}
!F10::Send {Volume_Mute}
!F11::Send {Volume_Down 4}
!F12::Send {Volume_Up 4}

; win+fn
#F7::Send {Media_Prev}
#F8::Send {Media_Play_Pause}
#F9::Send {Media_Next}
#F10::Send {Volume_Mute}
#F11::Send {Volume_Down 4}
#F12::Send {Volume_Up 4}

; global vim shortcuts
^[::Send {Esc}

; --------------------------------------------------------------
; OS X system shortcuts
; --------------------------------------------------------------
; ctrl+backspace -> delete
^BS:: send ^+{left}{delete}

; emoji picker
^Space::Send {LWin down}.{LWin up}

; Disable start menu on left winkey
LWin::return

; spotlight
;LWin & Space::LWin ; open windows launcher
LWin & Space::Send !{Space} ; open keypirana

; Remap Windows + Tab to Alt + Tab.
LWin & Tab::
    AltTabMenu := true
    If GetKeyState("Shift","P")
        Send {Alt Down}{Shift Down}{Tab}
    else
        Send {Alt Down}{Tab}
return

#If (AltTabMenu)
    ~*LWin Up::
        Send {Shift Up}{Alt Up}
        AltTabMenu := false
    return
#If

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
#v::
  if (WinActive("ahk_class Emacs")) {
    Send +{Insert}
  } else {
    Send ^v
  }
return
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
#=::Send ^=
#-::Send ^-
#Enter::Send ^{Enter}

; special letters and numbers
#+a::Send ^+a
#+b::Send ^+b
#+c::Send ^+c
#+d::Send ^+d
#+e::Send ^+e
#+f::Send ^+f
#+g::Send ^+g
#+h::Send ^+h
#+i::Send ^+i
#+j::Send ^+j
#+k::Send ^+k
#+l::Send ^+l
#+m::Send ^+m
#+n::Send ^+n
#+o::Send ^+o
#+p::Send ^+p
#+q::Send ^+q
#+r::Send ^+r
#+s::Send ^+s
#+t::Send ^+t
#+u::Send ^+u
#+v::Send ^+v
#+w::Send ^+w
#+x::Send ^+x
#+y::Send ^+y
#+z::Send ^+z

; lock screen
#!Pause::
  DisableLockWorkstation(0)
  Sleep 50
  DllCall("LockWorkStation")
  Sleep 50
  DisableLockWorkstation(1)
return

Enter::
  if (WinActive("ahk_class CabinetWClass")) {
    ClassNN := GetFocusedControlClassNN()
    if (ClassNN == "Edit2") {
      Send {Enter}
    } else {
      Send {F2}
    }
  } else {
    Send {Enter}
  }
return

; Keyboard Navigation

; CMD + Left/Right
#Left::
KeyWait ^
Send {Home}
return

#Right::
KeyWait ^
Send {End}
return

; CMD + Shift + Left/Right
#+Left::
KeyWait ^
Send {LControl up}
Send +{Home}
Send {LControl down}
Send {LControl up}
return

#+Right::
KeyWait ^
Send {LControl up}
Send +{End}
Send {LControl down}
Send {LControl up}
return

; Alt + Left/Right
!Left::
Send ^{Left}
return

!Right::
Send ^{Right}
return

; Alt + Shift + Left/Right
!+Left::
Send ^+{Left}
return

!+Right::
Send ^+{Right}
return


; --------------------------------------------------------------
; Application specific
; --------------------------------------------------------------

if WinActive("ahk_class Chrome_WidgetWin_1") {
  ; Show Web Developer Tools with cmd + alt + i
  #!i::Send {F12}

  ; Show source code with cmd + alt + u
  #!u::Send ^u
}

DisableLockWorkstation(value) {
  RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, %value%
}

FullActiveWindow() {
  WinGet activeWin, ID, A
  ActiveMonitor := GetMonitorIndexFromWindow(activeWin)
  SysGet, WA_, MonitorWorkArea, %ActiveMonitor%

  ScreenWidth := WA_Right - WA_Left
  ScreenHeight := WA_Bottom - WA_Top
  WinGetTitle, Title, A
  WinMove, %Title%, , 0, 0, ScreenWidth, ScreenHeight
  WinMaximize, ahk_id %activeWin%
}

CenterActiveWindow() {
  WinGet activeWin, ID, A
  ActiveMonitor := GetMonitorIndexFromWindow(activeWin)
  SysGet, WA_, MonitorWorkArea, %ActiveMonitor%

  ScreenWidth := WA_Right - WA_Left
  ScreenHeight := WA_Bottom - WA_Top

  WinGetActiveStats, Title, Width, Height, X, Y
  WinMove, %Title%, , ((ScreenWidth - Width) / 2), ((ScreenHeight - Height) / 2), Width, Height
}

LeftSplitActiveWindow() {
  WinGet activeWin, ID, A
  ActiveMonitor := GetMonitorIndexFromWindow(activeWin)
  SysGet, WA_, MonitorWorkArea, %ActiveMonitor%

  ScreenWidth := WA_Right - WA_Left
  ScreenHeight := WA_Bottom - WA_Top
  WinGetTitle, Title, A
  WinMove, %Title%, , 0, 0, ScreenWidth / 2, ScreenHeight
}

RightSplitActiveWindow() {
  WinGet activeWin, ID, A
  ActiveMonitor := GetMonitorIndexFromWindow(activeWin)
  SysGet, WA_, MonitorWorkArea, %ActiveMonitor%

  ScreenWidth := WA_Right - WA_Left
  ScreenHeight := WA_Bottom - WA_Top
  WinGetTitle, Title, A
  WinMove, %Title%, , ScreenWidth / 2, 0, ScreenWidth / 2, ScreenHeight
}

; NOTE(nick): untested
MoveActiveWindowToNextMonitor() {
  WinGet activeWin, ID, A
  ActiveMonitorIndex := GetMonitorIndexFromWindow(activeWin)
  SysGet, MonitorCount, MonitorCount

  NextMonitorIndex = ActiveMonitorIndex + 1
	if (NextMonitorIndex >= MonitorCount) {
		NextMonitorIndex = 1
  }

	; only one monitor, nothing to do
	if (NextMonitorIndex == ActiveMonitorIndex) {
    return
  }

  SysGet, WA_, MonitorWorkArea, %ActiveMonitor%
  ScreenWidth := WA_Right - WA_Left
  ScreenHeight := WA_Bottom - WA_Top
  WinGetTitle, Title, A
  WinMove, %Title%, , 0, 0, ScreenWidth, ScreenHeight
  WinMaximize, ahk_id %activeWin%
}

/**
 * GetMonitorIndexFromWindow retrieves the HWND (unique ID) of a given window.
 * @param {Uint} windowHandle
 * @author shinywong
 * @link http://www.autohotkey.com/board/topic/69464-how-to-determine-a-window-is-in-which-monitor/?p=440355
 */
GetMonitorIndexFromWindow(windowHandle) {
    ; Starts with 1.
    monitorIndex := 1
    VarSetCapacity(monitorInfo, 40)
    NumPut(40, monitorInfo)
    if (monitorHandle := DllCall("MonitorFromWindow", "uint", windowHandle, "uint", 0x2))
        && DllCall("GetMonitorInfo", "uint", monitorHandle, "uint", &monitorInfo) {
        monitorLeft   := NumGet(monitorInfo,  4, "Int")
        monitorTop    := NumGet(monitorInfo,  8, "Int")
        monitorRight  := NumGet(monitorInfo, 12, "Int")
        monitorBottom := NumGet(monitorInfo, 16, "Int")
        workLeft      := NumGet(monitorInfo, 20, "Int")
        workTop       := NumGet(monitorInfo, 24, "Int")
        workRight     := NumGet(monitorInfo, 28, "Int")
        workBottom    := NumGet(monitorInfo, 32, "Int")
        isPrimary     := NumGet(monitorInfo, 36, "Int") & 1
        SysGet, monitorCount, MonitorCount
        Loop, %monitorCount% {
            SysGet, tempMon, Monitor, %A_Index%
            ; Compare location to determine the monitor index.
            if ((monitorLeft = tempMonLeft) and (monitorTop = tempMonTop)
                and (monitorRight = tempMonRight) and (monitorBottom = tempMonBottom)) {
                monitorIndex := A_Index
                break
            }
        }
    }
    return %monitorIndex%
}

GetFocusedControlClassNN() {
  GuiWindowHwnd := WinExist("A")
  ControlGetFocus, FocusedControl, ahk_id %GuiWindowHwnd%
  return, FocusedControl
}
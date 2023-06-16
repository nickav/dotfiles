#NoEnv
#SingleInstance force
#InstallKeybdHook
#InstallMouseHook

SetWorkingDir %A_ScriptDir%
SendMode Input

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

; permanantly disable capslock, make it act like control
SetCapsLockState, AlwaysOff
CapsLock::LCtrl

; map ctrl+hjkl to arrow keys
LCtrl & h:: send {Left}
LCtrl & l:: send {Right}
LCtrl & j:: send {Down}
LCtrl & k:: send {Up}

#If GetKeyState("CapsLock", "P")
*h::send {Left}
*j::send {Down}
*k::send {Up}
*l::send {Right}
#If

; bind cmd+click to open in new tab
LWin & LButton::Send {MButton}
LAlt & LButton::Send {MButton}

; spectacle emulation
#!v::FullActiveWindow()
#!c::CenterActiveWindow()
#!Left::LeftSplitActiveWindow()
#!h::LeftSplitActiveWindow()
#!Right::RightSplitActiveWindow()
#!l::LeftSplitActiveWindow()
^`::MoveActiveWindowToNextMonitor()
#!m::MoveActiveWindowToNextMonitor()

^#!Left::TopLeftSplitActiveWindow()
^#!Right::TopRightSplitActiveWindow()
^#!Up::BottomLeftSplitActiveWindow()
^#!Down::BottomRightSplitActiveWindow()

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

; --------------------------------------------------------------
; OS X system shortcuts
; --------------------------------------------------------------
; ctrl+backspace -> delete
^BS:: send ^+{left}{delete}

; emoji picker
^!Space::
  KeyWait, LWin
  Send {LWin down}.{LWin up}
return

; command-delete deletes whole line
!BS::Send {LShift down}{Home}{LShift Up}{Del}

; alt-function-delete deletes next word
#Delete::Send {LShift down}{LCtrl down}{Right}{LShift Up}{Lctrl up}{Del}

; alt-delete deletes previous word
#BS::Send {LShift down}{LCtrl down}{Left}{LShift Up}{Lctrl up}{Del}

; arrow keys
#Up::Send {Home}
#Down::Send {End}
#Left::^Left
#Right::^Right

; letters and numbers:
!a::Send ^a
!b::Send ^b
!c::Send ^c
!d::Send ^d
!e::Send ^e
!f::Send ^f
!g::Send ^g
!h::Send ^h
!i::Send ^i
!j::Send ^j
!k::Send ^k
!l::Send ^l
!m::WinMinimize,a
!n::Send ^n
!o::Send ^o
!p::Send ^p
!q::Send !{F4}
!r::Send ^r
!s::Send ^s
!t::Send ^t
!u::Send ^u
!v::Send ^v
!w::Send ^w
!x::Send ^x
!y::Send ^y
!z::Send ^z
!1::Send ^1
!2::Send ^2
!3::Send ^3
!4::Send ^4
!5::Send ^5
!6::Send ^6
!7::Send ^7
!8::Send ^8
!9::Send ^9
!0::Send ^0
!=::Send ^=
!-::Send ^-

; special letters and numbers
!+a::Send ^+a
!+b::Send ^+b
!+c::Send ^+c
!+d::Send ^+d
!+e::Send ^+e
!+f::Send ^+f
!+g::Send ^+g
!+h::Send ^+h
!+i::Send ^+i
!+j::Send ^+j
!+k::Send ^+k
!+l::Send ^+l
!+m::Send ^+m
!+n::Send ^+n
!+o::Send ^+o
!+p::Send ^+p
!+q::Send ^+q
!+r::Send ^+r
!+s::Send ^+s
!+t::Send ^+t
!+u::Send ^+u
!+v::Send ^+v
!+w::Send ^+w
!+x::Send ^+x
!+y::Send ^+y
!+z::Send ^+z

; lock screen
#!Pause::
  DisableLockWorkstation(0)
  Sleep 50
  DllCall("LockWorkStation")
  Sleep 50
  DisableLockWorkstation(1)
return

; Keyboard Navigation

; CMD + Left/Right
!Left::
KeyWait ^
Send {Home}
return

!Right::
KeyWait ^
Send {End}
return

; CMD + Shift + Left/Right
!+Left::
KeyWait ^
Send {LControl up}
Send +{Home}
Send {LControl down}
Send {LControl up}
return

!+Right::
KeyWait ^
Send {LControl up}
Send +{End}
Send {LControl down}
Send {LControl up}
return

; Alt + Left/Right
#Left::
Send ^{Left}
return

#Right::
Send ^{Right}
return

; Alt + Shift + Left/Right
#+Left::
Send ^+{Left}
return

#+Right::
Send ^+{Right}
return

; M-x
#x::Send !x

; Cmd + `: Cycle between windows of same application
!`::    ; Next window
WinGetClass, ActiveClass, A
WinSet, Bottom,, A
WinActivate, ahk_class %ActiveClass%
return

!+`::    ; Last window
WinGetClass, ActiveClass, A
WinActivateBottom, ahk_class %ActiveClass%
return

;; mouse remapping
XButton1::RButton
XButton2::LButton

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
  WinMove, %Title%, , WA_Left, WA_Top, ScreenWidth, ScreenHeight
  WinMaximize, ahk_id %activeWin%
}

CenterActiveWindow() {
  WinGet activeWin, ID, A
  ActiveMonitor := GetMonitorIndexFromWindow(activeWin)
  SysGet, WA_, MonitorWorkArea, %ActiveMonitor%

  ScreenWidth := WA_Right - WA_Left
  ScreenHeight := WA_Bottom - WA_Top

  WinGetActiveStats, Title, Width, Height, X, Y
  WinMove, %Title%, , WA_Left + ((ScreenWidth - Width) / 2), WA_Top + ((ScreenHeight - Height) / 2), Width, Height
}

LeftSplitActiveWindow() {
  WinGet activeWin, ID, A
  ActiveMonitor := GetMonitorIndexFromWindow(activeWin)
  SysGet, WA_, MonitorWorkArea, %ActiveMonitor%

  ScreenWidth := WA_Right - WA_Left
  ScreenHeight := WA_Bottom - WA_Top
  WinRestore, ahk_id %activeWin%
  WinGetTitle, Title, A
  WinMove, %Title%, , WA_Left, WA_Top, ScreenWidth / 2, ScreenHeight
}

RightSplitActiveWindow() {
  WinGet activeWin, ID, A
  ActiveMonitor := GetMonitorIndexFromWindow(activeWin)
  SysGet, WA_, MonitorWorkArea, %ActiveMonitor%

  ScreenWidth := WA_Right - WA_Left
  ScreenHeight := WA_Bottom - WA_Top
  WinRestore, ahk_id %activeWin%
  WinGetTitle, Title, A
  WinMove, %Title%, , WA_Left + ScreenWidth / 2, WA_Top, ScreenWidth / 2, ScreenHeight
}

TopLeftSplitActiveWindow() {
  WinGet activeWin, ID, A
  ActiveMonitor := GetMonitorIndexFromWindow(activeWin)
  SysGet, WA_, MonitorWorkArea, %ActiveMonitor%

  ScreenWidth := WA_Right - WA_Left
  ScreenHeight := WA_Bottom - WA_Top
  WinRestore, ahk_id %activeWin%
  WinGetTitle, Title, A
  WinMove, %Title%, , WA_Left, WA_Top, ScreenWidth / 2, ScreenHeight / 2
}

TopRightSplitActiveWindow() {
  WinGet activeWin, ID, A
  ActiveMonitor := GetMonitorIndexFromWindow(activeWin)
  SysGet, WA_, MonitorWorkArea, %ActiveMonitor%

  ScreenWidth := WA_Right - WA_Left
  ScreenHeight := WA_Bottom - WA_Top
  WinRestore, ahk_id %activeWin%
  WinGetTitle, Title, A
  WinMove, %Title%, , WA_Left + ScreenWidth / 2, WA_Top, ScreenWidth / 2, ScreenHeight / 2
}

BottomLeftSplitActiveWindow() {
  WinGet activeWin, ID, A
  ActiveMonitor := GetMonitorIndexFromWindow(activeWin)
  SysGet, WA_, MonitorWorkArea, %ActiveMonitor%

  ScreenWidth := WA_Right - WA_Left
  ScreenHeight := WA_Bottom - WA_Top
  WinRestore, ahk_id %activeWin%
  WinGetTitle, Title, A
  WinMove, %Title%, , WA_Left, WA_Top + ScreenHeight / 2, ScreenWidth / 2, ScreenHeight / 2
}

BottomRightSplitActiveWindow() {
  WinGet activeWin, ID, A
  ActiveMonitor := GetMonitorIndexFromWindow(activeWin)
  SysGet, WA_, MonitorWorkArea, %ActiveMonitor%

  ScreenWidth := WA_Right - WA_Left
  ScreenHeight := WA_Bottom - WA_Top
  WinRestore, ahk_id %activeWin%
  WinGetTitle, Title, A
  WinMove, %Title%, , WA_Left + ScreenWidth / 2, WA_Top + ScreenHeight / 2, ScreenWidth / 2, ScreenHeight / 2
}

; NOTE(nick): untested
MoveActiveWindowToNextMonitor() {
  WinGet activeWin, ID, A
  ActiveMonitor := GetMonitorIndexFromWindow(activeWin)
  SysGet, MonitorCount, MonitorCount

  NextMonitor := ActiveMonitor + 1
	if (NextMonitor > MonitorCount) {
		NextMonitor = 1
  }

	; only one monitor, nothing to do
	if (NextMonitor == ActiveMonitor) {
    return
  }

  SysGet, Old_WA_, MonitorWorkArea, %ActiveMonitor%
  PrevScreenWidth := Old_WA_Right - Old_WA_Left
  PrevScreenHeight := Old_WA_Bottom - Old_WA_Top


  SysGet, WA_, MonitorWorkArea, %NextMonitor%
  ScreenWidth := WA_Right - WA_Left
  ScreenHeight := WA_Bottom - WA_Top

  ; TODO(nick): support monitors with different resolutions

  WinGetPos, PrevWin_X, PrevWin_Y, PrevWin_Width, PrevWin_Height, ahk_id %activeWin%

  RelPosX := PrevWin_X - Old_WA_Left
  RelPosY := PrevWin_Y - Old_WA_Top
  if (RelPosX < 0) {
    RelPosX = 0
  }
  if (RelPosY < 0) {
    RelPosY = 0
  }

  Width := PrevWin_Width
  Height := PrevWin_Height

  WinGetTitle, Title, A

  if (Width >= ScreenWidth && Height >= ScreenHeight)
  {
    WinRestore, ahk_id %activeWin%
    WinMove, %Title%, , WA_Left + RelPosX, WA_Top + RelPosY, Width, Height
    WinMaximize, ahk_id %activeWin%
  }
  else
  {
    WinMove, %Title%, , WA_Left + RelPosX, WA_Top + RelPosY, Width, Height
  }
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
        && DllCall("GetMonitorInfo", "uint", monitorHandle, "uint", &monitorInfo)
    {
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
    return monitorIndex
}

GetFocusedControlClassNN() {
  GuiWindowHwnd := WinExist("A")
  ControlGetFocus, FocusedControl, ahk_id %GuiWindowHwnd%
  return, FocusedControl
}
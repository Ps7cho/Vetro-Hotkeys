#Requires AutoHotkey v2.0
#include UIA.ahk

;----------------------------------------------------------------------
; Hotkeys
;----------------------------------------------------------------------

;General
^s:: Save()
!x:: Delete()
Esc:: ClosePanel()
XButton1:: Save() ; alternate
XButton2:: Delete() ; alternate
MButton:: ClosePanel() ; alternate
!q:: Unlock()
!Esc:: Reload

;----------------------------------------------------------------------
; General Hotkeys
;----------------------------------------------------------------------

;Chrome Variables
savePathC := [{T:30}, {T:26, i:-1}, {T:0, N:"Save"}]
deletePathC := [{T:30}, {T:26, i:-1}, {T:0, N:"Delete"}]
featureDeletionPathC := [{T:30}, {T:26, i:-1}, {T:25, A:"feature-deletion-modal"}, {T:26, A:"feature-deletion-modal___BV_modal_content_"}, {T:0, i:-1}]
ClosePanelPathC := [{T:30}, {T:26, i:-1}, {T:6}]
UnlockPathC := [{T:30}, {T:26, i:-1}, {T:21, i:-1}, {T:0}]
;Edge Variables

savePathE := [{T:33, CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33, CN:"BrowserView"}, {T:33, CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26, CN:"ant-layout-content css-14c5p6x"}, {T:0, CN:"btn ml-2 primary-custom-button justify-content-center btn-primary"}]
deletePathE := [{T:33, CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33, CN:"BrowserView"}, {T:33, CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26, CN:"ant-layout-content css-14c5p6x"}, {T:0, CN:"btn delete-custom-button justify-content-center mt-2 btn-danger"}]
featureDeletionPathE := [{T:33, CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33, CN:"BrowserView"}, {T:33, CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26, CN:"ant-layout-content css-14c5p6x"}, {T:32, A:"feature-deletion-modal"}, {T:26}, {T:26, A:"feature-deletion-modal___BV_modal_content_"}, {T:26, A:"feature-deletion-modal___BV_modal_footer_"}, {T:0, CN:"btn btn-danger"}]
ClosePanelPathE :=[{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:26}]
UnlockPathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:21,CN:"btn-toolbar pure-edit-tools-toolbar"}, {T:0}]


;Basic Functions
Save() {
    ; Function to save in Chrome or Edge
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        if chromeEl {
            try {
                saveButton := chromeEl.ElementFromPath(savePathC*)
                if saveButton
                    saveButton.Click()
            } catch {
                ; Ignore if the element path isn't found
            }
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        if edgeEl {
            try {
                saveButton := edgeEl.ElementFromPath(savePathE*)
                if saveButton
                    saveButton.Invoke()
            } catch {
                ; Ignore if the element path isn't found
            }
        }
    }
}

Delete() {
    ; Function to delete in Chrome or Edge
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.ElementFromPath(deletePathC*).Invoke()
            chromeEl.WaitElementFromPath(featureDeletionPathC*).Invoke()
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            edgeEl.ElementFromPath(deletePathE*).Invoke()
            edgeEl.WaitElementFromPath(featureDeletionPathE*).Invoke()
        } catch {
            ; Ignore if the path isn’t found
        }
    }
}

ClosePanel() {
    ; Function to close a panel in Chrome or Edge
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.ElementFromPath(ClosePanelPathC*).Invoke()
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            edgeEl.ElementFromPath(ClosePanelPathE*).Invoke()
        } catch {
            ; Ignore if the path isn’t found
        }
    }
    global SubMode

    ; Check if SubMode is not empty
    if (SubMode != "") {
        ; Deactivate the current SubMode
        SubMode := "" ; Reset SubMode
    }
}

Unlock() {
    ; Function to delete in Chrome or Edge
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.ElementFromPath(UnlockPathC*).Invoke()
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            edgeEl.ElementFromPath(UnlockPathE*).Invoke()
        } catch {
            ; Ignore if the path isn’t found
        }
    }
}

;----------------------------------------------------------------------
    ;Global Functions and paths

;Chrome paths
PencilPathC := [{T:30}, {T:26, i:-1}, {T:21, i:-1}, {T:0,N:"Edit"}]
PointPathC := [{T:30}, {T:26, i:-1}, {T:21}, {T:0,N:" Point"}]
LinePathC := [{T:30}, {T:26, i:-1}, {T:21}, {T:0,N:" Line"}]
PolygonPathC := [{T:30}, {T:26, i:-1}, {T:21}, {T:0,N:" Polygon"}]

;Edge Paths
PencilPathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:21,CN:"btn-toolbar pure-edit-tools-toolbar"}, {T:0,CN:"btn px-2 edit-tool-button btn-light", i:2}]
PointPathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:21}, {T:26}, {T:0}]
LinePathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:21}, {T:26}, {T:0,CN:"btn border px-2 btn-light", i:2}]
PolygonPathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:21}, {T:26}, {T:0,CN:"btn border px-2 btn-light", i:-1}]

Point() {
    ClosePanel()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.ElementFromPath(PencilPathC*).Invoke()
            chromeEl.WaitElementFromPath(PointPathC*).Invoke()
            chromeEl.WaitElementFromPath(FeaturePanelPathC*).Select()
            chromeEl.WaitElementFromPath(LayerPathC*).Invoke()
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            edgeEl.ElementFromPath(PencilPathE*).Invoke()
            edgeEl.WaitElementFromPath(PointPathE*).Invoke()
            edgeEl.WaitElementFromPath(FeaturePanelPathE*).Select()
            edgeEl.WaitElementFromPath(LayerPathE*).Invoke()
        } catch {
            ; Ignore if the path isn’t found
        }
    }
}

Line() {
    ClosePanel()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.ElementFromPath(PencilPathC*).Invoke()
            chromeEl.WaitElementFromPath(LinePathC*).Invoke()
            chromeEl.WaitElementFromPath(FeaturePanelPathC*).Select()
            chromeEl.WaitElementFromPath(LayerPathC*).Invoke()
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            edgeEl.ElementFromPath(PencilPathE*).Invoke()
            edgeEl.WaitElementFromPath(LinePathE*).Invoke()
            edgeEl.WaitElementFromPath(FeaturePanelPathE*).Select()
            edgeEl.WaitElementFromPath(LayerPathE*).Invoke()
        } catch {
            ; Ignore if the path isn’t found
        }
    }
}

Polygon() {
    ClosePanel()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.ElementFromPath(PencilPathC*).Invoke()
            chromeEl.WaitElementFromPath(PolygonPathC*).Invoke()
            chromeEl.WaitElementFromPath(FeaturePanelPathC*).Select()
            chromeEl.WaitElementFromPath(LayerPathC*).Invoke()
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            edgeEl.ElementFromPath(PencilPathE*).Invoke()
            edgeEl.WaitElementFromPath(PolygonPathE*).Invoke()
            edgeEl.WaitElementFromPath(FeaturePanelPathE*).Select()
            edgeEl.WaitElementFromPath(LayerPathE*).Invoke()
        } catch {
            ; Ignore if the path isn’t found
        }
    }
}
    

    
;----------------------------------------------------------------------
; Mode-Based Hotkeys
;----------------------------------------------------------------------

#Requires AutoHotkey v2.0

global Mode := ""

!F1:: {
    SetMode("Discovery")
}

!F2:: {
    SetMode("Planning")
}

!F3:: {
    SetMode("Data Entry")
}

SetMode(newMode) {
    global Mode
    if (Mode != newMode) {
        ; Switch to a new mode, skip the deactivation message
        Mode := newMode
        ToolTip(Mode " Mode Activated")
        Sleep(1000) ; Briefly show activation message
        ToolTip("") ; Clear tooltip
    } else {
        ; Toggle off the same mode
        ToolTip(Mode " Mode Deactivated")
        Mode := ""
        Sleep(1000) ; Briefly show deactivation message
        ToolTip("")
    }
}

global SubMode :=""

SetSubMode(newSubMode) {
    global SubMode
    if (SubMode != newSubMode) {
        SubMode := newSubMode
        ToolTip(SubMode " Submode Activated")
        Sleep(1000)
        ToolTip("")
    } Else {
        ToolTip(SubMode " Submode Deactivated")
        Submode := ""
        Sleep(1000)
        ToolTip("")
    }
}

#HotIf (Mode = "Discovery")
!m:: Messenger()
!u:: Units()
!p:: Plat()
!l:: Length()
!,:: PUE()
!.:: ROW()
!k:: Centerline()

#HotIf (Mode = "Planning")
!a::PDrops()
!v::Vaults()
!c::Conduit()
!f::Fiber()
!d:: {
    Drops()
    SetSubMode("Drops")
}

#HotIf (SubMode = "Drops")
1::Blue()
2::Orange()
3::Green()
4::Brown()
5::Slate()
6::White()
7::Red()
8::Black()
9::Yellow()
0::Violet()
-::Rose()
=::Aqua()


#HotIf (Mode = "Data")
!t::MsgBox("Data Entry Mode: Alt+T triggered!")
!y::MsgBox("Data Entry Mode: Alt+Y triggered!")

#HotIf

;----------------------------------------------------------------------
; Discovery
;----------------------------------------------------------------------
    ;Discovery Paths

    ;Chrome paths
    FeaturePanelPathC := [{T:30}, {T:26, i:-1}, {T:5}]
    LayerPathC := [{T:30}, {T:26, i:-1}, {T:3}]
    AutosavePathC := [{T:30}, {T:26, i:-1}, {T:2}]
    MessengerPathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"Messenger Wire"}]
    UsingPathC := [{T:30}, {T:26, i:-1}, {T:3, A:"input-using"}]
    UsingSelectPathC := [{T:30}, {T:26, i:-1}, {T:3, A:"input-using"}, {T:8}, {T:7, N:"Using"}]
    UnitsPathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"Units"}]
    NamePathC := [{T:30}, {T:26, i:-1}, {T:4}]
    UnitsPathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"Units"}]
    LengthPathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"Length"}]
    LengthInputPathC := [{T:30}, {T:26, i:-1}, {T:4, A:"input-total-length"}]
    PUEROWPathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"PUE & ROW"}]
    PLATMapLinksPathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"PLAT Map Links"}]
    ROWCenterlinePathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"ROW Centerline"}]

    ;Edge Paths
    FeaturePanelPathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:5}, {T:20}]
    LayerPathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:26,A:"__BVID__1904"}, {T:3}]
    AutosavePathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:2}]
    MessengerPathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:26,A:"__BVID__428"}, {T:3}, {T:7,N:"Messenger Wire"}]
    UsingPathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:26,CN:"d-flex flex-column overflow-auto flex-grow-1 p-3 pb-5 attributes-group-container"}, {T:26,A:"fieldset-using"}, {T:3}]
    UsingSelectPathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:26,CN:"d-flex flex-column overflow-auto flex-grow-1 p-3 pb-5 attributes-group-container"}, {T:26,A:"fieldset-using"}, {T:3}, {T:7,N:"Using"}]
    UnitsPathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:26,A:"__BVID__428"}, {T:3}, {T:7,N:"Units"}]
    NamePathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:26,A:"fieldset-number-of-units"}, {T:4}]
    UnitsPathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:26,A:"__BVID__428"}, {T:3}, {T:7,N:"Units"}]
    NamePathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:26,A:"fieldset-number-of-units"}, {T:4}]
    LengthPathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:26,A:"__BVID__428"}, {T:3}, {T:7,N:"Length"}]
    LengthInputPathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:26,A:"fieldset-total-length"}, {T:4}]
    PUEROWPathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:26,A:"__BVID__428"}, {T:3}, {T:7,N:"PUE & ROW"}]
    PLATMapLinksPathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:26,A:"__BVID__428"}, {T:3}, {T:7,N:"PLAT Map Links"}]
    ROWCenterlinePathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:26,A:"__BVID__428"}, {T:3}, {T:7,N:"ROW Centerline"}]

;----------------------------------------------------------------------
    ;Discovery Functions

    
Messenger() {
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            Line()
            chromeEl.WaitElementFromPath(MessengerPathC*).Invoke()
            chromeEl.WaitElementFromPath(UsingPathC*).Invoke()
            chromeEl.WaitElementFromPath(UsingSelectPathC*).Invoke()
            chromeEl.WaitElementFromPath(AutosavePathC*).Invoke()
            Sleep 100
            Send("{PgUp}")
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            Line()
            edgeEl.WaitElementFromPath({T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:5}, {T:20}*).Invoke()
            edgeEl.WaitElementFromPath(MessengerPathE*).Invoke()
            edgeEl.WaitElementFromPath(UsingPathE*).Invoke()
            edgeEl.WaitElementFromPath(UsingSelectPathE*).Invoke()
            edgeEl.WaitElementFromPath(AutosavePathE*).Invoke()
            Sleep 100
            Send("{PgUp}")
        } catch {
            ; Ignore if the path isn’t found
        }
    }
}

Units() {
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            Polygon()
            chromeEl.WaitElementFromPath(UnitsPathC*).Invoke()
            chromeEl.WaitElementFromPath(NamePathC*).Invoke() ;name
        } catch {
        ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            Line()
            Polygon()
            edgeEl.WaitElementFromPath(UnitsPathE*).Invoke()
            edgeEl.WaitElementFromPath(NamePathE*).Invoke() ;name
        } catch {
            ; Ignore if the path isn’t found
        }
    }
}

Plat() {
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            Polygon()
            chromeEl.WaitElementFromPath(PLATMapLinksPathC*).Invoke()
            chromeEl.WaitElementFromPath(NamePathC*).Invoke() ;name
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            Polygon()
            edgeEl.WaitElementFromPath(PLATMapLinksPathE*).Invoke()
            edgeEl.WaitElementFromPath(NamePathE*).Invoke() ;name
        } catch {
            ; Ignore if the path isn’t found
        }
    }
}

Length() {
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            Line()
            chromeEl.WaitElementFromPath(LengthPathC*).Invoke()
            chromeEl.WaitElementFromPath(NamePathC*).Invoke() ;name
            chromeEl.WaitElementFromPath(AutosavePathC*).Invoke() ; autosave
            chromeEl.WaitElementFromPath(LengthInputPathC*).Invoke()
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            Line()
            edgeEl.WaitElementFromPath(LengthPathE*).Invoke()
            edgeEl.WaitElementFromPath(NamePathE*).Invoke() ;name
            edgeEl.WaitElementFromPath(AutosavePathE*).Invoke() ; autosave
            edgeEl.WaitElementFromPath(LengthInputPathE*).Invoke()
        } catch {
            ; Ignore if the path isn’t found
        }
    }
}

PUE() {
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            Line()
            chromeEl.WaitElementFromPath(PUEROWPathC*).Invoke()
            chromeEl.WaitElementFromPath(NamePathC*).Invoke() ;name
            chromeEl.WaitElementFromPath(AutosavePathC*).Invoke() ; autosave
            chromeEl.WaitElementFromPath(NamePathC*).Value := "PUE "
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            Line()
            edgeEl.WaitElementFromPath(PUEROWPathE*).Invoke()
            edgeEl.WaitElementFromPath(NamePathE*).Invoke() ;name
            edgeEl.WaitElementFromPath(AutosavePathE*).Invoke() ; autosave
            edgeEl.WaitElementFromPath(NamePathE*).Value := "PUE "
        } catch {
            ; Ignore if the path isn’t found
        }
    }
}

ROW() {
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            Line()
            chromeEl.WaitElementFromPath(PUEROWPathC*).Invoke()
            chromeEl.WaitElementFromPath(NamePathC*).Invoke() ;name
            chromeEl.WaitElementFromPath(AutosavePathC*).Invoke() ; autosave
            chromeEl.WaitElementFromPath(NamePathC*).Value := "ROW "
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            Line()
            edgeEl.WaitElementFromPath(PUEROWPathE*).Invoke()
            edgeEl.WaitElementFromPath(NamePathE*).Invoke() ;name
            edgeEl.WaitElementFromPath(AutosavePathE*).Invoke() ; autosave
            edgeEl.WaitElementFromPath(NamePathE*).Value := "ROW "
        } catch {
            ; Ignore if the path isn’t found
        }
    }
}

Centerline() {
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            Line()
            chromeEl.WaitElementFromPath(ROWCenterlinePathC*).Invoke()
            chromeEl.WaitElementFromPath(NamePathC*).Invoke() ;name
            chromeEl.WaitElementFromPath(AutosavePathC*).Invoke() ; autosave
            chromeEl.WaitElementFromPath(NamePathC*).Value := "ROW Centerline "
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            Line()
            edgeEl.WaitElementFromPath(ROWCenterlinePathE*).Invoke()
            edgeEl.WaitElementFromPath(NamePathE*).Invoke() ;name
            edgeEl.WaitElementFromPath(AutosavePathE*).Invoke() ; autosave
            edgeEl.WaitElementFromPath(NamePathE*).Value := "ROW Centerline "
        } catch {
            ; Ignore if the path isn’t found
        }
    }
}


;----------------------------------------------------------------------
; Planning
;----------------------------------------------------------------------
    ;Planning Paths

    ;Chrome Paths
    PreliminaryDropsC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"Preliminary Drops"}]
    PDropSaveC := [{T:30}, {T:26, i:-1}, {T:2}]
    PDropTypeBoxC := [{T:30}, {T:26, i:-1}, {T:3,A:"input-type"}]
    PDropTypeC := [{T:30}, {T:26, i:-1}, {T:3,A:"input-type"}, {T:8}, {T:7,N:"Underground"}]
    VaultPathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7,N:"Vaults"}]
    ConduitPathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7,N:"Conduit"}]
    ConduitTypeBoxC := [{T:30}, {T:26, i:-1}, {T:3,A:"input-conduit-type"}]
    ConduitTypeC := [{T:30}, {T:26, i:-1}, {T:3,A:"input-conduit-type"}, {T:8}, {T:7,N:"1 x 1.25`""}]
    DFiberPathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7,N:"Distribution Fiber"}]
    DFiberCapBoxC := [{T:30}, {T:26, i:-1}, {T:3,A:"input-fiber-capacity"}]
    DFiberCapC := [{T:30}, {T:26, i:-1}, {T:3,A:"input-fiber-capacity"}, {T:8}, {T:7,N:"48"}]
    DFiberPlaceBoxC := [{T:30}, {T:26, i:-1}, {T:3,A:"input-placement"}]
    DFiberPlaceC := [{T:30}, {T:26, i:-1}, {T:3,A:"input-placement"}, {T:8}, {T:7,N:"48ct Underground"}]
    DFiberSecBoxC := [{T:30}, {T:26, i:-1}, {T:3,A:"input-fiber-sections"}]
    DFiberSecC := [{T:30}, {T:26, i:-1}, {T:3,A:"input-fiber-sections"}, {T:8}, {T:7,N:"1 - Underground"}]
    DropPathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7,N:"Drop"}]
    DropCapC := [{T:30}, {T:26, i:-1}, {T:3,A:"input-fiber-capacity"}, {T:8}, {T:7,N:"1"}]
    DropPlaceC := [{T:30}, {T:26, i:-1}, {T:3,A:"input-placement"}, {T:8}, {T:7,N:"Underground"}]
    DropColorBoxC := [{T:30}, {T:26, i:-1}, {T:3,A:"input-color"}]
    DropColorC := [{T:30}, {T:26, i:-1}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"1 - Blue"}]

;----------------------------------------------------------------------
    ;Planning Functions

PDrops() {
    ClosePanel()
    Line()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.WaitElementFromPath(PreliminaryDropsC*).Invoke()
            chromeEl.WaitElementFromPath(NamePathC*).Invoke() ;name
            chromeEl.WaitElementFromPath(PDropTypeBoxC*).Invoke()
            chromeEl.WaitElementFromPath(PDropTypeC*).Invoke()
            chromeEl.WaitElementFromPath(AutosavePathC*).Invoke()
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            edgeEl.WaitElementFromPath({T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:5}, {T:20}*).Invoke()

        } catch {
            ; Ignore if the path isn’t found
        }
    }
}

Vaults() {
    ClosePanel()
    Point()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.WaitElementFromPath(VaultPathC*).Invoke()
            chromeEl.WaitElementFromPath(NamePathC*).Invoke() ;name
            chromeEl.WaitElementFromPath(AutosavePathC*).Invoke()
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            edgeEl.WaitElementFromPath({T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:5}, {T:20}*).Invoke()

        } catch {
            ; Ignore if the path isn’t found
        }
    }
}

Conduit() {
    ClosePanel()
    Line()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.WaitElementFromPath(ConduitPathC*).Invoke()
            chromeEl.WaitElementFromPath(NamePathC*).Invoke() ;ID
            chromeEl.WaitElementFromPath(ConduitTypeBoxC*).Invoke()
            chromeEl.WaitElementFromPath(ConduitTypeC*).Invoke()
            chromeEl.WaitElementFromPath(AutosavePathC*).Invoke()
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            edgeEl.WaitElementFromPath({T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:5}, {T:20}*).Invoke()

        } catch {
            ; Ignore if the path isn’t found
        }
    }
}

Fiber() {
    ClosePanel()
    Line()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.WaitElementFromPath(DFiberPathC*).Invoke()
            chromeEl.WaitElementFromPath(NamePathC*).Invoke() ;name
            chromeEl.WaitElementFromPath(DFiberCapBoxC*).Invoke()
            chromeEl.WaitElementFromPath(DFiberCapC*).Invoke()
            chromeEl.WaitElementFromPath(DFiberPlaceBoxC*).Invoke()
            chromeEl.WaitElementFromPath(DFiberPlaceC*).Invoke()
            chromeEl.WaitElementFromPath(DFiberSecBoxC*).Invoke()
            chromeEl.WaitElementFromPath(DFiberSecC*).Invoke()
            chromeEl.WaitElementFromPath(AutosavePathC*).Invoke()
            Sleep 100
            Send("{PgUp 4}")
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            edgeEl.WaitElementFromPath({T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:5}, {T:20}*).Invoke()

        } catch {
            ; Ignore if the path isn’t found
        }
    }
}

Drops() {
    ClosePanel()
    Line()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.WaitElementFromPath(DropPathC*).Invoke()
            chromeEl.WaitElementFromPath(NamePathC*).Invoke() ;name
            chromeEl.WaitElementFromPath(DFiberCapBoxC*).Invoke()
            chromeEl.WaitElementFromPath(DropCapC*).Invoke()
            chromeEl.WaitElementFromPath(DFiberPlaceBoxC*).Invoke()
            chromeEl.WaitElementFromPath(DropPlaceC*).Invoke()
            chromeEl.WaitElementFromPath(DropColorBoxC*).Invoke()
            chromeEl.WaitElementFromPath(DropColorC*).Invoke()
            chromeEl.WaitElementFromPath(AutosavePathC*).Invoke()
            Sleep 100
            Send("{PgUp 4}")
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            edgeEl.WaitElementFromPath({T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:5}, {T:20}*).Invoke()

        } catch {
            ; Ignore if the path isn’t found
        }
    }
}

    DropColorPath := [{T:30}, {T:26, i:-1}, {T:3,A:"input-color"}]
    bluepath := [{T:30}, {T:26, i:-1}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"1 - Blue"}]
    orangepath := [{T:30}, {T:26, i:-1}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"2 - Orange"}]
    greenpath := [{T:30}, {T:26, i:-1}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"3 - Green"}]
    brownpath := [{T:30}, {T:26, i:-1}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"4 - Brown"}]
    slatepath := [{T:30}, {T:26, i:-1}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"5 - Slate"}]
    whitepath := [{T:30}, {T:26, i:-1}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"6 - White"}]
    redpath := [{T:30}, {T:26, i:-1}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"7 - Red"}]
    blackpath := [{T:30}, {T:26, i:-1}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"8 - Black"}]
    yellowpath := [{T:30}, {T:26, i:-1}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"9 - Yellow"}]
    violetpath := [{T:30}, {T:26, i:-1}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"10 - Violet"}]
    rosepath := [{T:30}, {T:26, i:-1}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"11 - Rose"}]
    aquapath := [{T:30}, {T:26, i:-1}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"12 - Aqua"}]
    NotePathC := [{T:30}, {T:26, i:-1}, {T:4,A:"input-note"}]

    SetDropColor(expectedValue, pathToSelectColor, NotePathC) {
        if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
            chromeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                dropColorElement := chromeEl.ElementFromPath(DropColorPath*)
                currentValue := dropColorElement.Value
                if (currentValue != expectedValue) {
                    dropColorElement.Invoke()
                    chromeEl.WaitElementFromPath(pathToSelectColor*).Invoke()
                }
                chromeEl.WaitElementFromPath(NotePathC*).Invoke()
            } catch {
                ; Handle errors gracefully
            }
        } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
            edgeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                dropColorElement := edgeEl.ElementFromPath(DropColorPath*)
                currentValue := dropColorElement.Value
                if (currentValue != expectedValue) {
                    dropColorElement.Invoke()
                    edgeEl.WaitElementFromPath(pathToSelectColor*).Invoke()
                }
                edgeEl.WaitElementFromPath(NotePathC*).Invoke()
            } catch {
                ; Handle errors gracefully
            }
        }
    }
    
    Blue() {
        SetDropColor("1 - Blue", bluepath, NotePathC)
    }
    
    Orange() {
        SetDropColor("2 - Orange", orangepath, NotePathC)
    }
    
    Green() {
        SetDropColor("3 - Green", greenpath, NotePathC)
    }
    
    Brown() {
        SetDropColor("4 - Brown", brownpath, NotePathC)
    }
    
    Slate() {
        SetDropColor("5 - Slate", slatepath, NotePathC)
    }
    
    White() {
        SetDropColor("6 - White", whitepath, NotePathC)
    }
    
    Red() {
        SetDropColor("7 - Red", redpath, NotePathC)
    }
    
    Black() {
        SetDropColor("8 - Black", blackpath, NotePathC)
    }
    
    Yellow() {
        SetDropColor("9 - Yellow", yellowpath, NotePathC)
    }
    
    Violet() {
        SetDropColor("10 - Violet", violetpath, NotePathC)
    }
    
    Rose() {
        SetDropColor("11 - Rose", rosepath, NotePathC)
    }
    
    Aqua() {
        SetDropColor("12 - Aqua", aquapath, NotePathC)
    }
    

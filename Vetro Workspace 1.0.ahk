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

;----------------------------------------------------------------------
; General Hotkeys
;----------------------------------------------------------------------

;Chrome Variables
savePathC := [{T:30}, {T:26, i:-1}, {T:0, N:"Save"}]
deletePathC := [{T:30}, {T:26, i:-1}, {T:0, N:"Delete"}]
featureDeletionPathC := [{T:30}, {T:26, i:-1}, {T:25, A:"feature-deletion-modal"}, {T:26, A:"feature-deletion-modal___BV_modal_content_"}, {T:0, i:-1}]
ClosePanelPathC := [{T:30}, {T:26, i:-1}, {T:6}]
;Edge Variables

savePathE := [{T:33, CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33, CN:"BrowserView"}, {T:33, CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26, CN:"ant-layout-content css-14c5p6x"}, {T:0, CN:"btn ml-2 primary-custom-button justify-content-center btn-primary"}]
deletePathE := [{T:33, CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33, CN:"BrowserView"}, {T:33, CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26, CN:"ant-layout-content css-14c5p6x"}, {T:0, CN:"btn delete-custom-button justify-content-center mt-2 btn-danger"}]
featureDeletionPathE := [{T:33, CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33, CN:"BrowserView"}, {T:33, CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26, CN:"ant-layout-content css-14c5p6x"}, {T:32, A:"feature-deletion-modal"}, {T:26}, {T:26, A:"feature-deletion-modal___BV_modal_content_"}, {T:26, A:"feature-deletion-modal___BV_modal_footer_"}, {T:0, CN:"btn btn-danger"}]
ClosePanelPathE :=[{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:26}]


;Functions
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
}

;----------------------------------------------------------------------
; Discovery Hotkeys
;----------------------------------------------------------------------

; General Discovery Hotkeys
!q:: Unlock()
!m:: Messenger()
!u:: Units()
!p:: Plat()
!l:: Length()
!,:: PUE()
!.:: ROW()
!k:: Centerline()

;----------------------------------------------------------------------

;Chrome paths
UnlockPathC := [{T:30}, {T:26, i:-1}, {T:21, i:-1}, {T:0}]
PencilPathC := [{T:30}, {T:26, i:-1}, {T:21, i:-1}, {T:0,N:"Edit"}]
PointPathC := [{T:30}, {T:26, i:-1}, {T:21}, {T:0,N:" Point"}]
LinePathC := [{T:30}, {T:26, i:-1}, {T:21}, {T:0,N:" Line"}]
PolygonPathC := [{T:30}, {T:26, i:-1}, {T:21}, {T:0,N:" Polygon"}]
FeaturePanelPathC := [{T:30}, {T:26, i:-1}, {T:5}]
LayerPathC := [{T:30}, {T:26, i:-1}, {T:3}]
AutosavePathC := [{T:30}, {T:26, i:-1}, {T:2}]
MessengerPathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"Messenger Wire"}]
UsingPathC := [{T:30}, {T:26, i:-1}, {T:3, A:"input-using"}]
UsingSelectPathC := [{T:30}, {T:26, i:-1}, {T:3, A:"input-using"}, {T:8}, {T:7, N:"Using"}]
UnitsPathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"Units"}]
NamePathC := [{T:30}, {T:26, i:-1}, {T:4}]
UnitsPathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"Units"}]
NamePathC := [{T:30}, {T:26, i:-1}, {T:4}]
LengthPathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"Length"}]
LengthInputPathC := [{T:30}, {T:26, i:-1}, {T:4, A:"input-total-length"}]
PUEROWPathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"PUE & ROW"}]
PLATMapLinksPathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"PLAT Map Links"}]
ROWCenterlinePathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"ROW Centerline"}]

;Edge Paths
UnlockPathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:21,CN:"btn-toolbar pure-edit-tools-toolbar"}, {T:0}]
PencilPathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:21,CN:"btn-toolbar pure-edit-tools-toolbar"}, {T:0,CN:"btn px-2 edit-tool-button btn-light", i:2}]
PointPathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:21}, {T:26}, {T:0}]
LinePathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:21}, {T:26}, {T:0,CN:"btn border px-2 btn-light", i:2}]
PolygonPathE := [{T:33,CN:"BrowserRootView"}, {T:33}, {T:33}, {T:33,CN:"BrowserView"}, {T:33,CN:"SidebarContentsSplitView"}, {T:33}, {T:33}, {T:33}, {T:33}, {T:33}, {T:30}, {T:26}, {T:26}, {T:26,CN:"ant-layout-content css-14c5p6x"}, {T:21}, {T:26}, {T:0,CN:"btn border px-2 btn-light", i:-1}]
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

Point() {
    ; Function to delete in Chrome or Edge
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
    ; Function to delete in Chrome or Edge
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
    ; Function to delete in Chrome or Edge
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


Messenger() {
    ; Function to delete in Chrome or Edge
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
    ; Function to delete in Chrome or Edge
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
    ; Function to delete in Chrome or Edge
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
    ; Function to delete in Chrome or Edge
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
    ; Function to delete in Chrome or Edge
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
    ; Function to delete in Chrome or Edge
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
    ; Function to delete in Chrome or Edge
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

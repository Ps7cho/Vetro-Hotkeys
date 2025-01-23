#Requires AutoHotkey v2.0
#include UIA.ahk

;----------------------------------------------------------------------
; Hotkeys
;----------------------------------------------------------------------

;General
!s:: Save()
!x:: Delete()
Esc:: ClosePanel()
XButton1:: Save() ; alternate
XButton2::Delete() ; alternate
MButton:: {
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        ClosePanel() ; Call your custom function
    } else {
        Send "{MButton}" ; Simulate the default middle mouse button action
    }
return
}
!q:: Unlock()
!Esc:: Reload

; Helper function to check if Chrome with VETRO is active


;CheckAndExecute(functionName, keyAction) {
;    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
;        %functionName%() ; Call the passed function
;    } else {
;        Send keyAction ; Send the key action with {} for special keys
;    }
;}
;
;!s:: CheckAndExecute("Save", "!s")
;!x:: CheckAndExecute("Delete", "!x")
;Esc:: CheckAndExecute("ClosePanel", "{Esc}")
;XButton1:: CheckAndExecute("Save", "{XButton1}") ; alternate
;XButton2:: CheckAndExecute("Delete", "{XButton2}") ; alternate
;MButton:: CheckAndExecute("ClosePanel", "{MButton}") ; Middle button click

;!q:: CheckAndExecute("Unlock", "!q")
;!Esc:: CheckAndExecute("Reload", "!{Esc}")



;----------------------------------------------------------------------
; General Hotkeys
;----------------------------------------------------------------------

;Chrome Variables
savePathC := [{T:30}, {T:26, i:-1}, {T:0, N:"Save"}]
deletePathC := [{T:30}, {T:26, i:-1}, {T:0,N:"Delete"}]
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
    } 

Delete() {
    ; Function to delete in Chrome or Edge
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        deleteButton := FindButtonByName(chromeEl, "Delete")
        if deleteButton {
            try {
                deleteButton.Invoke()
                ; Optional: Wait for confirmation or next action
                chromeEl.WaitElementFromPath(featureDeletionPathC*).Invoke()
            } catch {
                ; Ignore if the path isn’t found
            }
        }
    } 
}

; Function to find a button by its Name
FindButtonByName(rootElement, partialName) {
    buttons := rootElement.FindAll({Type: "Button"})
    for button in buttons {
        if (InStr(button.Name, partialName)) {
            return button
        }
    }
    return 0 ; Return 0 if no matching button is found
}


ClosePanel() {
    global SubMode

    ; Function to close a panel in Chrome or Edge
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.ElementFromPath(ClosePanelPathC*).Invoke()
        } catch {
            ; Log or ignore if the path isn’t found
            ; OutputDebug "ClosePanelPathC not found"
        }
    } 

    ; Check if SubMode is not empty
    if (SubMode != "") {
        ; Deactivate the current SubMode
        SubMode := "" ; Reset SubMode
    }
}


Unlock() {
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.ElementFromPath(UnlockPathC*).Invoke()
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
    Sleep 100
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
    Sleep 100
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
    Sleep 100
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
        ; Switch to a new mode
        Mode := newMode
        ToolTip(Mode " Mode Activated")
        Sleep(1000) ; Briefly show activation message
        ToolTip("") ; Clear tooltip
    }
}

global SubMode := ""

SetSubMode(newSubMode) {
    global SubMode
    if (SubMode != newSubMode) {
        SubMode := newSubMode
        ToolTip(SubMode " Submode Activated")
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
!;:: ServiceLocations()

#HotIf (Mode = "Planning")
!a::PDrops()
!v::Vaults()
!c::Conduit()
!f::Fiber()
!d:: {
    Drops()
    SetSubMode("Drops")
}
!n:: {
    Naps()
    SetSubMode("Naps")
}
!w:: {
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        SlackLoops() ; Call your custom function
    } else {
        Send "!w" ; Simulate the default middle mouse button action
    }
return
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

    #HotIf (SubMode = "Naps")
    Space::SetNapType()
    a::SetNapLocation()
    w::TwentyFour()
    e::FourtyEight()
    r::SeventyTwo()

#HotIf (Mode = "Data Entry")
!n::Naps()
!w:: SlackLoops()

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
    IDPathC := [{T:30}, {T:26, i:-1}, {T:26}, {T:4}]

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
    Line()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
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
    Polygon()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.WaitElementFromPath(UnitsPathC*).Invoke()
            chromeEl.WaitElementFromPath(NamePathC*).Invoke() ;name
        } catch {
        ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            edgeEl.WaitElementFromPath(UnitsPathE*).Invoke()
            edgeEl.WaitElementFromPath(NamePathE*).Invoke() ;name
        } catch {
            ; Ignore if the path isn’t found
        }
    }
}

Plat() {
    Polygon()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.WaitElementFromPath(PLATMapLinksPathC*).Invoke()
            chromeEl.WaitElementFromPath(NamePathC*).Invoke() ;name
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            edgeEl.WaitElementFromPath(PLATMapLinksPathE*).Invoke()
            edgeEl.WaitElementFromPath(NamePathE*).Invoke() ;name
        } catch {
            ; Ignore if the path isn’t found
        }
    }
}

Length() {
    Line()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
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
    Line()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.WaitElementFromPath(PUEROWPathC*).Invoke()
            chromeEl.WaitElementFromPath({T:30}, {T:26, i:-1}, {T:4}).Invoke() ;name
            chromeEl.WaitElementFromPath(AutosavePathC*).Invoke() ; autosave
            chromeEl.WaitElementFromPath({T:30}, {T:26, i:-1}, {T:4}).Invoke()
            Sleep 100
            Send "' PUE"
            Send "{Home}"
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
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
    Line()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.WaitElementFromPath(PUEROWPathC*).Invoke()
            chromeEl.WaitElementFromPath(NamePathC*).Invoke() ;name
            chromeEl.WaitElementFromPath(AutosavePathC*).Invoke() ; autosave
            chromeEl.WaitElementFromPath(NamePathC*).Invoke()
            Sleep 100
            Send "' ROW"
            Send "{Home}"
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
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
    Line()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {

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
            edgeEl.WaitElementFromPath(ROWCenterlinePathE*).Invoke()
            edgeEl.WaitElementFromPath(NamePathE*).Invoke() ;name
            edgeEl.WaitElementFromPath(AutosavePathE*).Invoke() ; autosave
            edgeEl.WaitElementFromPath(NamePathE*).Value := "ROW Centerline "
        } catch {
            ; Ignore if the path isn’t found
        }
    }
}

!e::ServiceLocations()

ServiceLocations() {
    Sleep 100
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            Point()
            chromeEl.WaitElementFromPath({T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"Service Location"}).Invoke()
            chromeEl.WaitElementFromPath(IDPathC*).Invoke()
            chromeEl.WaitElementFromPath(AutoSavePathNetworkC*).Invoke()
            chromeEl.WaitElementFromPath(IDPathC*).Invoke()
        } catch {
            ; Ignore if the path isn’t found
        }
    } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
        edgeEl := UIA.ElementFromHandle(WinExist("A"))
        try {

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
    DFiberCapBoxC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-fiber-capacity"}]
    DFiberCapC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-fiber-capacity"}, {T:8}, {T:7,N:"48"}]
    DFiberPlaceBoxC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-placement"}]
    DFiberPlaceC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-placement"}, {T:8}, {T:7,N:"48ct Underground"}]
    DFiberSecBoxC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-fiber-sections"}]
    DFiberSecC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-fiber-sections"}, {T:8}, {T:7,N:"1 - Underground"}]
    DropPathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7,N:"Drop"}]
    DropCapC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-fiber-capacity"}, {T:8}, {T:7,N:"1"}]
    DropPlaceC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-placement"}, {T:8}, {T:7,N:"Underground"}]
    DropColorBoxC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-color"}]
    DropColorC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"1 - Blue"}]

    AutosavePathNetworkC := [{T:30}, {T:26, i:-1}, {T:26}, {T:2}]

;----------------------------------------------------------------------
    ;Planning Functions

PDrops() {
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
    Line()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.WaitElementFromPath(DFiberPathC*).Invoke()
            chromeEl.WaitElementFromPath(IDPathC*).Invoke() ;name
            chromeEl.WaitElementFromPath(DFiberCapBoxC*).Invoke()
            chromeEl.WaitElementFromPath(DFiberCapC*).Invoke()
            chromeEl.WaitElementFromPath(DFiberPlaceBoxC*).Invoke()
            chromeEl.WaitElementFromPath(DFiberPlaceC*).Invoke()
            chromeEl.WaitElementFromPath(DFiberSecBoxC*).Invoke()
            chromeEl.WaitElementFromPath(DFiberSecC*).Invoke()
            chromeEl.WaitElementFromPath(AutosavePathNetworkC*).Invoke()
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
    Line()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.WaitElementFromPath(DropPathC*).Invoke()
            chromeEl.WaitElementFromPath({T:30}, {T:26, i:-1}, {T:26}, {T:4}).Invoke() ;name
            chromeEl.WaitElementFromPath(DFiberCapBoxC*).Invoke()
            chromeEl.WaitElementFromPath(DropCapC*).Invoke()
            chromeEl.WaitElementFromPath(DFiberPlaceBoxC*).Invoke()
            chromeEl.WaitElementFromPath(DropPlaceC*).Invoke()
            chromeEl.WaitElementFromPath(DropColorBoxC*).Invoke()
            chromeEl.WaitElementFromPath(DropColorC*).Invoke()
            chromeEl.WaitElementFromPath(AutosavePathNetworkC*).Invoke()
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

    DropColorPath := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-color"}]
    bluepath := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"1 - Blue"}]
    orangepath := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"2 - Orange"}]
    greenpath := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"3 - Green"}]
    brownpath := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"4 - Brown"}]
    slatepath := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"5 - Slate"}]
    whitepath := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"6 - White"}]
    redpath := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"7 - Red"}]
    blackpath := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"8 - Black"}]
    yellowpath := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"9 - Yellow"}]
    violetpath := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"10 - Violet"}]
    rosepath := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"11 - Rose"}]
    aquapath := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-color"}, {T:8}, {T:7,N:"12 - Aqua"}]
    NotePathC := [{T:30}, {T:26, i:-1}, {T:26}, {T:4,A:"input-note"}]

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
    

;----------------------------------------------------------------------
    ;Data Entry Hotkeys

    NapPathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7,N:"NAP"}] 
    TypePathC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-type"}]
    TypeSelectC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-type"}, {T:8}, {T:7,N:"UG NAP"}]
    LocationPathC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-nap-location"}]
    LocationSelectC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-nap-location"}, {T:8}, {T:7, N:"Underground"}]
    FiberCountPathC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-fiber-count"}]
    FiberCountSelectC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-fiber-count"}, {T:8}, {T:7, N:"48ct"}]

    Naps() {
        Point()
        if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
            chromeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                chromeEl.WaitElementFromPath(NapPathC*).Invoke()
                chromeEl.WaitElementFromPath(IDPathC*).Invoke() ;name
                chromeEl.WaitElementFromPath(TypePathC*).Invoke()
                chromeEl.WaitElementFromPath(TypeSelectC*).Invoke()
                chromeEl.WaitElementFromPath(LocationPathC*).Invoke()
                chromeEl.WaitElementFromPath(LocationSelectC*).Invoke()
                chromeEl.WaitElementFromPath(FiberCountPathC*).Invoke()
                chromeEl.WaitElementFromPath(FiberCountSelectC*).Invoke()
                chromeEl.WaitElementFromPath(AutosavePathNetworkC*).Invoke()
                chromeEl.WaitElementFromPath(IDPathC*).Invoke()

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

    NapTypePathC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-type"}]
    NapTypePathUGSelectC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-type"}, {T:8}, {T:7, n:"UG NAP"}]
    NapTypePathAESelectC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-type"}, {T:8}, {T:7, n:"AE Regular"}]
    NapTypePathUGTieSelectC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-type"}, {T:8}, {T:7, n:"UG Tie Point"}]
    NapTypePathAETieSelectC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-type"}, {T:8}, {T:7, n:"AE Tie Point"}]

    NapLocationPathC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-nap-location"}]
    NapLocationPathUGSelectC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-nap-location"}, {T:8}, {T:7, N:"Underground"}]
    NapLocationPathAESelectC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-nap-location"}, {T:8}, {T:7, N:"Aerial"}]

    NapFiberPathC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-fiber-count"}]
    NapFiberPath24SelectC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-fiber-count"}, {T:8}, {T:7, N:"24ct"}]
    NapFiberPath48SelectC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-fiber-count"}, {T:8}, {T:7, N:"48ct"}]
    NapFiberPath72SelectC := [{T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-fiber-count"}, {T:8}, {T:7, N:"72ct"}]

    SetNapLocation() {
        if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
            chromeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                NapTypeElement := chromeEl.ElementFromPath(NapLocationPathC*)
                currentValue := NapTypeElement.Value
                if (currentValue = "Underground") {
                    chromeEl.ElementFromPath(NapTypePathC*).Invoke()
                    chromeEl.WaitElementFromPath(NapTypePathAESelectC*).Invoke()
                    chromeEl.WaitElementFromPath(NapLocationPathC*).Invoke()
                    chromeEl.WaitElementFromPath(NapLocationPathAESelectC*).Invoke()
                    chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                }
                else if (currentValue = "Aerial") {
                    chromeEl.ElementFromPath(NapTypePathC*).Invoke()
                    chromeEl.WaitElementFromPath(NapTypePathUGSelectC*).Invoke()
                    chromeEl.WaitElementFromPath(NapLocationPathC*).Invoke()
                    chromeEl.WaitElementFromPath(NapLocationPathUGSelectC*).Invoke()
                    chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                }

            } catch {
                ; Handle errors gracefully
            }
        } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
            edgeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                NapTypeElement := edgeEl.ElementFromPath(NapLocationPathC*)
                currentValue := NapTypeElement.Value
                if (currentValue != "Aerial") {
                    NapTypeElement.Invoke()
                    edgeEl.WaitElementFromPath(NotePathC*).Invoke()
                }
                edgeEl.WaitElementFromPath(NotePathC*).Invoke()
            } catch {
                ; Handle errors gracefully
            }
        }
    }

    SetNapType() {
        if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
            chromeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                NapTypeElement := chromeEl.ElementFromPath(NapTypePathC*)
                currentValue := NapTypeElement.Value
                if (currentValue = "UG NAP") {
                    chromeEl.ElementFromPath(NapTypePathC*).Invoke()
                    chromeEl.WaitElementFromPath(NapTypePathUGTieSelectC*).Invoke()
                    chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                }
                else if (currentValue = "AE Regular") {
                    chromeEl.ElementFromPath(NapTypePathC*).Invoke()
                    chromeEl.WaitElementFromPath(NapTypePathAETieSelectC*).Invoke()
                    chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                }
                else if (currentValue = "UG Tie Point") {
                    chromeEl.ElementFromPath(NapTypePathC*).Invoke()
                    chromeEl.WaitElementFromPath(NapTypePathUGSelectC*).Invoke()
                    chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                }
                else if (currentValue = "AE Tie Point") {
                    chromeEl.ElementFromPath(NapTypePathC*).Invoke()
                    chromeEl.WaitElementFromPath(NapTypePathAESelectC*).Invoke()
                    chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                }

            } catch {
                ; Handle errors gracefully
            }
        } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
            edgeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                NapTypeElement := edgeEl.ElementFromPath(NapLocationPathC*)
                currentValue := NapTypeElement.Value
                if (currentValue != "Aerial") {
                    NapTypeElement.Invoke()
                    edgeEl.WaitElementFromPath(IDPathC*).Invoke()
                }
                edgeEl.WaitElementFromPath(NotePathC*).Invoke()
            } catch {
                ; Handle errors gracefully
            }
        }
    }

    SetNapFiber(expectedValue, pathToSelectFiber) {
        if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
            chromeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                NapFiberElement := chromeEl.ElementFromPath(NapFiberPathC*)
                currentValue := NapFiberElement.Value
                if (currentValue != expectedValue) {
                    NapFiberElement.Invoke()
                    chromeEl.WaitElementFromPath(pathToSelectFiber*).Invoke()
                }
                chromeEl.WaitElementFromPath(IDPathC*).Invoke()
            } catch {
                ; Handle errors gracefully
            }
        } else if WinActive("ahk_exe msedge.exe") && InStr(WinGetTitle("A"), "VETRO") {
            edgeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                NapFiberElement := edgeEl.ElementFromPath(NapFiberPathC*)
                currentValue := NapFiberElement.Value
                if (currentValue != expectedValue) {
                    NapFiberElement.Invoke()
                    edgeEl.WaitElementFromPath(pathToSelectFiber*).Invoke()
                }
                edgeEl.WaitElementFromPath(IDPathC*).Invoke()
            } catch {
                ; Handle errors gracefully
            }
        }
    }

    TwentyFour() {
        SetNAPFiber("24ct", NapFiberPath24SelectC)
    }

    FourtyEight() {
        SetNapFiber("48ct", NapFiberPath48SelectC)
    }

    SeventyTwo() {
        SetNapFiber("72ct", NapFiberPath72SelectC)
    }


SlackLoops() {
    Point()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.WaitElementFromPath({T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7,N:"Slack Loop"}).Invoke()
            chromeEl.WaitElementFromPath(IDPathC*).Invoke() ;Collapse
            chromeEl.WaitElementFromPath({T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-slack-loop"}).Invoke()
            chromeEl.WaitElementFromPath({T:30}, {T:26, i:-1}, {T:26}, {T:3,A:"input-slack-loop"}, {T:8}, {T:7, N:"30' Loop"}).Invoke()
            chromeEl.WaitElementFromPath({T:30}, {T:26, i:-1}, {T:26}, {T:4}).Invoke() ;Collapse
            sleep 100
            Send "30"
            chromeEl.WaitElementFromPath(AutosavePathNetworkC*).Invoke() ;Collapse
            Sleep 100
            Send("{PgUp}")


        } catch {
            ; Ignore if the path isn’t found
        }
    } 
}
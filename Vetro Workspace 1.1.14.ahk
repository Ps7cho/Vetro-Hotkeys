#Requires AutoHotkey v2.0
#include UIA.ahk

; #region General Hotkeys
;----------------------------------------------------------------------


#HotIf WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO")
Esc:: ClosePanel()
F3::ShowHelp()
!s:: Save()
!x:: Delete()
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
#HotIf
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

;Chrome Variables
savePathC := [{T:30}, {T:26, i:-1}, {T:0, N:"Save"}]
deletePathC := [{T:30}, {T:26, i:-1}, {T:0,N:"Delete"}]
featureDeletionPathC := [{T:30}, {T:26, i:-1}, {T:25, A:"feature-deletion-modal"}, {T:26, A:"feature-deletion-modal___BV_modal_content_"}, {T:0, i:-1}]
ClosePanelPathC := [{T:30}, {T:26, i:-1}, {T:0}] 
UnlockPathC := [{T:30}, {T:26, i:-1}, {T:21, i:-1}, {T:0}]

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

; #endregion----------------------------------------------------------------------
; #region Global Functions and paths

;Chrome paths
PencilPathC := [{T:30}, {T:26, i:-1}, {T:21, i:-1}, {T:0,N:"Edit"}]
PointPathC := [{T:30}, {T:26, i:-1}, {T:21}, {T:0,N:" Point"}]
LinePathC := [{T:30}, {T:26, i:-1}, {T:21}, {T:0,N:" Line"}]
PolygonPathC := [{T:30}, {T:26, i:-1}, {T:21}, {T:0,N:" Polygon"}]

ShowHelp() {
    global Mode, SubMode
    helpText := "VETRO Hotkeys`n-------------------`n"
    if (Mode = "Discovery") {
        helpText .= "Messenger: ALT+M`nUnits: ALT+U`nPlat: ALT+P`nLength: ALT+L`nPUE: ALT+,`nROW: ALT+.`nCenterline: ALT+K`nService Locations: ALT+;"
    } else if (Mode = "Planning") {
        helpText .= "PDrops: ALT+A`nVaults: ALT+V`nConduit: ALT+C`nFiber: ALT+F`nDrops: ALT+D`nNaps: ALT+N`nSlack Loops: ALT+W"
        if (SubMode = "Preliminary Drops") {
            helpText .= "`n--- Preliminary Drops Submode ---`nA - Switch Type (Underground/Aerial)"
        } else if (SubMode = "Drops") {
            helpText .= "`n--- Drops Submode ---`n1-Blue, 2-Orange, 3-Green, 4-Brown, 5-Slate, 6-White, 7-Red, 8-Black, 9-Yellow, 0-Violet, -Rose, =Aqua"
        } else if (SubMode = "Naps") {
            helpText .= "`n--- Naps Submode ---`nSPACE-Type, A-Location, W-24CT, E-48CT, R-72CT"
        } else if (SubMode = "Vaults") {
            helpText .= "`n--- Vaults Submode ---`nV - Switch Vault"
        } else if (SubMode = "Slack Loops") {
            helpText .= "`n--- Slack Loops Submode ---`nA-Placement, W-Loop, E-Tail, R-60/24, Q-70 Tail, 1-4 Fiber Section"
        }
    } else if (Mode = "Data Entry") {
        helpText .= "Naps: ALT+N`nSlack Loops: ALT+W"
    } else {
        helpText .= "No mode active.`nALT+F1: Discovery Mode`nALT+F2: Planning Mode`nALT+F3: Data Entry Mode"
    }
    MsgBox(helpText, "VETRO Hotkey Help")
}

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
    }
}
    

    
; #endregion----------------------------------------------------------------------
; #region Mode-Based Hotkeys
;----------------------------------------------------------------------

global Mode := "", SubMode := "", storedMode := "", storedSubMode := ""

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

SetSubMode(newSubMode) {
    global SubMode
    if (SubMode != newSubMode) {
        SubMode := newSubMode
        ToolTip(SubMode " Submode Activated")
        Sleep(1000)
        ToolTip("")
    }
}

StoreSubmode() {
    ; switch to no submode and store the current submode and reactivate it late
    global SubMode, Mode, storedSubMode, storedMode
    storedSubMode := SubMode
    storedMode := Mode
    SetSubMode("Wait") ; temporary set SubMode
    SetTimer(CheckWaitMode, 1000) ; Check every second
}

CheckWaitMode() {
    global storedSubMode, storedMode
    if SubMode = "Wait"{
        if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
            SetSubMode(storedSubMode) ; Reactivate the stored SubMode
            SetTimer(CheckWaitMode, 0) ; Stop the timer
        }else{
            SetTimer(CheckWaitMode, 1000)
        }
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

#HotIf (SubMode = "Preliminary Drops")
a:: SwitchPrelimDropType()

#HotIf (Mode = "Planning")
!a:: {
    PDrops()
    SetSubMode("Preliminary Drops")
}
!v:: {
    Vaults()
    SetSubMode("Vaults")
}
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
    SlackLoops()
    SetSubMode("Slack Loops")
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

#HotIf (SubMode = "Vaults")
v::SwitchVault()

#HotIf (SubMode = "Slack Loops")
a:: SlackLoopLocation()
w:: ThirtyLoop()
e:: ThirtyTail()
r:: SixtyLoop()
q:: Set70Tail()

1:: SetFiberSection(1)
2:: SetFiberSection(2)
3:: SetFiberSection(3)
4:: SetFiberSection(4)
#HotIf
    

; #endregion----------------------------------------------------------------------
; #region Discovery
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
    ServiceLocation := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"Service Location"}]
    IDPathC := [{T:30}, {T:26, i:-1}, {T:4}]
    

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
    }
}

ServiceLocations() {
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        
            Point()
            chromeEl.WaitElementFromPath(ServiceLocation*).Invoke()
            chromeEl.WaitElementFromPath(IDPathC*).Invoke()
            chromeEl.WaitElementFromPath(AutoSavePathNetworkC*).Invoke()
            chromeEl.WaitElementFromPath(IDPathC*).Invoke()
        
            ; Ignore if the path isn’t found
        
    }
}



; #endregion ----------------------------------------------------------------------
; #region Planning
;----------------------------------------------------------------------
    ;Planning Paths

    ;Chrome Paths
    PreliminaryDropsC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"Preliminary Drops"}]
    PDropSaveC := [{T:30}, {T:26, i:-1}, {T:2}]
    PDropTypeBoxC := [{T:30}, {T:26, i:-1}, {T:3, A:"input-type"}]
    PDropTypeC := [{T:30}, {T:26, i:-1}, {T:3, A:"input-type"}, {T:8}, {T:7, N:"Underground"}]
    VaultPathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"Vaults"}]
    VaultTypeBoxC := [{T:30}, {T:26, i:-1}, {T:3, A:"input-size"}]
    VaultTypeC := [{T:30}, {T:26, i:-1}, {T:3, A:"input-size"}, {T:8}, {T:7, N:"DV"}]
    VaultTypeB := [{T:30}, {T:26, i:-1}, {T:3, A:"input-size"}, {T:8}, {T:7, N:"LDV"}]
    ConduitPathC := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"Conduit"}]
    ConduitTypeBoxC := [{T:30}, {T:26, i:-1}, {T:3,A:"input-conduit-type"}]
    ConduitTypeC := [{T:30}, {T:26, i:-1}, {T:3,A:"input-conduit-type"}, {T:8}, {T:7, N:"1 x 1.25`""}]
    DFiber := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"Fiber - Distribution | Underground"}]
    DFiberCapBoxC := [{T:30}, {T:26, i:-1},  {T:3, A:"input-fiber-capacity"}]
    DFiberCapC := [{T:30}, {T:26, i:-1},  {T:3, A:"input-fiber-capacity"}, {T:8}, {T:7, N:"24"}]
    DFiberPlaceBoxC := [{T:30}, {T:26, i:-1},  {T:3, A:"input-placement"}]
    DFiberPlaceC := [{T:30}, {T:26, i:-1},  {T:3, A:"input-placement"}, {T:8}, {T:7, N:"24ct Underground"}]
    DFiberSecBoxC := [{T:30}, {T:26, i:-1},  {T:3, A:"input-fiber-sections"}]
    DFiberSecC := [{T:30}, {T:26, i:-1},  {T:3, A:"input-fiber-sections"}, {T:8}, {T:7, N:"1 - Underground"}]
    DropFiber := [{T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7, N:"Fiber - Drop"}]
    DropCapC := [{T:30}, {T:26, i:-1},  {T:3, A:"input-fiber-capacity"}, {T:8}, {T:7, N:"1"}]
    DropPlaceC := [{T:30}, {T:26, i:-1},  {T:3, A:"input-placement"}, {T:8}, {T:7, N:"Underground"}]
    DropColorBoxC := [{T:30}, {T:26, i:-1},  {T:3, A:"input-color"}]
    DropColorC := [{T:30}, {T:26, i:-1},  {T:3, A:"input-color"}, {T:8}, {T:7, N:"1 - Blue"}]
    IDPathC := [{T:30}, {T:26, i:-1}, {T:4}]

    AutosavePathNetworkC := [{T:30}, {T:26, i:-1},  {T:2}]

; ----------------------------------------------------------------------
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
    }
}

    SwitchPrelimDropType() {
        if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
            chromeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                typeElement := chromeEl.ElementFromPath(PDropTypeBoxC*)
                currentValue := typeElement.Value
                chromeEl.WaitElementFromPath(PDropTypeBoxC*).Invoke()
                if (currentValue = "Underground") {
                    chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:3, A:"input-type"}, {T:8}, {T:7, N:"Aerial"}]*).Invoke()
                } else if (currentValue = "Aerial") {
                    chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:3, A:"input-type"}, {T:8}, {T:7, N:"Underground"}]*).Invoke()
                }
                chromeEl.WaitElementFromPath(IDPathC*).Invoke()
            } catch {
                ; Handle errors gracefully
            }
        } else {
            StoreSubmode()
        }
    }

Vaults() {
    Point()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
                chromeEl.WaitElementFromPath(VaultPathC*).Invoke()
                chromeEl.WaitElementFromPath(NamePathC*).Invoke()
                chromeEl.WaitElementFromPath(VaultTypeBoxC*).Invoke()
                chromeEl.WaitElementFromPath(VaultTypeC*).Invoke() 
                chromeEl.WaitElementFromPath(AutosavePathC*).Invoke()
        } catch {
            ; Ignore if the path isn’t found
        }
    }
}

    SwitchVault(){
        if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
            chromeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                VaultTypeElement := chromeEl.ElementFromPath(VaultTypeBoxC*)
                currentValue := VaultTypeElement.Value
                if (currentValue = "DV") {
                    chromeEl.WaitElementFromPath(VaultTypeBoxC*).Invoke()
                    chromeEl.WaitElementFromPath(VaultTypeB*).Invoke() 
                    chromeEl.WaitElementFromPath(NamePathC*).Invoke()
                }
                else if (currentValue = "LDV") {
                    chromeEl.WaitElementFromPath(VaultTypeBoxC*).Invoke()
                    chromeEl.WaitElementFromPath(VaultTypeC*).Invoke() 
                    chromeEl.WaitElementFromPath(NamePathC*).Invoke()
                }
            } catch {
                
            }
        } else {
            StoreSubmode()
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
    }
} 

Fiber() {
    Line()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.WaitElementFromPath(DFiber*).Invoke()
            chromeEl.WaitElementFromPath(IDPathC*).Invoke()
            chromeEl.WaitElementFromPath(DFiberCapBoxC*).Invoke()
            chromeEl.WaitElementFromPath(DFiberCapC*).Invoke()
            chromeEl.WaitElementFromPath(DFiberPlaceBoxC*).Invoke()
            chromeEl.WaitElementFromPath(DFiberPlaceC*).Invoke()
            chromeEl.WaitElementFromPath(DFiberSecBoxC*).Invoke()
            chromeEl.WaitElementFromPath(DFiberSecC*).Invoke()
            chromeEl.WaitElementFromPath(AutosavePathNetworkC*).Invoke()
            chromeEl.WaitElementFromPath(IDPathC*).Invoke()
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
            chromeEl.WaitElementFromPath(DropFiber*).Invoke()
            chromeEl.WaitElementFromPath(IDPathC*).Invoke() 
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
            OutputDebug("Attempting to find MessengerPathC")
        }
    }
}

    DropColorPath := [{T:30}, {T:26, i:-1},  {T:3,A:"input-color"}]
    bluepath := [{T:30}, {T:26, i:-1},  {T:3,A:"input-color"}, {T:8}, {T:7,N:"1 - Blue"}]
    orangepath := [{T:30}, {T:26, i:-1},  {T:3,A:"input-color"}, {T:8}, {T:7,N:"2 - Orange"}]
    greenpath := [{T:30}, {T:26, i:-1},  {T:3,A:"input-color"}, {T:8}, {T:7,N:"3 - Green"}]
    brownpath := [{T:30}, {T:26, i:-1},  {T:3,A:"input-color"}, {T:8}, {T:7,N:"4 - Brown"}]
    slatepath := [{T:30}, {T:26, i:-1},  {T:3,A:"input-color"}, {T:8}, {T:7,N:"5 - Slate"}]
    whitepath := [{T:30}, {T:26, i:-1},  {T:3,A:"input-color"}, {T:8}, {T:7,N:"6 - White"}]
    redpath := [{T:30}, {T:26, i:-1},  {T:3,A:"input-color"}, {T:8}, {T:7,N:"7 - Red"}]
    blackpath := [{T:30}, {T:26, i:-1},  {T:3,A:"input-color"}, {T:8}, {T:7,N:"8 - Black"}]
    yellowpath := [{T:30}, {T:26, i:-1},  {T:3,A:"input-color"}, {T:8}, {T:7,N:"9 - Yellow"}]
    violetpath := [{T:30}, {T:26, i:-1},  {T:3,A:"input-color"}, {T:8}, {T:7,N:"10 - Violet"}]
    rosepath := [{T:30}, {T:26, i:-1},  {T:3,A:"input-color"}, {T:8}, {T:7,N:"11 - Rose"}]
    aquapath := [{T:30}, {T:26, i:-1},  {T:3,A:"input-color"}, {T:8}, {T:7,N:"12 - Aqua"}]
    NotePathC := [{T:30}, {T:26, i:-1},  {T:4,A:"input-note"}]

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
        } else {
            StoreSubmode()
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
    TypePathC := [{T:30}, {T:26, i:-1},  {T:3,A:"input-type"}]
    TypeSelectC := [{T:30}, {T:26, i:-1},  {T:3,A:"input-type"}, {T:8}, {T:7,N:"UG NAP"}]
    LocationPathC := [{T:30}, {T:26, i:-1},  {T:3,A:"input-nap-location"}]
    LocationSelectC := [{T:30}, {T:26, i:-1},  {T:3,A:"input-nap-location"}, {T:8}, {T:7, N:"Underground"}]
    FiberCountPathC := [{T:30}, {T:26, i:-1},  {T:3,A:"input-fiber-count"}]
    FiberCountSelectC := [{T:30}, {T:26, i:-1},  {T:3,A:"input-fiber-count"}, {T:8}, {T:7, N:"48ct"}]

    Naps() {
        Point()
        if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
            chromeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                chromeEl.WaitElementFromPath(NapPathC*).Invoke()
                chromeEl.WaitElementFromPath(IDPathC*).Invoke() 
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
        }
    }

    NapTypePathC := [{T:30}, {T:26, i:-1},  {T:3,A:"input-type"}]
    NapTypePathUGSelectC := [{T:30}, {T:26, i:-1},  {T:3,A:"input-type"}, {T:8}, {T:7, n:"UG NAP"}]
    NapTypePathAESelectC := [{T:30}, {T:26, i:-1},  {T:3,A:"input-type"}, {T:8}, {T:7, n:"AE Regular"}]
    NapTypePathUGTieSelectC := [{T:30}, {T:26, i:-1},  {T:3,A:"input-type"}, {T:8}, {T:7, n:"UG Tie Point"}]
    NapTypePathAETieSelectC := [{T:30}, {T:26, i:-1},  {T:3,A:"input-type"}, {T:8}, {T:7, n:"AE Tie Point"}]

    NapLocationPathC := [{T:30}, {T:26, i:-1},  {T:3,A:"input-nap-location"}]
    NapLocationPathUGSelectC := [{T:30}, {T:26, i:-1},  {T:3,A:"input-nap-location"}, {T:8}, {T:7, N:"Underground"}]
    NapLocationPathAESelectC := [{T:30}, {T:26, i:-1},  {T:3,A:"input-nap-location"}, {T:8}, {T:7, N:"Aerial"}]

    NapFiberPathC := [{T:30}, {T:26, i:-1},  {T:3,A:"input-fiber-count"}]
    NapFiberPath24SelectC := [{T:30}, {T:26, i:-1},  {T:3,A:"input-fiber-count"}, {T:8}, {T:7, N:"24ct"}]
    NapFiberPath48SelectC := [{T:30}, {T:26, i:-1},  {T:3,A:"input-fiber-count"}, {T:8}, {T:7, N:"48ct"}]
    NapFiberPath72SelectC := [{T:30}, {T:26, i:-1},  {T:3,A:"input-fiber-count"}, {T:8}, {T:7, N:"72ct"}]

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
        } else {
            StoreSubmode()
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
        } else {
            StoreSubmode()
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
        } else {
            StoreSubmode()
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

    SlackLoopPlacement := [{T:30}, {T:26, i:-1}, {T:3,A:"input-placement"}]
    SlackLoopUnderground := [{T:30}, {T:26, i:-1}, {T:3,A:"input-placement"}, {T:8}, {T:7,N:"Underground"}]
    SlackLoopAerial := [{T:30}, {T:26, i:-1}, {T:3,A:"input-placement"}, {T:8}, {T:7,N:"Aerial"}]
    SlackLoopBackhaul := [{T:30}, {T:26, i:-1}, {T:3,A:"input-placement"}, {T:8}, {T:7,N:"Backhaul"}]

    SlackLoopSelect := [{T:30}, {T:26, i:-1},  {T:3,A:"input-slack-loop"}]
    SlackLoop30Loop := [{T:30}, {T:26, i:-1},  {T:3,A:"input-slack-loop"}, {T:8}, {T:7,N:"30' Loop"}]
    SlackLoop60Loop := [{T:30}, {T:26, i:-1},  {T:3,A:"input-slack-loop"}, {T:8}, {T:7,N:"60' Loop"}]
    SlackLoop30Tail := [{T:30}, {T:26, i:-1},  {T:3,A:"input-slack-loop"}, {T:8}, {T:7,N:"30' Tail"}]

; Add new paths for aerial loops
SlackLoop16Loop := [{T:30}, {T:26, i:-1}, {T:3,A:"input-slack-loop"}, {T:8}, {T:7,N:"16' Loop"}]
SlackLoop16Tail := [{T:30}, {T:26, i:-1}, {T:3,A:"input-slack-loop"}, {T:8}, {T:7,N:"16' Tail"}]
SlackLoop24Loop := [{T:30}, {T:26, i:-1}, {T:3,A:"input-slack-loop"}, {T:8}, {T:7,N:"24' Loop"}]
SlackLoop70Tail := [{T:30}, {T:26, i:-1}, {T:3,A:"input-slack-loop"}, {T:8}, {T:7,N:"70' Tail"}]

FiberSectionPath := [{T:30}, {T:26, i:-1}, {T:3, A:"input-fiber-sections"}]
FiberSectionUnderground := [{T:30}, {T:26, i:-1}, {T:3, A:"input-fiber-sections"}, {T:8}, {T:7, N:"1 - Underground"}]
FiberSectionAerial := [{T:30}, {T:26, i:-1}, {T:3, A:"input-fiber-sections"}, {T:8}, {T:7, N:"1 - Aerial"}]

; Helper to get current placement (Underground or Aerial)
GetSlackLoopPlacement() {
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        slackLoopElement := chromeEl.ElementFromPath(SlackLoopPlacement*)
        return slackLoopElement.Value
    }
    return ""
}

SlackLoops() {
    Point()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.WaitElementFromPath({T:30}, {T:26, i:-1}, {T:3}, {T:8}, {T:7,N:"Slack Loop"}).Invoke()
            chromeEl.WaitElementFromPath(SlackLoopPlacement*).Invoke()
            chromeEl.WaitElementFromPath(SlackLoopUnderground*).Invoke()
            chromeEl.WaitElementFromPath(SlackLoopSelect*).Invoke()
            chromeEl.WaitElementFromPath(SlackLoop30Loop*).Invoke()
            chromeEl.WaitElementFromPath(AutosavePathNetworkC*).Invoke()
            chromeEl.WaitElementFromPath(IDPathC*).Invoke()
            SlackLoopImputLength(30)
            ThirtyLoop()
            Sleep 100
            Send("{PgUp}")
        } catch {
            ; Ignore if the path isn’t found
        }
    }
}
    SetSlackLoopLength(expectedValue, pathToSelectLength) {
        if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
            chromeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                slackLoopElement := chromeEl.ElementFromPath(SlackLoopSelect*)
                currentValue := slackLoopElement.Value
                if (currentValue != expectedValue) {
                    slackLoopElement.Invoke()
                    chromeEl.WaitElementFromPath(pathToSelectLength*).Invoke()
                }
                chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                ; --- Automatically update input length to match the selected loop ---
                ; Extract the numeric value from expectedValue (e.g., "30' Loop" -> 30)
                loopLength := RegExReplace(expectedValue, "[^\d]")
                if loopLength != ""
                    SlackLoopImputLength(loopLength)
            } catch {
                ; Handle errors gracefully
            }
        } else {
            StoreSubmode()
        }
    }
    SlackLoopLocation(){
        if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
            chromeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                slackLoopElement := chromeEl.ElementFromPath(SlackLoopPlacement*)
                currentValue := slackLoopElement.Value
                if (currentValue = "Underground") {
                    chromeEl.WaitElementFromPath(SlackLoopPlacement*).Invoke()
                    chromeEl.WaitElementFromPath(SlackLoopAerial*).Invoke()
                } else if (currentValue = "Aerial") {
                    chromeEl.WaitElementFromPath(SlackLoopPlacement*).Invoke()
                    chromeEl.WaitElementFromPath(SlackLoopUnderground*).Invoke()
                }
                chromeEl.WaitElementFromPath(IDPathC*).Invoke()
            } catch {
                ; Handle errors gracefully
            }
        } else {
            StoreSubmode()
        }
    }
    ThirtyLoop() {
        if GetSlackLoopPlacement() = "Aerial" {
            SetSlackLoopLength("16' Loop", SlackLoop16Loop)
        } else {
            SetSlackLoopLength("30' Loop", SlackLoop30Loop)
        }
    }
    SixtyLoop() {
        if GetSlackLoopPlacement() = "Aerial" {
            SetSlackLoopLength("24' Loop", SlackLoop24Loop)
        } else {
            SetSlackLoopLength("60' Loop", SlackLoop60Loop)
        }
    }
    ThirtyTail() {
        if GetSlackLoopPlacement() = "Aerial" {
            SetSlackLoopLength("16' Tail", SlackLoop16Tail)
        } else {
            SetSlackLoopLength("30' Tail", SlackLoop30Tail)
        }
    }
    Set70Tail(){
        if GetSlackLoopPlacement() = "Aerial" {
            SlackLoopLocation()
        }
        SetSlackLoopLength("70' Tail", SlackLoop70Tail)
    }

    SlackLoopImput(){
        if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
            chromeEl := UIA.ElementFromHandle(WinExist("A"))
            slackLoopElement := chromeEl.ElementFromPath(SlackLoopPlacement*)
            try {
                currentValue := slackLoopElement.Value
                if (currentValue = "Underground") {
                    chromeEl.WaitElementFromPath(SlackLoopPlacement*).Invoke()
                    chromeEl.WaitElementFromPath(SlackLoopAerial*).Invoke()
                } else if (currentValue = "Aerial") {
                    chromeEl.WaitElementFromPath(SlackLoopPlacement*).Invoke()
                    chromeEl.WaitElementFromPath(SlackLoopUnderground*).Invoke()
                }
                chromeEl.WaitElementFromPath(IDPathC*).Invoke()
            } catch {
                ; Handle errors gracefully
            }
        } else {
            StoreSubmode()
        }
    }

    SlackLoopImputLength(value){
        if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
            chromeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                chromeEl.WaitElementFromPath({T:30}, {T:26, i:-1},  {T:4}).Invoke() 
                sleep 100
                Send "^a{Del}"
                sleep 50
                Send value
                chromeEl.WaitElementFromPath(IDPathC*).Invoke()
            } catch as e {
                OutputDebug("Error in SlackLoopImputLength: " e.Message)
            }
        } else {
            StoreSubmode()
        }
    }

    SetFiberSection(sectionNum) {
        if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
            chromeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                sectionElement := chromeEl.ElementFromPath(FiberSectionPath*)
                currentPlacement := GetSlackLoopPlacement()
                sectionLabel := sectionNum " - " (currentPlacement = "Aerial" ? "Aerial" : "Underground")
                sectionPath := [{T:30}, {T:26, i:-1}, {T:3, A:"input-fiber-sections"}, {T:8}, {T:7, N:sectionLabel}]
                sectionElement.Invoke()
                chromeEl.WaitElementFromPath(sectionPath*).Invoke()
                chromeEl.WaitElementFromPath(IDPathC*).Invoke()
            } catch {
                ; Handle errors gracefully
            }
        } else {
            StoreSubmode()
        }
    }
; #endregion
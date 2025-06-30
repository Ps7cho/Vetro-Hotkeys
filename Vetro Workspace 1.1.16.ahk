#Requires AutoHotkey v2.0
#include UIA.ahk


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
!Esc:: Reload
#HotIf 

debugmode := true

; #region Paths

; Define base path variables for reuse
baseT := 30
baseT2 := 26
baseT3 := 30 ; Added missing assignment for baseT3
baseI21 := 21
baseI25 := 25
baseT0 := 0
baseI := -1
baseI2 := 2
baseI3 := 3
baseI4 := 4
baseI5 := 5
baseI6 := 6
baseI7 := 7
baseI8 := 8
baseI9 := 9


; Common strings
strSave := "Save"
strDelete := "Delete"
strFeatureDeletionModal := "feature-deletion-modal"
strFeatureDeletionModalContent := "feature-deletion-modal___BV_modal_content_"
strEdit := "Edit"
strPoint := " Point"
strLine := " Line"
strPolygon := " Polygon"
strMessengerWire := "Messenger Wire"
strUsing := "Using"
strUnits := "Units"
strName := "name"
strLength := "Length"
strInputTotalLength := "input-total-length"
strPueRow := "PUE & ROW"
strPlatMapLinks := "PLAT Map Links"
strRowCenterline := "ROW Centerline"
strServiceLocation := "Service Location"
strID := "ID"
strPreliminaryDrops := "Preliminary Drops"
strUnderground := "Underground"
strAerial := "Aerial"
strDV := "DV"
strLDV := "LDV"
strConduit := "Conduit"
strInputConduitType := "input-conduit-type"
strConduitType1 := "1 x 1.25`""
strConduitType2 := "2 x 1.25`""
strConduitType2Road := "2 x 1.25`" Road Shot"
strFiberDistUG := "Fiber - Distribution | Underground"
strFiberDistAerial := "Fiber - Distribution | Aerial"
strInputFiberCapacity := "input-fiber-capacity"
strInputPlacement := "input-placement"
strInputFiberSections := "input-fiber-sections"
strInputColor := "input-color"
strInputNote := "input-note"
strFiberDrop := "Fiber - Drop"
strFiberBackhaulUG := "Fiber - Backhaul | Underground"
strFiberBackhaulAerial := "Fiber - Backhaul | Aerial"
strNAP := "NAP"
strInputType := "input-type"
strInputNapLocation := "input-nap-location"
strInputFiberCount := "input-fiber-count"
strUGNAP := "UG NAP"
strAERegular := "AE Regular"
strUGTiePoint := "UG Tie Point"
strAETiePoint := "AE Tie Point"
strSlackLoop := "Slack Loop"
strInputSlackLoop := "input-slack-loop"
strBackhaul := "Backhaul"

; Color strings
strBlue := "1 - Blue"
strOrange := "2 - Orange"
strGreen := "3 - Green"
strBrown := "4 - Brown"
strSlate := "5 - Slate"
strWhite := "6 - White"
strRed := "7 - Red"
strBlack := "8 - Black"
strYellow := "9 - Yellow"
strViolet := "10 - Violet"
strRose := "11 - Rose"
strAqua := "12 - Aqua"

; Fiber counts
str24 := "24"
str48 := "48"
str72 := "72"
str24ct := "24ct"
str48ct := "48ct"
str72ct := "72ct"

; Slack loop lengths
str30Loop := "30' Loop"
str60Loop := "60' Loop"
str30Tail := "30' Tail"
str16Loop := "16' Loop"
str16Tail := "16' Tail"
str24Loop := "24' Loop"
str70Tail := "70' Tail"
str100Tail := "100' Tail"

; Section labels
strSection1UG := "1 - Underground"
strSection1Aerial := "1 - Aerial"
strSection1 := "1"

MainPath                := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseT0}]

; Path variables
savePathC               := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseT0}]
deletePathC             := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseT0}]
featureDeletionPathC    := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseI25, A:"feature-deletion-modal"}, {T:baseT2,A:"feature-deletion-modal___BV_modal_content_"}, {T:baseT0, i:baseI}]
ClosePanelPathC         := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT0}]

PencilPathC             := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseI21, i:baseI6}, {T:baseT0, i:baseI2}, {T:baseI6}]
PointPathC              := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseI21}, {T:0, A:"point-button"}]
LinePathC               := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseI21}, {T:0,A:"linestring-button"}]
PolygonPathC            := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseI21}, {T:0, A:"polygon-button"}]

MapDataPathC            := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI21, i:baseI2}, {T:baseT0}, {T:6}]
NetworkCheckPathC       := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI8}, {T:baseI7, i:baseI2}, {T:2}]

; Discovery Paths
FeaturePanelPathC       := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3}]
IDPathC                 := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI4}]
NamePathC               := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI4}]
;LayerPathC              := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseI3}]
AutosavePathC           := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI2}]

UsingPathC              := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:"input-using"}]
UsingSelectPathC        := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:"input-using"}, {T:baseI8}, {T:baseI7, N:strUsing}]


PUEROWPathC             := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3}, {T:baseI8}, {T:baseI7, N:strPueRow}]
PLATMapLinksPathC       := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3}, {T:baseI8}, {T:baseI7, N:strPlatMapLinks}]
ROWCenterlinePathC      := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3}, {T:baseI8}, {T:baseI7, N:strRowCenterline}]
ServiceLocation         := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3}, {T:baseI8}, {T:baseI7, N:strServiceLocation}]
UnitsPathC              := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3}, {T:baseI8}, {T:baseI7, N:strUnits}]
PreliminaryDropsC       := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3}, {T:baseI8}, {T:baseI7, N:strPreliminaryDrops}]
MessengerPathC          := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3}, {T:baseI8}, {T:baseI7, N:strMessengerWire}]
LengthPathC             := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3}, {T:baseI8}, {T:baseI7, N:strLength}]
DFiber                  := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3}, {T:baseI8}, {T:baseI7, N:strFiberDistUG}]
AFiber                  := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3}, {T:baseI8}, {T:baseI7, N:strFiberDistAerial}]
ConduitPathC            := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3}, {T:baseI8}, {T:baseI7, N:strConduit}]
VaultPathC              := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3}, {T:baseI8}, {T:baseI7, N:"Vaults"}]
NapPathC                := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3}, {T:baseI8}, {T:baseI7, N:strNAP}]
SlackLoopPath           := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3}, {T:baseI8}, {T:baseI7, N:"Slack Loop"}]
BackhaulUFiber          := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3}, {T:baseI8}, {T:baseI7, N:strFiberBackhaulUG}]
BackhaulAFiber          := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3}, {T:baseI8}, {T:baseI7, N:strFiberBackhaulAerial}]

LengthInputPathC        := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI4, A:strInputTotalLength}]
NotePathC               := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI4, A:strInputNote}]
SlackLoopLength         := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI4}]

PDropTypeBoxC           := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputType}]
PDropTypeC              := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputType}, {T:baseI8}, {T:baseI7, N:strUnderground}]


VaultTypeBoxC           := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:"input-size"}]
VaultTypeC              := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:"input-size"}, {T:baseI8}, {T:baseI7, N:strDV}]
VaultTypeB              := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:"input-size"}, {T:baseI8}, {T:baseI7, N:strLDV}]


ConduitTypeBoxC         := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputConduitType}]
ConduitTypeC            := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputConduitType}, {T:baseI8}, {T:baseI7, N:strConduitType1}]

DFiberCapBoxC           := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputFiberCapacity}]
DFiberCapC              := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputFiberCapacity}, {T:baseI8}, {T:baseI7, N:str24}]
DFiberPlaceBoxC         := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputPlacement}]
DFiberPlaceC            := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputPlacement}, {T:baseI8}, {T:baseI7, N:str24 "ct " strUnderground}]
DFiberSecBoxC           := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputFiberSections}]
DFiberSecC              := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputFiberSections}, {T:baseI8}, {T:baseI7, N:strSection1UG}]
AFiberSecC              := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputFiberSections}, {T:baseI8}, {T:baseI7, N:strSection1}]

DropFiber               := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3}, {T:baseI8}, {T:baseI7, N:strFiberDrop}]
DropCapC                := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputFiberCapacity}, {T:baseI8}, {T:baseI7, N:str72}]
DropPlaceC              := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputPlacement}, {T:baseI8}, {T:baseI7, N:strUnderground}]
DropColorBoxC           := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputColor}]
DropColorC              := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputColor}, {T:baseI8}, {T:baseI7, N:strBlue}]


; NAP Paths
TypePathC               := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputType}]
TypeSelectC             := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputType}, {T:baseI8}, {T:baseI7, N:strUGNAP}]
LocationPathC           := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputNapLocation}]
LocationSelectC         := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputNapLocation}, {T:baseI8}, {T:baseI7, N:strUnderground}]
FiberCountPathC         := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputFiberCount}]
FiberCountSelectC       := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputFiberCount}, {T:baseI8}, {T:baseI7, N:str48ct}]

NapTypePathC            := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputType}]
NapTypePathUGSelectC    := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputType}, {T:baseI8}, {T:baseI7, N:strUGNAP}]
NapTypePathAESelectC    := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputType}, {T:baseI8}, {T:baseI7, N:strAERegular}]
NapTypePathUGTieSelectC := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputType}, {T:baseI8}, {T:baseI7, N:strUGTiePoint}]
NapTypePathAETieSelectC := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputType}, {T:baseI8}, {T:baseI7, N:strAETiePoint}]

NapLocationPathC        := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputNapLocation}]
NapLocationPathUGSelectC := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputNapLocation}, {T:baseI8}, {T:baseI7, N:strUnderground}]
NapLocationPathAESelectC := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputNapLocation}, {T:baseI8}, {T:baseI7, N:strAerial}]

NapFiberPathC           := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputFiberCount}]
NapFiberPath24SelectC   := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputFiberCount}, {T:baseI8}, {T:baseI7, N:str24ct}]
NapFiberPath48SelectC   := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputFiberCount}, {T:baseI8}, {T:baseI7, N:str48ct}]
NapFiberPath72SelectC   := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputFiberCount}, {T:baseI8}, {T:baseI7, N:str72ct}]

; Slack Loop Paths
SlackLoopPlacement      := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputPlacement}]
SlackLoopUnderground    := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputPlacement}, {T:baseI8}, {T:baseI7, N:strUnderground}]
SlackLoopAerial         := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputPlacement}, {T:baseI8}, {T:baseI7, N:strAerial}]
SlackLoopBackhaul       := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputPlacement}, {T:baseI8}, {T:baseI7, N:strBackhaul}]

SlackLoopSelect         := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputSlackLoop}]
SlackLoop30Loop         := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputSlackLoop}, {T:baseI8}, {T:baseI7, N:str30Loop}]
SlackLoop60Loop         := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputSlackLoop}, {T:baseI8}, {T:baseI7, N:str60Loop}]
SlackLoop30Tail         := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputSlackLoop}, {T:baseI8}, {T:baseI7, N:str30Tail}]
SlackLoop16Loop         := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputSlackLoop}, {T:baseI8}, {T:baseI7, N:str16Loop}]
SlackLoop16Tail         := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputSlackLoop}, {T:baseI8}, {T:baseI7, N:str16Tail}]
SlackLoop24Loop         := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputSlackLoop}, {T:baseI8}, {T:baseI7, N:str24Loop}]
SlackLoop70Tail         := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputSlackLoop}, {T:baseI8}, {T:baseI7, N:str70Tail}]

FiberSectionPath        := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputFiberSections}]
FiberSectionUnderground := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputFiberSections}, {T:baseI8}, {T:baseI7, N:strSection1UG}]
FiberSectionAerial      := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputFiberSections}, {T:baseI8}, {T:baseI7, N:strSection1Aerial}]

; Drop color paths
DropColorPath           := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputColor}]
bluepath                := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputColor}, {T:baseI8}, {T:baseI7, N:strBlue}]
orangepath              := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputColor}, {T:baseI8}, {T:baseI7, N:strOrange}]
greenpath               := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputColor}, {T:baseI8}, {T:baseI7, N:strGreen}]
brownpath               := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputColor}, {T:baseI8}, {T:baseI7, N:strBrown}]
slatepath               := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputColor}, {T:baseI8}, {T:baseI7, N:strSlate}]
whitepath               := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputColor}, {T:baseI8}, {T:baseI7, N:strWhite}]
redpath                 := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputColor}, {T:baseI8}, {T:baseI7, N:strRed}]
blackpath               := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputColor}, {T:baseI8}, {T:baseI7, N:strBlack}]
yellowpath              := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputColor}, {T:baseI8}, {T:baseI7, N:strYellow}]
violetpath              := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputColor}, {T:baseI8}, {T:baseI7, N:strViolet}]
rosepath                := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputColor}, {T:baseI8}, {T:baseI7, N:strRose}]
aquapath                := [{T:baseT}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:strInputColor}, {T:baseI8}, {T:baseI7, N:strAqua}]


; #endregion----------------------------------------------------------------------
; #region Basic Functions
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
            ToolTip("Breakpoint reached in ClosePanel function. Path not found.")
        }
    } 

    ; Check if SubMode is not empty
    if (SubMode != "") {
        ; Deactivate the current SubMode
        SubMode := "" ; Reset SubMode
    }
}



; #endregion----------------------------------------------------------------------
; #region Global Functions and paths


ShowHelp() {
    global Mode, SubMode
    helpText := "VETRO Hotkeys`n-------------------`n"
    helpText .= "Reset: ALT+ESC`n"
    if (Mode = "Discovery") {
        helpText .= "Messenger: ALT+M`nUnits: ALT+U`nPlat: ALT+P`nLength: ALT+L`nPUE: ALT+,`nROW: ALT+.`nCenterline: ALT+K`nService Locations: ALT+;"
    } else if (Mode = "Planning") {
        helpText .= "PDrops: ALT+Z`nAerial Fiber: ALT+A`nVaults: ALT+V`nConduit: ALT+C`nFiber: ALT+F`nDrops: ALT+D`nNaps: ALT+N`nSlack Loops: ALT+W`nBackhaul U: ALT+B`nBackhaul A: ALT+H"
        if (SubMode = "Preliminary Drops") {
            helpText .= "`n--- Preliminary Drops Submode ---`nA - Switch Type (Underground/Aerial)`nReset: ALT+ESC"
        } else if (SubMode = "Aerial Fiber") {
            helpText .= "`n--- Aerial Fiber Submode ---`nA - Toggle Placement`nQ - (not used)`nW - 24CT`nE - 48CT`nR - 72CT`n1-4 - Section`nReset: ALT+ESC"
        } else if (SubMode = "Vaults") {
            helpText .= "`n--- Vaults Submode ---`nV - Switch Vault`nReset: ALT+ESC"
        } else if (SubMode = "Conduit") {
            helpText .= "`n--- Conduit Submode ---`nA - (not used)`nQ - (not used)`nW - 1x25`nE - 2x25`nR - 2x25 Road`nReset: ALT+ESC"
        } else if (SubMode = "Fiber") {
            helpText .= "`n--- Fiber Submode ---`nA - Toggle Placement`nQ - (not used)`nW - 24CT`nE - 48CT`nR - 72CT`n1-4 - Section`nReset: ALT+ESC"
        } else if (SubMode = "Drops") {
            helpText .= "`n--- Drops Submode ---`n1 - Blue`n2 - Orange`n3 - Green`n4 - Brown`n5 - Slate`n6 - White`n7 - Red`n8 - Black`n9 - Yellow`n0 - Violet`n- - Rose`n= - Aqua`nReset: ALT+ESC"
        } else if (SubMode = "Naps") {
            helpText .= "`n--- Naps Submode ---`nA - Location`nQ - (not used)`nW - 24CT`nE - 48CT`nR - 72CT`n1-4 - (not used)`nSPACE - Type`nReset: ALT+ESC"
        } else if (SubMode = "Slack Loops") {
            helpText .= "`n--- Slack Loops Submode ---`nA - Placement`nQ - 70 Tail`nW - Loop`nE - Tail`nR - 60/24`n1-4 - Fiber Section`nReset: ALT+ESC"
        } else if (SubMode = "Backhaul Fiber U") {
            helpText .= "`n--- Backhaul Fiber U Submode ---`nA - Toggle Placement`nQ - (not used)`nW - 24CT`nE - 48CT`nR - 72CT`nReset: ALT+ESC"
        }
    } else {
        helpText .= "No mode active.`nALT+F1: Discovery Mode`nALT+F2: Planning Mode`nReset: ALT+ESC"
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
            chromeEl.WaitElementFromPath(FeaturePanelPathC*).Invoke()
        } catch {
            if debugmode {
                ToolTip("Breakpoint reached in Point function. Path not found.")
            }
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
            chromeEl.WaitElementFromPath(FeaturePanelPathC*).Invoke()
        } catch {
            if debugmode {
                ToolTip("Breakpoint reached in Line function. Path not found.")
            }
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
            chromeEl.WaitElementFromPath(FeaturePanelPathC*).Invoke()
        } catch {
            if debugmode {
                ToolTip("Breakpoint reached in Polygon function. Path not found.")
            }
        }
    }
}

MapDataBox() {
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
    
        chromeEl.WaitElementFromPath(MapDataPathC*).Invoke()
    }
}
    
; #endregion----------------------------------------------------------------------
; #region Mode-Based Hotkeys
;----------------------------------------------------------------------

global Mode := "", SubMode := "", storedMode := "", storedSubMode := "", lastHotkey := ""

!F1:: {
    SetMode("Discovery")
}

!F2:: {
    SetMode("Planning")
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



HandleHotkey(hotkey, actionFunc) {
    global lastHotkey
    lastHotkey := hotkey
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        %actionFunc%()
    } else {
        SendInput("{" hotkey "}")
    }
}


#HotIf (Mode = "Discovery")
!m:: HandleHotkey("m", "Messenger")
!u:: HandleHotkey("u", "Units")
!p:: HandleHotkey("p", "Plat")
!l:: HandleHotkey("l", "Length")
!,:: HandleHotkey(",", "PUE")
!.:: HandleHotkey(".", "ROW")
!k:: HandleHotkey("k", "Centerline")
!;:: HandleHotkey(";", "ServiceLocations")

#HotIf (SubMode = "Preliminary Drops")
a:: HandleHotkey("a", "SwitchPrelimDropType")

#HotIf (Mode = "Planning")
!z:: {
    PDrops()
    SetSubMode("Preliminary Drops")
}
!a:: {
    AerialFiber()
    SetSubMode("Aerial Fiber")
}
!v:: {
    Vaults()
    SetSubMode("Vaults")
}
!c::{
    Conduit()
    SetSubMode("Conduit")
}
!f:: {
    Fiber()
    SetSubMode("Fiber")
}
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
!b:: {
    BackhaulU()
    SetSubMode("Backhaul Fiber U")
}
!h:: {
    BackhaulA()
    SetSubMode("Backhaul Fiber U")
}

    #HotIf (SubMode = "Drops")
    1::HandleHotkey("1", "Blue")
    2::HandleHotkey("2", "Orange")
    3::HandleHotkey("3", "Green")
    4::HandleHotkey("4", "Brown")
    5::HandleHotkey("5", "Slate")
    6::HandleHotkey("6", "White")
    7::HandleHotkey("7", "Red")
    8::HandleHotkey("8", "Black")
    9::HandleHotkey("9", "Yellow")
    0::HandleHotkey("0", "Violet")
    -::HandleHotkey("-", "Rose")
    =::HandleHotkey("=", "Aqua")

    #HotIf (SubMode = "Naps")
    Space::HandleHotkey("Space", "SetNapType")
    a::HandleHotkey("a", "SetNapLocation")
    w::HandleHotkey("w", "TwentyFour")
    e::HandleHotkey("e", "FourtyEight")
    r::HandleHotkey("r", "SeventyTwo")

#HotIf (SubMode = "Vaults")
v::HandleHotkey("v", "SwitchVault")

#HotIf (SubMode = "Slack Loops")
a:: HandleHotkey("a", "SlackLoopLocation")
w:: HandleHotkey("w", "ThirtyLoop")
e:: HandleHotkey("e", "ThirtyTail")
r:: HandleHotkey("r", "SixtyLoop")
q:: HandleHotkey("q", "Set70Tail")

1:: HandleHotkey("1", "SetLoopSection1")
2:: HandleHotkey("2", "SetLoopSection2")
3:: HandleHotkey("3", "SetLoopSection3")
4:: HandleHotkey("4", "SetLoopSection4")

SetLoopSection1() {
    SetLoopSection(1)
}
SetLoopSection2() {
    SetLoopSection(2)
}
SetLoopSection3() {
    SetLoopSection(3)
}
SetLoopSection4() {
    SetLoopSection(4)
}

#HotIf (SubMode = "Fiber")
a:: HandleHotkey("a", "ToggleFiberPlacement")
w:: HandleHotkey("w", "SetFiberCapacity24")
e:: HandleHotkey("e", "SetFiberCapacity48")
r:: HandleHotkey("r", "SetFiberCapacity72")
1:: HandleHotkey("1", "SetFiberSection1")
2:: HandleHotkey("2", "SetFiberSection2")
3:: HandleHotkey("3", "SetFiberSection3")
4:: HandleHotkey("4", "SetFiberSection4")

SetFiberCapacity24() {
    SetFiberCapacity("24")
}
SetFiberCapacity48() {
    SetFiberCapacity("48")
}
SetFiberCapacity72() {
    SetFiberCapacity("72")
}
SetFiberSection1() {
    SetFiberSection(1)
}
SetFiberSection2() {
    SetFiberSection(2)
}
SetFiberSection3() {
    SetFiberSection(3)
}
SetFiberSection4() {
    SetFiberSection(4)
}

#HotIf (SubMode = "Aerial Fiber")
a:: HandleHotkey("a", "ToggleAerialFiberPlacement")
w:: HandleHotkey("w", "SetAerialFiberCapacity24")
e:: HandleHotkey("e", "SetAerialFiberCapacity48")
r:: HandleHotkey("r", "SetAerialFiberCapacity72")
1:: HandleHotkey("1", "SetAerialFiberSection1")
2:: HandleHotkey("2", "SetAerialFiberSection2")
3:: HandleHotkey("3", "SetAerialFiberSection3")
4:: HandleHotkey("4", "SetAerialFiberSection4")

SetAerialFiberCapacity24() {
    SetAerialFiberCapacity("24")
}
SetAerialFiberCapacity48() {
    SetAerialFiberCapacity("48")
}
SetAerialFiberCapacity72() {
    SetAerialFiberCapacity("72")
}
SetAerialFiberSection1() {
    SetAerialFiberSection(1)
}
SetAerialFiberSection2() {
    SetAerialFiberSection(2)
}
SetAerialFiberSection3() {
    SetAerialFiberSection(3)
}
SetAerialFiberSection4() {
    SetAerialFiberSection(4)
}

#HotIf (SubMode = "Conduit")
w:: HandleHotkey("w", "Conduit1x25")
e:: HandleHotkey("e", "Conduit2x25")
r:: HandleHotkey("r", "Conduit2x25Road")

#HotIf (SubMode = "Backhaul Fiber U")
a:: HandleHotkey("a", "ToggleBackhaulPlacement")
w:: HandleHotkey("w", "SetBackhaulCapacity24")
e:: HandleHotkey("e", "SetBackhaulCapacity48")
r:: HandleHotkey("r", "SetBackhaulCapacity72")

SetBackhaulCapacity24() {
    HandleHotkey("w", "SetBackhaulCapacity24_Internal")
}
SetBackhaulCapacity24_Internal() {
    SetBackhaulCapacity("24")
}
SetBackhaulCapacity48() {
    HandleHotkey("e", "SetBackhaulCapacity48_Internal")
}
SetBackhaulCapacity48_Internal() {
    SetBackhaulCapacity("48")
}
SetBackhaulCapacity72() {
    HandleHotkey("r", "SetBackhaulCapacity72_Internal")
}
SetBackhaulCapacity72_Internal() {
    SetBackhaulCapacity("72")
}
#HotIf

; #endregion----------------------------------------------------------------------
; #region Discovery Functions

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
            chromeEl.WaitElementFromPath(AutosavePathC*).Invoke()
            chromeEl.WaitElementFromPath(IDPathC*).Invoke()
        
            ; Ignore if the path isn’t found
        
    }
}



; #endregion ----------------------------------------------------------------------
; #region Planning
    ; #region Preliminary Drops
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
            }
        }
    ;#endregion Preliminary Drops
    ; #region Vaults
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
            }
        }
    ; #endregion Vaults
    ; #region Conduit
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

        Conduit1x25() {
            if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
                chromeEl := UIA.ElementFromHandle(WinExist("A"))
                try {
                    conduitTypeElement := chromeEl.ElementFromPath(ConduitTypeBoxC*)
                    currentValue := conduitTypeElement.Value
                    if (currentValue != '1 x 1.25"') {
                        chromeEl.WaitElementFromPath(ConduitTypeBoxC*).Invoke()
                        chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:3, A:"input-conduit-type"}, {T:8}, {T:7, N:"1 x 1.25`""}]*).Invoke()
                    }
                    chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                } catch {
                    ; Handle errors gracefully
                }
            }
        }

        Conduit2x25() {
            if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
                chromeEl := UIA.ElementFromHandle(WinExist("A"))
                try {
                    conduitTypeElement := chromeEl.ElementFromPath(ConduitTypeBoxC*)
                    currentValue := conduitTypeElement.Value
                    if (currentValue != '2 x 1.25"') {
                        chromeEl.WaitElementFromPath(ConduitTypeBoxC*).Invoke()
                        chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:3, A:"input-conduit-type"}, {T:8}, {T:7, N:"2 x 1.25`""}]*).Invoke()
                    }
                    chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                } catch {
                    ; Handle errors gracefully
                }
            }
        }

        Conduit2x25Road() {
            if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
                chromeEl := UIA.ElementFromHandle(WinExist("A"))
                try {
                    conduitTypeElement := chromeEl.ElementFromPath(ConduitTypeBoxC*)
                    currentValue := conduitTypeElement.Value
                    if (currentValue != '2 x 1.25" Road Shot') {
                        chromeEl.WaitElementFromPath(ConduitTypeBoxC*).Invoke()
                        chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:3, A:"input-conduit-type"}, {T:8}, {T:7, N:'2 x 1.25" Road Shot'}]*).Invoke()
                    }
                    chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                } catch {
                    ; Handle errors gracefully
                }
            }
        }
    ; #endregion Conduit
    ; #region Fiber

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
                chromeEl.WaitElementFromPath(AutosavePathC*).Invoke()
                chromeEl.WaitElementFromPath(IDPathC*).Invoke()
            } catch {
                if debugmode {
                    ToolTip("Breakpoint reached in Fiber function. Path not found.")
                }
            }
        }
    }
        ToggleFiberPlacement() {
            if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
                chromeEl := UIA.ElementFromHandle(WinExist("A"))
                try {
                    ; Get current placement value
                    fiberPlaceElement := chromeEl.ElementFromPath(DFiberPlaceBoxC*)
                    currentValue := fiberPlaceElement.Value
                    ; Parse current capacity and placement
                    match := RegExMatch(currentValue, "(\d+)ct (Underground|Aerial)", &m)
                    if match {
                        cap := m[1]
                        place := m[2]
                        newPlace := (place = "Underground") ? "Aerial" : "Underground"
                        newValue := cap "ct " newPlace
                        chromeEl.WaitElementFromPath(DFiberPlaceBoxC*).Invoke()
                        chromeEl.WaitElementFromPath([{T:baseT3}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:"input-placement"}, {T:8}, {T:7, N:newValue}]*).Invoke()
                        ; Get current section number
                        fiberSecElement := chromeEl.ElementFromPath(DFiberSecBoxC*)
                        sectionValue := fiberSecElement.Value
                        sectionMatch := RegExMatch(sectionValue, "(\d+)", &sm)
                        if sectionMatch {
                            sectionNum := sm[1]
                            sectionLabel := sectionNum " - " newPlace
                            chromeEl.WaitElementFromPath(DFiberSecBoxC*).Invoke()
                            chromeEl.WaitElementFromPath([{T:baseT3}, {T:baseT2, i:baseI}, {T:baseT2}, {T:baseI3, A:"input-fiber-sections"}, {T:8}, {T:7, N:sectionLabel}]*).Invoke()
                        }
                    }
                    chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                } catch as e {
                    OutputDebug("Error in ToggleFiberPlacement: " e.Message)
                }
            }
        }

        SetFiberCapacity(capacity) {
            if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
                chromeEl := UIA.ElementFromHandle(WinExist("A"))
                try {
                    fiberPlaceElement := chromeEl.ElementFromPath(DFiberPlaceBoxC*)
                    currentValue := fiberPlaceElement.Value
                    match := RegExMatch(currentValue, "(\d+)ct (Underground|Aerial)", &m)
                    if match {
                        place := m[2]
                        newValue := capacity "ct " place
                        if (currentValue != newValue) {
                            chromeEl.WaitElementFromPath(DFiberPlaceBoxC*).Invoke()
                            chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:baseT2}, {T:3, A:"input-placement"}, {T:8}, {T:7, N:newValue}]*).Invoke()
                        }
                        fiberCapElement := chromeEl.ElementFromPath(DFiberCapBoxC*)
                        currentCap := fiberCapElement.Value
                        if (currentCap != capacity) {
                            fiberCapElement.Invoke()
                            chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:baseT2}, {T:3, A:"input-fiber-capacity"}, {T:8}, {T:7, N:capacity}]*).Invoke()
                        }
                    } else {
                        ; If not matched, try toggling placement and retry
                        ToggleFiberPlacement()
                        Sleep 100
                        fiberPlaceElement := chromeEl.ElementFromPath(DFiberPlaceBoxC*)
                        currentValue := fiberPlaceElement.Value
                        match := RegExMatch(currentValue, "(\d+)ct (Underground|Aerial)", &m)
                        if match {
                            place := m[2]
                            newValue := capacity "ct " place
                            if (currentValue != newValue) {
                                chromeEl.WaitElementFromPath(DFiberPlaceBoxC*).Invoke()
                                chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:baseT2}, {T:3, A:"input-placement"}, {T:8}, {T:7, N:newValue}]*).Invoke()
                            }
                            fiberCapElement := chromeEl.ElementFromPath(DFiberCapBoxC*)
                            currentCap := fiberCapElement.Value
                            if (currentCap != capacity) {
                                fiberCapElement.Invoke()
                                chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:baseT2}, {T:3, A:"input-fiber-capacity"}, {T:8}, {T:7, N:capacity}]*).Invoke()
                            }
                        }
                    }
                    chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                } catch as e {
                    OutputDebug("Error in SetFiberCapacity: " e.Message)
                }
            }
        }

        SetFiberSection(sectionNum) {
            if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
                chromeEl := UIA.ElementFromHandle(WinExist("A"))
                try {
                    ; Get current placement value
                    fiberPlaceElement := chromeEl.ElementFromPath(DFiberPlaceBoxC*)
                    currentValue := fiberPlaceElement.Value
                    match := RegExMatch(currentValue, "(\d+)ct (Underground|Aerial)", &m)
                    if match {
                        place := m[2]
                        sectionLabel := sectionNum " - " place
                        sectionElement := chromeEl.ElementFromPath(DFiberSecBoxC*)
                        sectionElement.Invoke()
                        chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:baseT2}, {T:3, A:"input-fiber-sections"}, {T:8}, {T:7, N:sectionLabel}]*).Invoke()
                        chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                    }
                    chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                } catch as e {
                    OutputDebug("Error in SetFiberSection: " e.Message)
                }
            }
        }
    ; #endregion Fiber
    ; #region Aerial Fiber


    AerialFiber() {
        Line()
        if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
            chromeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                chromeEl.WaitElementFromPath(AFiber*).Invoke()
                chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                chromeEl.WaitElementFromPath(DFiberCapBoxC*).Invoke()
                chromeEl.WaitElementFromPath(DFiberCapC*).Invoke()
                chromeEl.WaitElementFromPath(DFiberPlaceBoxC*).Invoke()
                chromeEl.WaitElementFromPath(DFiberPlaceC*).Invoke()
                chromeEl.WaitElementFromPath(DFiberSecBoxC*).Invoke()
                chromeEl.WaitElementFromPath(AFiberSecC*).Invoke()
                chromeEl.WaitElementFromPath(AutosavePathC*).Invoke()
                chromeEl.WaitElementFromPath(IDPathC*).Invoke()
            } catch {
                ; Ignore if the path isn’t found
            }
        }
    }

        ToggleAerialFiberPlacement() {
            if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
                chromeEl := UIA.ElementFromHandle(WinExist("A"))
                try {
                    fiberPlaceElement := chromeEl.ElementFromPath(DFiberPlaceBoxC*)
                    currentValue := fiberPlaceElement.Value
                    match := RegExMatch(currentValue, "(\d+)ct (Underground|Aerial)", &m)
                    if match {
                        cap := m[1]
                        place := m[2]
                        newPlace := (place = "Aerial") ? "Underground" : "Aerial"
                        newValue := cap "ct " newPlace
                        chromeEl.WaitElementFromPath(DFiberPlaceBoxC*).Invoke()
                        chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:baseT2}, {T:3, A:"input-placement"}, {T:8}, {T:7, N:newValue}]*).Invoke()
                    }
                    chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                } catch as e {
                    OutputDebug("Error in ToggleAerialFiberPlacement: " e.Message)
                }
            }
        }

        SetAerialFiberCapacity(capacity) {
            if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
                chromeEl := UIA.ElementFromHandle(WinExist("A"))
                try {
                    fiberPlaceElement := chromeEl.ElementFromPath(DFiberPlaceBoxC*)
                    currentValue := fiberPlaceElement.Value
                    match := RegExMatch(currentValue, "(\d+)ct (Underground|Aerial)", &m)
                    if match {
                        place := m[2]
                        newValue := capacity "ct " place
                        if (currentValue != newValue) {
                            chromeEl.WaitElementFromPath(DFiberPlaceBoxC*).Invoke()
                            chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:baseT2}, {T:3, A:"input-placement"}, {T:8}, {T:7, N:newValue}]*).Invoke()
                        }
                        fiberCapElement := chromeEl.ElementFromPath(DFiberCapBoxC*)
                        currentCap := fiberCapElement.Value
                        if (currentCap != capacity) {
                            fiberCapElement.Invoke()
                            chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:baseT2}, {T:3, A:"input-fiber-capacity"}, {T:8}, {T:7, N:capacity}]*).Invoke()
                        }
                    } else {
                        ToggleAerialFiberPlacement()
                        Sleep 100
                        fiberPlaceElement := chromeEl.ElementFromPath(DFiberPlaceBoxC*)
                        currentValue := fiberPlaceElement.Value
                        match := RegExMatch(currentValue, "(\d+)ct (Underground|Aerial)", &m)
                        if match {
                            place := m[2]
                            newValue := capacity "ct " place
                            if (currentValue != newValue) {
                                chromeEl.WaitElementFromPath(DFiberPlaceBoxC*).Invoke()
                                chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:baseT2}, {T:3, A:"input-placement"}, {T:8}, {T:7, N:newValue}]*).Invoke()
                            }
                            fiberCapElement := chromeEl.ElementFromPath(DFiberCapBoxC*)
                            currentCap := fiberCapElement.Value
                            if (currentCap != capacity) {
                                fiberCapElement.Invoke()
                                chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:baseT2}, {T:3, A:"input-fiber-capacity"}, {T:8}, {T:7, N:capacity}]*).Invoke()
                            }
                        }
                    }
                    chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                } catch as e {
                    OutputDebug("Error in SetAerialFiberCapacity: " e.Message)
                }
            }
        }

        SetAerialFiberSection(sectionNum) {
            if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
                chromeEl := UIA.ElementFromHandle(WinExist("A"))
                try {
                    sectionLabel := sectionNum
                    sectionElement := chromeEl.ElementFromPath(DFiberSecBoxC*)
                    sectionElement.Invoke()
                    chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:baseT2}, {T:3, A:"input-fiber-sections"}, {T:8}, {T:7, N:sectionLabel}]*).Invoke()
                    chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                } catch as e {
                    OutputDebug("Error in SetAerialFiberSection: " e.Message)
                }
            }
        }
    ; #endregion Aerial Fiber
    ; #region Backhaul

    BackhaulU() {
        Line()
        if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
            chromeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                chromeEl.WaitElementFromPath(BackhaulUFiber*).Invoke()
                chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                chromeEl.WaitElementFromPath(DFiberCapBoxC*).Invoke()
                chromeEl.WaitElementFromPath(DFiberCapC*).Invoke()
                chromeEl.WaitElementFromPath(DFiberPlaceBoxC*).Invoke()
                chromeEl.WaitElementFromPath(DFiberPlaceC*).Invoke()
                chromeEl.WaitElementFromPath(AutosavePathC*).Invoke()
                chromeEl.WaitElementFromPath(IDPathC*).Invoke()
            } catch {
                ; Ignore if the path isn’t found
            }
        }
    }

    BackhaulA() {
        Line()
        if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
            chromeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                chromeEl.WaitElementFromPath(BackhaulAFiber*).Invoke()
                chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                chromeEl.WaitElementFromPath(DFiberCapBoxC*).Invoke()
                chromeEl.WaitElementFromPath(DFiberCapC*).Invoke()
                chromeEl.WaitElementFromPath(DFiberPlaceBoxC*).Invoke()
                chromeEl.WaitElementFromPath(DFiberPlaceC*).Invoke()
                chromeEl.WaitElementFromPath(AutosavePathC*).Invoke()
                chromeEl.WaitElementFromPath(IDPathC*).Invoke()
            } catch {
                ; Ignore if the path isn’t found
            }
        }
    }
        ToggleBackhaulPlacement(){
            if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
                chromeEl := UIA.ElementFromHandle(WinExist("A"))
                try {
                    fiberPlaceElement := chromeEl.ElementFromPath(DFiberPlaceBoxC*)
                    currentValue := fiberPlaceElement.Value
                    match := RegExMatch(currentValue, "(\d+)ct (Underground|Aerial)", &m)
                    if match {
                        cap := m[1]
                        place := m[2]
                        newPlace := (place = "Underground") ? "Aerial" : "Underground"
                        newValue := cap "ct " newPlace
                        chromeEl.WaitElementFromPath(DFiberPlaceBoxC*).Invoke()
                        chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:baseT2}, {T:3, A:"input-placement"}, {T:8}, {T:7, N:newValue}]*).Invoke()
                    }
                    chromeEl.WaitElementFromPath(IDPathC*).Invoke()
                } catch as e {
                    OutputDebug("Error in ToggleBackhaulPlacement: " e.Message)
                }
            }
        }
        SetBackhaulCapacity(value) {
            if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
                chromeEl := UIA.ElementFromHandle(WinExist("A"))
                try {
                    fiberPlaceElement := chromeEl.ElementFromPath(DFiberPlaceBoxC*)
                    currentValue := fiberPlaceElement.Value
                    match := RegExMatch(currentValue, "(\d+)ct (Underground|Aerial)", &m)
                    if match {
                        place := m[2]
                        newValue := value "ct " place
                        if (currentValue != newValue) {
                            chromeEl.WaitElementFromPath(DFiberPlaceBoxC*).Invoke()
                            chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:baseT2}, {T:3, A:"input-placement"}, {T:8}, {T:7, N:newValue}]*).Invoke()
                        }
                        fiberCapElement := chromeEl.ElementFromPath(DFiberCapBoxC*)
                        currentCap := fiberCapElement.Value
                        if (currentCap != value) {
                            fiberCapElement.Invoke()
                            chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:baseT2}, {T:3, A:"input-fiber-capacity"}, {T:8}, {T:7, N:value}]*).Invoke()
                        }
                    } else {
                        ToggleBackhaulPlacement()
                        Sleep 100
                        fiberPlaceElement := chromeEl.ElementFromPath(DFiberPlaceBoxC*)
                        currentValue := fiberPlaceElement.Value
                        match := RegExMatch(currentValue, "(\d+)ct (Underground|Aerial)", &m)
                        if match {
                            place := m[2]
                            newValue := value "ct " place
                            if (currentValue != newValue) {
                                chromeEl.WaitElementFromPath(DFiberPlaceBoxC*).Invoke()
                                chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:baseT2}, {T:3, A:"input-placement"}, {T:8}, {T:7, N:newValue}]*).Invoke()
                            }
                            fiberCapElement := chromeEl.ElementFromPath(DFiberCapBoxC*)
                            currentCap := fiberCapElement.Value
                            if (currentCap != value) {
                                fiberCapElement.Invoke()
                                chromeEl.WaitElementFromPath([{T:30}, {T:26, i:-1}, {T:baseT2}, {T:3, A:"input-fiber-capacity"}, {T:8}, {T:7, N:value}]*).Invoke()
                            }
                        }
                    }
                } catch as e {
                    OutputDebug("Error in SetBackhaulCapacity: " e.Message)
                }
                chromeEl.WaitElementFromPath(IDPathC*).Invoke()
            }
        }

    ; #endregion Backhaul
    ; #region Drops
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
                chromeEl.WaitElementFromPath(AutosavePathC*).Invoke()
                Sleep 100
                Send("{PgUp 4}")
            } catch {
                ; Ignore if the path isn’t found
                OutputDebug("Attempting to find MessengerPathC")
            }
        }
    }


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
    ; #endregion Drops
    ; #region NAPs


    
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
                    chromeEl.WaitElementFromPath(AutosavePathC*).Invoke()
                    chromeEl.WaitElementFromPath(IDPathC*).Invoke()

                } catch {
                    ; Ignore if the path isn’t found
                }
            }
        }

    

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
    ; #endregion NAPs
    ; #region Slack Loops



; Helper to get current placement (Underground or Aerial)
GetSlackLoopPlacement() {
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        try {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        slackLoopElement := chromeEl.ElementFromPath(SlackLoopPlacement*)
        return slackLoopElement.Value
        } catch {
           if debugmode { 
               ToolTip("Breakpoint reached in GetSlackLoopPlacement function. Path not found.")
           }
        }
    }
    return ""
}

SlackLoops() {
    Point()
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.WaitElementFromPath(SlackLoopPath*).Invoke()
            chromeEl.WaitElementFromPath(SlackLoopPlacement*).Invoke()
            chromeEl.WaitElementFromPath(SlackLoopUnderground*).Invoke()
            chromeEl.WaitElementFromPath(SlackLoopSelect*).Invoke()
            chromeEl.WaitElementFromPath(SlackLoop30Loop*).Invoke()
            chromeEl.WaitElementFromPath(AutosavePathC*).Invoke()
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
           SetSlackLoopLength("100' Tail", SlackLoop70Tail)
        }else {
           SetSlackLoopLength("70' Tail", SlackLoop70Tail)
        }
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
        }
    }

    SlackLoopImputLength(value){
        if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
            chromeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                chromeEl.WaitElementFromPath(SlackLoopLength*).Invoke() 
                sleep 100
                Send "^a{Del}"
                sleep 50
                Send value
                chromeEl.WaitElementFromPath(IDPathC*).Invoke()
            } catch as e {
                OutputDebug("Error in SlackLoopImputLength: " e.Message)
            }
        }
    }

    SetLoopSection(sectionNum) {
        if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
            chromeEl := UIA.ElementFromHandle(WinExist("A"))
            try {
                sectionElement := chromeEl.ElementFromPath(FiberSectionPath*)
                currentPlacement := GetSlackLoopPlacement()
                sectionLabel := sectionNum " - " (currentPlacement = "Aerial" ? "Aerial" : "Underground")
                sectionPath := [{T:30}, {T:26, i:-1}, {T:baseT2}, {T:3, A:"input-fiber-sections"}, {T:8}, {T:7, N:sectionLabel}]
                sectionElement.Invoke()
                chromeEl.WaitElementFromPath(sectionPath*).Invoke()
                chromeEl.WaitElementFromPath(IDPathC*).Invoke()
            } catch {
                ; Handle errors gracefully
            }
        }
    }
; #endregion Slack Loops

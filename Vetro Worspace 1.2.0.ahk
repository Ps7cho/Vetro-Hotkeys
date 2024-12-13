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
MButton:: ClosePanel() ; alternate
!q:: Unlock()
!Esc:: Reload


;----------------------------------------------------------------------
; General Hotkeys
;----------------------------------------------------------------------

;Variables
savePathC := [{T:30}, {T:26, i:-1}, {T:0, N:"Save"}]
deletePathC := [{T:30}, {T:26, i:-1}, {T:0,N:"Delete"}]
featureDeletionPathC := [{T:30}, {T:26, i:-1}, {T:25, A:"feature-deletion-modal"}, {T:26, A:"feature-deletion-modal___BV_modal_content_"}, {T:0, i:-1}]
ClosePanelPathC := [{T:30}, {T:26, i:-1}, {T:6}]
UnlockPathC := [{T:30}, {T:26, i:-1}, {T:21, i:-1}, {T:0}]

;basic functions
Save() {
    ; Ensure the active window is Chrome with "VETRO" in the title
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        if chromeEl {
            try {
                saveButton := chromeEl.ElementFromPath(savePathC*)
                if saveButton
                    saveButton.Click() ; Use Click() to simulate a button press
            } catch {
                ; Ignore if the element path isn't found
            }
        }
    }
}

Delete() {
    ; Ensure the active window is Chrome with "VETRO" in the title
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        
        ; Find the "Delete" button
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
    ; Ensure the active window is Chrome with "VETRO" in the title
    if WinActive("ahk_exe chrome.exe") && InStr(WinGetTitle("A"), "VETRO") {
        chromeEl := UIA.ElementFromHandle(WinExist("A"))
        try {
            chromeEl.ElementFromPath(ClosePanelPathC*).Invoke()
        } catch {
            ; Ignore if the path isn’t found
        }
    }
    global SubMode

    ; Reset SubMode if it's not empty
    if (SubMode != "") {
        SubMode := ""
    }
}

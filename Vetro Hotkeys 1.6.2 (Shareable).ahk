#Requires AutoHotkey v2.0

;Top Scroll: 555, 345 b4bdca
;Bottom Scroll: 555, 962 b4bdca

; Function to perform the mouse clicks
ClickPositions(x1, y1, x2, y2) {
    MouseGetPos(&oldX, &oldY)   ; Get current mouse position
    Click(x1, y1)
    Sleep(40)  ; Slight delay to mimic natural clicking
    Click(x2, y2)
    MouseMove(oldX, oldY)
}

; First click position
x1 := 105
y1 := 689  ; Adjusted from 695 to 689

; Variable to track if the script is enabled or disabled
toggle := false

; Toggle hotkeys with Ctrl+`
^`::  ; Ctrl + ` key (toggle)
{
    global toggle  ; Declare toggle as global
    if toggle := !toggle {
        ToolTip("Hotkeys ON")
    } else {
        ToolTip("Hotkeys OFF")
    }
    SetTimer(RemoveToolTip, -1000)  ; Remove the tooltip after 1 second
}

; Define hotkey functions
#HotIf toggle
1::ClickPositions(x1, y1, 105, 737)  ; Adjusted from 743 to 737
2::ClickPositions(x1, y1, 105, 764)  ; Adjusted from 770 to 764
3::ClickPositions(x1, y1, 105, 786)  ; Adjusted from 792 to 786
4::ClickPositions(x1, y1, 105, 809)  ; Adjusted from 815 to 809
5::ClickPositions(x1, y1, 105, 834)  ; Adjusted from 840 to 834
6::ClickPositions(x1, y1, 105, 859)  ; Adjusted from 865 to 859
7::ClickPositions(x1, y1, 105, 879)  ; Adjusted from 885 to 879
8::ClickPositions(x1, y1, 105, 909)  ; Adjusted from 915 to 909
9::ClickPositions(x1, y1, 105, 929)  ; Adjusted from 935 to 929
0::ClickPositions(x1, y1, 105, 956)  ; Adjusted from 962 to 956
-::ClickPositions(x1, y1, 105, 979)  ; Adjusted from 985 to 979
=::ClickPositions(x1, y1, 105, 999)  ; Adjusted from 1005 to 999
#HotIf

RemoveToolTip() {
    ToolTip("")  ; Clear the tooltip
}


CoordMode("Mouse", "Screen")    ; Coordinates are relative to the desktop (entire screen)
!s:: {
    MouseGetPos(&oldX, &oldY)   ; Get current mouse position
    Click(500, 994)             ; Adjusted from 1000 to 994
    MouseMove(oldX, oldY)       ; Move mouse back to original position
}

CoordMode("Mouse", "Screen")    ; Coordinates are relative to the desktop (entire screen)
!x:: {
    MouseGetPos(&oldX, &oldY)   ; Get current mouse position
    Click(115, 994)             ; Adjusted from 1000 to 994
    Sleep 800
    Click(1150, 294)            ; Adjusted from 300 to 294
    MouseMove(oldX, oldY)       ; Move mouse back to original position
}

CoordMode("Mouse", "Screen")    ; Coordinates are relative to the desktop (entire screen)
MButton:: {
    MouseGetPos(&oldX, &oldY)   ; Get current mouse position
    Click(535, 199)             ; Adjusted from 205 to 199
    MouseMove(oldX, oldY)       ; Move mouse back to original position
}

!d:: {
    CoordMode("Mouse", "Screen")

    ; Store the original mouse position
    MouseGetPos(&originalX, &originalY)

    ; Click at coordinates (1892, 246) - Pencil
    Click 1892, 246  ; Adjusted from 252 to 246
    Sleep 70  ; Short delay to allow for processing

    ; Select "line"
    Send "+{Tab 22}"
    Sleep 70

    ; Select
    Send "{Enter}"
    Sleep 70

    ; tab over
    Send "+{tab 14}"
    Sleep 70

    ; tab over
    Send "{tab}"
    Sleep 70

    ; Select "Drop"
    Send "{Down 8}"
    Sleep 70

    ; Press Tab 2 times
    Send "{Tab 2}"
    Sleep 70

    ; Press '1'
    Send "{Down 1}"
    Sleep 70

    ; Press Tab
    Send "{Tab}"
    Sleep 70

    ; Press 'u'
    Send "{Down 2}"
    Sleep 70

    ; Press Tab
    Send "{Tab}"
    Sleep 70

    ; Press '1'
    Send "{Down 1}"
    Sleep 70

    ; Press Tab 12 times
    Send "{Tab 12}"
    Sleep 70

    ; Press Space
    Send "{Space}"
    Sleep 70

    ; Press Tab and enter '54'
    Send "{Tab 54}"
    Sleep 70

    MouseMove(originalX, originalY)
}

!N:: {
    CoordMode("Mouse", "Screen")

    ; Store the original mouse position
    MouseGetPos(&originalX, &originalY)

    ; Click at coordinates (1892, 244) - Pencil
    Click 1892, 244  ; Adjusted from 250 to 244
    Sleep 70  ; Short delay to allow for processing

    ; Select "Point"
    Send "+{Tab 23}"
    Sleep 70

    ; Enter "Point"
    Send "{Enter}"
    Sleep 70

    ; tab to Before Layer
    Send "+{tab 13}"
    Sleep 70

    ; tab to Layer
    Send "{tab}"
    Sleep 70

    ; Select "NAP"
    Send "{Down 11}"
    Sleep 70

    ; Tab to Type
    Send "{Tab 4}"
    Sleep 70

    ; Select "NAP"
    Send "{Down 1}"
    Sleep 70

    ; Tab to Type
    Send "{Tab 1}"
    Sleep 70

    ; Select "NAP"
    Send "{Down 1}"
    Sleep 70

    ; Tab to Type
    Send "{Tab 3}"
    Sleep 70

    ; Select "NAP"
    Send "{Down 4}"
    Sleep 70

    ; Tab to Type
    Send "{Tab 8}"
    Sleep 70

    ; Select Autosave
    Send "{Space}"
    Sleep 70

    ; Press Tab and enter '54'
    Send "{Tab 54}"
    Sleep 200

    ; Step: Wait for color FFFFFF at (466, 206) and click at (99, 464)
    while !PixelSearch(&x, &y, 466, 206, 466, 206, 0xFFFFFF, 0) {
        Sleep(100)  ; Wait until the color is found
    }
    Sleep(100)
    Click(99, 464)  ; Adjusted from (99, 470) to (99, 464)
    Sleep(100)
}

F9:: {
    ; Use screen coordinates for both mouse and pixel searches
    CoordMode("Mouse", "Screen")
    CoordMode("Pixel", "Screen")

    ; Define colors for comparison
    color1 := 0xF2F2F2
    color2 := 0xC8C8C8
    color3 := 0x1967D2
    color4 := 0x1AB260  ; Color for waiting after clicking 504, 1004
    color5 := 0xFFFFFF
    tolerance := 10  ; Increase tolerance for color detection

    ; Coordinates to click and wait for color 1AB260
    waitX := 821
    waitY := 988  ; Adjusted from 994 to 988

    Loop 4 {
        ; Determine the splitter number
        splitterNumber := A_Index

        ; Execute steps 1-4 only for the first iteration
        if A_Index == 1 {
            ; Step 1: Click 100, 468
            Click(100, 468)
            Sleep(100)

            ; Step 2: Select all text in the field
            Send("^a")
            Sleep(100)

            ; Step 3: Deselect the last 6 characters
            Loop 6 {
                Send("+{Left}")
                Sleep(50)
            }

            ; Step 4: Copy the selection
            Send("^c")
            Sleep(100)
        }

        ; Step 5: Click 535, 269 (start here after the first iteration)
        Click(535, 269)
        Sleep(200)

        ; Step 6v2: Wait for color FFFFFF at (540, 245) before continuing
        while !PixelSearch(&x, &y, 540, 245, 540, 245, color5, 0) {
            Sleep(100)  ; Wait until the color is found
        }
        Sleep(100)

        ; Step 7: Select by clicking (waitX, waitY)
        Click(waitX, waitY)
        Sleep(100)

        ; Step 8: Select the appropriate splitter number
        Send("{Down " . splitterNumber . "}")
        Sleep(100)

        ; Step 9: Press Enter
        Send("{Enter}")
        Sleep(100)

        ; Step 10: Wait for color 1AB260 at (504, 1004)
        while !PixelSearch(&x, &y, 504, 1004, 504, 1004, color4, tolerance) {
            Sleep(100)  ; Wait until the color is found
        }

        ; Step 11: After the color is found, click at (100, 1004)
        Click(100, 1004)
        Sleep(100)

        ; Step 12: Wait for color C8C8C8 at (466, 206) and click at (99, 464)
        while !PixelSearch(&x, &y, 466, 206, 466, 206, color2, 0) {
            Sleep(100)  ; Wait until the color is found
        }
        Sleep(100)
        Click(99, 464)  ; Adjusted from (99, 470) to (99, 464)
        Sleep(100)
    }
}

F10::
{
    ; Step 1-4: First set of actions (before the loop starts)
    Click 521, 265             ; Clicks at coordinates (521, 265)
    Sleep 200                  ; Waits for 200ms
    Send "{Down}"              ; Presses the down arrow key
    Sleep 10
    Send "{Enter}"             ; Presses the enter key
    Sleep 100

    ; Loop 14 times for steps 5-20, adjusting behavior for the last iteration
    Loop 14
    {
        ; Steps 6-16 (common actions for all iterations)
        Send "{Tab 2}"         ; Presses the tab key twice
        Sleep 100
        Send "{Down}"          ; Presses the down arrow key
        Sleep 200
        Send "{Tab}"           ; Presses the tab key once
        Sleep 20
        Send "^v"              ; Pastes the clipboard content
        Sleep 20

        ; Send sequential numbers from 01 to 14
        if (A_Index < 10)      ; Adds leading zero for single digits
        {
            Send " Tray 0" A_Index
        }
        else
        {
            Send " Tray " A_Index
        }
        Sleep 20
        
        Send "{Tab 2}"         ; Presses the tab key twice
        Sleep 200
        Send "{Down 5}"        ; Presses the down arrow key five times
        Sleep 20
        Send "{Tab 10}"        ; Presses the tab key ten times
        Sleep 20
        Send "{Enter}"         ; Presses the enter key
        Sleep 200

        ; For the last iteration (14th), stop after step 16
        if (A_Index = 14)
            break

        ; Step 17: Wait for color FFFFFF at (400, 200)
        local x, y              ; Declare variables for PixelSearch
        while !PixelSearch(&x, &y, 400, 200, 400, 200, 0xFFFFFF, 0) {
            Sleep(100)          ; Wait until the color is found
        }
        Sleep 10               ; Sleep for 10ms after detecting the color

        ; Steps 17-20 (Skip for the last iteration)
        Send "+{Tab 15}"       ; Presses Shift+Tab fifteen times
        Sleep 200
        Send "{Space}"         ; Presses the space bar
        Sleep 200
        Send "{Down}"          ; Presses the down arrow key
        Sleep 200
        Send "{Enter}"         ; Presses the enter key
        Sleep 200
    }
}


; Exit script with ESC
Esc::Reload




;-----------------------------------------------------------------------
;Discovery Addons

!m::
{
CoordMode("Mouse", "Screen")

; Store the original mouse position
MouseGetPos(&originalX, &originalY)

; Click at coordinates (1892, 252) - Pencil
Click 1892, 252
Sleep 70  ; Short delay to allow for processing

MouseMove(originalX, originalY)

; Select "line"
Send "+{Tab 22}"
Sleep 70

; Select
Send "{Enter}"
Sleep 70

; tab over
Send "+{tab 14}"
Sleep 70

; tab over
Send "{tab}"
Sleep 70

; Select "messenger wire"
Send "{Down 13}"
Sleep 70

; Press Tab 2 times
Send "{Tab 3}"
Sleep 70

; Press '1'
Send "{Down 1}"
Sleep 70

; Press Tab
Send "{Tab 5}"
Sleep 70

; Press Space
Send "{Space}"
Sleep 70

; Press Tab and enter '54'
Send "{Tab 54}"
Sleep 70

}


!p::
{
CoordMode("Mouse", "Screen")

; Store the original mouse position
MouseGetPos(&originalX, &originalY)

; Click at coordinates (1892, 252) - Pencil
Click 1892, 252
Sleep 70  ; Short delay to allow for processing

MouseMove(originalX, originalY)

; Select "line"
Send "+{Tab 21}"
Sleep 70

; Select
Send "{Enter}"
Sleep 70

; tab over
Send "+{tab 15}"
Sleep 70

; tab over
Send "{tab}"
Sleep 70

; Select "messenger wire"
Send "{Down 3}"
Sleep 70

; Press Tab 2 times
Send "{Tab}"
Sleep 70

}


!o::
{
CoordMode("Mouse", "Screen")

; Store the original mouse position
MouseGetPos(&originalX, &originalY)

; Click at coordinates (1892, 252) - Pencil
Click 1892, 252
Sleep 70  ; Short delay to allow for processing

MouseMove(originalX, originalY)

; Select "line"
Send "+{Tab 21}"
Sleep 70

; Select
Send "{Enter}"
Sleep 70

; tab over
Send "+{tab 15}"
Sleep 70

; tab over
Send "{tab}"
Sleep 70

; Select "messenger wire"
Send "{Down 2}"
Sleep 70

; Press Tab 2 times
Send "{Tab 2}"
Sleep 70

}


!l::
{
CoordMode("Mouse", "Screen")

; Store the original mouse position
MouseGetPos(&originalX, &originalY)

; Click at coordinates (1892, 252) - Pencil
Click 1892, 252
Sleep 70  ; Short delay to allow for processing

MouseMove(originalX, originalY)

; Select "line"
Send "+{Tab 22}"
Sleep 70

; Select
Send "{Enter}"
Sleep 70

; tab over
Send "+{tab 14}"
Sleep 70

; tab over
Send "{tab}"
Sleep 70

; Select "messenger wire"
Send "{Down 12}"
Sleep 70

; Press Tab 2 times
Send "{Tab 3}"
Sleep 70

; Press Space
Send "{Space}"
Sleep 200

; Click Total Length
Send "+{Tab 2}"

; Click Total Length
Send "{Tab}"

}


!,::
{
CoordMode("Mouse", "Screen")

; Store the original mouse position
MouseGetPos(&originalX, &originalY)

; Click at coordinates (1892, 252) - Pencil
Click 1892, 252
Sleep 70  ; Short delay to allow for processing

MouseMove(originalX, originalY)

; Select "line"
Send "+{Tab 22}"
Sleep 70

; Select
Send "{Enter}"
Sleep 70

; tab over
Send "+{tab 14}"
Sleep 70

; tab over
Send "{tab}"
Sleep 70

; Select "messenger wire"
Send "{Down 22}"
Sleep 70

; Press Tab 2 times
Send "{Tab 2}"
Sleep 70

; Press '1'
Send "{Space}"
Sleep 70

; Press Tab
Send "+{Tab}"
Sleep 70

Send "PUE "

}

!.::
{
CoordMode("Mouse", "Screen")

; Store the original mouse position
MouseGetPos(&originalX, &originalY)

; Click at coordinates (1892, 252) - Pencil
Click 1892, 252
Sleep 70  ; Short delay to allow for processing

MouseMove(originalX, originalY)

; Select "line"
Send "+{Tab 22}"
Sleep 70

; Select
Send "{Enter}"
Sleep 70

; tab over
Send "+{tab 14}"
Sleep 70

; tab over
Send "{tab}"
Sleep 70

; Select "messenger wire"
Send "{Down 22}"
Sleep 70

; Press Tab 2 times
Send "{Tab 2}"
Sleep 70

; Press '1'
Send "{Space}"
Sleep 70

; Press Tab
Send "+{Tab}"
Sleep 70

Send "ROW "

}

!k::
{
CoordMode("Mouse", "Screen")

; Store the original mouse position
MouseGetPos(&originalX, &originalY)

; Click at coordinates (1892, 252) - Pencil
Click 1892, 252
Sleep 70  ; Short delay to allow for processing

MouseMove(originalX, originalY)

; Select "line"
Send "+{Tab 22}"
Sleep 70

; Select
Send "{Enter}"
Sleep 70

; tab over
Send "+{tab 14}"
Sleep 70

; tab over
Send "{tab}"
Sleep 70

; Select "messenger wire"
Send "{Down 25}"
Sleep 70

; Press Tab 2 times
Send "{Tab 2}"
Sleep 70

; Press '1'
Send "{Space}"
Sleep 70

; Press Tab
Send "+{Tab}"
Sleep 70

Send "Road Centerline "

}

;-----------------------------------------------------------------------

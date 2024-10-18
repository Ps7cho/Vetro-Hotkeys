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
y1 := 695

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
1::ClickPositions(x1, y1, 105, 743)
2::ClickPositions(x1, y1, 105, 770)
3::ClickPositions(x1, y1, 105, 792)
4::ClickPositions(x1, y1, 105, 815)
5::ClickPositions(x1, y1, 105, 840)
6::ClickPositions(x1, y1, 105, 865)
7::ClickPositions(x1, y1, 105, 885)
8::ClickPositions(x1, y1, 105, 915)
9::ClickPositions(x1, y1, 105, 935)
0::ClickPositions(x1, y1, 105, 962)
-::ClickPositions(x1, y1, 105, 985)
=::ClickPositions(x1, y1, 105, 1005)
#HotIf

RemoveToolTip() {
    ToolTip("")  ; Clear the tooltip
}

; Exit script with ESC
Esc::ExitApp


CoordMode("Mouse", "Screen")    ; Coordinates are relative to the desktop (entire screen)
XButton1:: {
    MouseGetPos(&oldX, &oldY)   ; Get current mouse position
    Click(500, 1000)             ; Perform click at (300, 400)
    MouseMove(oldX, oldY)       ; Move mouse back to original position
}

CoordMode("Mouse", "Screen")    ; Coordinates are relative to the desktop (entire screen)
XButton2:: {
    MouseGetPos(&oldX, &oldY)   ; Get current mouse position
    Click(115, 1000)             ; Perform click at (300, 400)
    Sleep 800
    Click(1150, 300)             ; Perform click at (1150, 300)
    MouseMove(oldX, oldY)       ; Move mouse back to original position
}

CoordMode("Mouse", "Screen")    ; Coordinates are relative to the desktop (entire screen)
MButton:: {
    MouseGetPos(&oldX, &oldY)   ; Get current mouse position
    Click(535, 205)             ; Perform click at (300, 400)
    MouseMove(oldX, oldY)       ; Move mouse back to original position
}

!d::
{
CoordMode("Mouse", "Screen")

; Store the original mouse position
MouseGetPos(&originalX, &originalY)

; Click at coordinates (1892, 252) - Pencil
Click 1892, 252
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

; Press the down arrow key 7 times
Send "{Down 7}"
Sleep 70

; Press Enter
;Send "{Enter}"
;Sleep 70

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

;Send("{WheelUp 10}")
;Sleep(30)

MouseMove(originalX, originalY)

}

!N::
{
CoordMode("Mouse", "Screen")

; Store the original mouse position
MouseGetPos(&originalX, &originalY)

; Click at coordinates (1892, 252) - Pencil
Click 1892, 250
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

; Step: Wait for color FFFFFF at (466, 212) and click at (99, 470)
while !PixelSearch(&x, &y, 466, 212, 466, 212, 0xFFFFFF, 0) {
    Sleep(100)  ; Wait until the color is found
}
Sleep(100)
Click(99, 470)
Sleep(100)

}

F8::
{
    ; Use screen coordinates for both mouse and pixel searches
    CoordMode("Mouse", "Screen")
    CoordMode("Pixel", "Screen")

    ; Define colors for comparison
    color1 := 0xF2F2F2
    color2 := 0xC8C8C8
    color3 := 0x1967D2
    color4 := 0x1AB260  ; Color for waiting after clicking 504, 1010
    color5 := 0xFFFFFF
    tolerance := 10  ; Increase tolerance for color detection

    ; Coordinates to click and wait for color 1AB260
    waitX := 821
    waitY := 994


    Loop 4
    {
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

        ; Step 6v2: Wait for color FFFFFF at 549, 266 and click 536, 299
        while !PixelSearch(&x, &y, 549, 266, 549, 266, color5, tolerance) {
            Sleep(100)  ; Wait until the color is found
        }
        Click(536, 299)
        Sleep(100)

        ; Step 6: Click 536, 299
        ;Click(536, 299)
        ;Sleep(100)

        ; Step 7: Sleep 500 before clicking 109, 393
        Sleep(500)
        Click(109, 393)
        Sleep(100)

        ; Step 8: Wait for color C8C8C8 at 290, 424 and click 107, 493
        while !PixelSearch(&x, &y, 290, 424, 290, 424, color2, tolerance) {
            Sleep(100)  ; Wait until the color is found
        }
        Click(107, 493)
        Sleep(100)

        ; Step 9: Click 112, 467
        Click(112, 467)
        Sleep(100)

        ; Step 10: Paste copied content and append the correct "Splitter" number
        Send("^v")
        Send("{Space}Splitter " splitterNumber)
        Sleep(100)

        ; Step 11: Click 100, 544
        Click(100, 544)
        Sleep(100)

        ; Step 12: Wait for color C8C8C8 at 287, 573 and click 99, 692
        while !PixelSearch(&x, &y, 287, 573, 287, 573, color2, tolerance) {
            Sleep(100)  ; Wait until the color is found
        }
        Click(99, 692)
        Sleep(100)

        ; Step 13: Click 99, 692
        Click(99, 692)
        Sleep(100)

        ; Step 14: Wait for color 1967D2 at 296, 718 and click 99, 768
        while !PixelSearch(&x, &y, 296, 718, 296, 718, color3, tolerance) {
            Sleep(100)  ; Wait until the color is found
        }
        Click(99, 768)
        Sleep(100)

        ; Step 15: Click 504, 1010
        Click(504, 1010)
        Sleep(100)

        ; Step 16: Wait for color 1AB260 at 821, 994 before continuing to the next iteration
        while !PixelSearch(&x, &y, waitX, waitY, waitX, waitY, color4, tolerance) {
            Sleep(1000)  ; Wait in intervals until color is found
        }
    }
}

Sleep 100
Send("{Ctrl down}{` down}")
Sleep(5)  ; Gives the PC time to process
Send("{` up}{Ctrl up}")

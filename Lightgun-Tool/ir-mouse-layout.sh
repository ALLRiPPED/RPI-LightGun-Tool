#!/bin/bash
function mouse-layout-menu() {
local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "MAIN MENU" \
      --ok-label Select --cancel-label Exit \
      --menu "WHAT KIND OF GUN DO YOU HAVE?" 50 60 50 \
      1 "Display Controller Layout" \
      2 "Play Controller Video" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) ir-mouse-layout ;;
    2) ir-mouse-video ;;
     -) no ;;
     *) break ;;
    esac
   done
}


function ir-mouse-layout() {
dialog  --sleep 1 --title "ATTENTION MESSAGE" --msgbox "
IR MOUSE & KEYBOARD LAYOUT
FOR RETROARCH/IN GAME
KEYBOARD -----IN RA/WITH HOTKEY
left alt ---- start/hotkey
left ctrl --- select/quit
a  ---------- a
s  ---------- b
d  ---------- x/save state
f  ---------- y/load state
down  ------- down
up  --------- up/menu
left  ------- left
right  ------ right
trigger ----- shoot
mouse2 ------- reload 
--------------------------------
--------------------------------
FOR EMULATION STATION WE SUGGEST
WII MOTE -----IN RETROPIE MENUS
left alt  ---------- start/hotkey
left ctrl ---------- select
a  ---------- A
s  ---------- B
d  ---------- X/save state
f  ---------- Y/load state
down  ------- down
up  --------- up
left  ------- left
right  ------ right/load state
mouse2 ------ nothing
trigger ----- nothing" 0 0
}

function wii-video() {
omxplayer $HOME/Lightgun-Tool/ir-mouse-layout.mp4  > /dev/null 2>&1
}

mouse-layout-menu

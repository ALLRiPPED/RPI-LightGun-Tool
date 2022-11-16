#!/bin/bash
function layout-menu() {
local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "MAIN MENU" \
      --ok-label Select --cancel-label Exit \
      --menu "WHAT KIND OF GUN DO YOU HAVE?" 50 60 50 \
      1 "Display Controller Layout" \
      2 "Play Controller Video" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) wii-layout ;;
    2) wii-video ;;
     -) no ;;
     *) break ;;
    esac
   done
}


function wii-layout() {
dialog  --sleep 1 --title "ATTENTION MESSAGE" --msgbox "
WII MOTE LAYOUT IS AS FOLLOWS
FOR RETROARCH/IN GAME
WII MOTE -----IN RA/WITH HOTKEY
+  ---------- start/hotkey
-  ---------- select/quit
1  ---------- nothing
2  ---------- nothing
down  ------- down/reset
up  --------- up/menu
left  ------- left/save state
right  ------ right/load state
trigger ----- a & shoot
A ----------- b & reload 


FOR EMULATION STATION WE SUGGEST
WII MOTE -----IN RETROPIE MENUS
+  ---------- start/hotkey
-  ---------- select
1  ---------- A
2  ---------- B
down  ------- down
up  --------- up
left  ------- left/save state
right  ------ right/load state
A ----------- nothing
trigeer ----- nothing" 0 0
}

function wii-video() {
omxplayer $HOME/Lightgun-Tool/wii-layout.mp4  > /dev/null 2>&1
}

layout-menu

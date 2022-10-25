#!/bin/bash
export NCURSES_NO_UTF8_ACS=1
BACKTITLE="<-----RPI MOUSE GUN SETUP MENU----->"

dialog  --sleep 1 --title "MOUSE GUN SETUP MENU INFO" --msgbox "
----------ATTENTION!!!!!!----------
-----------------------------------
THIS IS FOR MOUSE INPUT GUNS ONLY.
THIS WILL NOT WORK WITH SINDEN GUNS.

EXAMPLE GUNS FOR THIS SCRIPT:
- GUN4IR
- WII MOTE WITH DOLPHIN BAR
- AIMTRACK (UNTESTED, UNLIKELY)
- ACTUAL MOUSE LOL" 0 0

function gun-menu() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "RPI MOUSE GUN SETUP MENU " \
      --ok-label Install --cancel-label Exit \
      --menu "PRESS A/ENTER TO SETUP CONSOLE" 40 60 40 \
      1 "Arcade Setup" \
      2 "Atari800 Setup" \
      3 "Atari2600 Setup" \
      4 "NES Setup" \
      5 "SNES Setup" \
       + "<                                     >" \
       + "<---Mouse Lightgun Setup Menu Tools--->" \
       + "<                                     >" \
      T1 "-UPDATE MOUSE LIGHTGUN SETUP MENU       " \
      T2 "-REMOVE MOUSE LIGHTGUN SETUP MENU       " \                
      2>&1 >/dev/tty)

    case "$choice" in
    1) ra-gun "arcade"  ;;
    2) ra-gun "atari800"  ;;
    3) ra-gun "atari2600" ;;
    4) ra-gun "nes" "FCEEUM" ;;
    5) ra-gun "snes"   ;;
    T1) update-script ;;
    T2) remove-script ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function ra-gun() {
if [ -f "RETROARCH CONFIG PATH" ]; then sudo rm RETROARCH CONFIG PATH; fi
wget  https://github.com/Retro-Devils/RPI-Mouse-Gun-Setup/new/main/ra-configs/"$1"-lightgun.cfg -PPATH COMIGN SOON
dialog  --sleep 1 --title ""$1" GUN SETUP INFO" --msgbox "
----------ATTENTION!!!!!!----------
-----------------------------------
YOU WILL NEED TO DO THE FOLLOWING
- OPEN GAME YOU WISH TO USE GUN WITH
- OPEN RETROARCH SETTINGS
- MAKE SURE GLOBAL CONFIGS ARE OFF
- TURN ON PER CORE OVERRIDES
- GO TO CONFIGURATION 
- LOAD NEW CONFIG 
- GO TO PATH/COMING/SOON/"$1"-lightgun.cfg
- SAVE CONFIG FOR "$2"" 0 0
}

gun-menu

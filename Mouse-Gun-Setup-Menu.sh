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
      6 "Mastersystem Setup" \
       + "<                                     >" \
       + "<---Mouse Lightgun Setup Menu Tools--->" \
       + "<                                     >" \
      T1 "-SETUP INFO/HELP         " \   
      T2 "-UPDATE SETUP MENU       " \
      T3 "-UNINSTALL SETUP MENU    " \                
      2>&1 >/dev/tty)

    case "$choice" in
    1) ra-gun "arcade"  ;;
    2) ra-gun "atari800"  ;;
    3) ra-gun "atari2600" ;;
    4) ra-gun "nes" "fceeum" ;;
    5) ra-gun "snes"   ;;
    6) ra-gun "mastersystem" ;;
    T1) update-script ;;
    T2) remove-script ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function ra-gun() {
if [ -f "RETROARCH CONFIG PATH" ]; then sudo rm RETROARCH CONFIG PATH; fi
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "EXIT MESSAGE" \
      --ok-label Install --cancel-label Exit \
      --menu "WHAT OPTIONS DO YOU WANT FOR  "$1"?" 40 60 40 \
      1 "APPLY CONFIG" \
      2 "APPLY CONFIG & EDIT ES SYSTEMS " \ 
      3 "DOWNLOAD & APPLY RETROARCH CONFIG" \
      4 " " \
      2>&1 >/dev/tty)

    case "$choice" in
    1) es-edit-gun "$1"  ;;
    2) no  ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function sa-gun() {
if [ -f "RETROARCH CONFIG PATH" ]; then sudo rm RETROARCH CONFIG PATH; fi
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "EXIT MESSAGE" \
      --ok-label Install --cancel-label Exit \
      --menu "WHAT OPTIONS DO YOU WANT FOR  "$1"?" 40 60 40 \
      1 "MAKE GUN DIRECTORY FOR "$1"       " \
      2 "MAKE DIRECTORY & EDIT ES SYSTEMS  " \ 
      3 "DOWNLOAD & APPLY RETROARCH CONFIG " \
      4 "APPLY ALL " \
      2>&1 >/dev/tty)

    case "$choice" in
    1) make-directory "$1"  ;;
    2) es-edit-gun "$1"  ;;
    3) retroarch-config  ;;
    4) apply-all-gun  ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function make-directory() {
mkdir "$HOME"/RetroPie/roms/gun-games/"$1"
dialog  --sleep 1 --title "MAKE DIRECTORY EXIT MESSAGE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/gun-games/"$1" " 0 0
}


function es-edit-gun() {
sudo cp "$1" config-----path -P "$1"
mkdir "$HOME"/RetroPie/roms/gun-games/"$1"
if [ ! -s "$HOME/.emulationstation/es_systems.cfg" ]; then sudo rm -f $HOME/.emulationstation/es_systems.cfg; fi
if [ ! -f "$HOME/.emulationstation/es_systems.cfg" ]; then cp $HOME/.emulationstation/es_systems.cfg $HOME/RetroPie/retropiemenu/gamelist.xml; fi
CONTENT1="\t<system>\n\t\t  <name>"$1"-guns</name>\n\t\t  <fullname>"$1" Gun Games</fullname> \n\t\t  <path>/home/pi/RetroPie/roms/gun-games/"$1"</path> \n\t\t  <extension>.zip .ZIP</extension> \n\t\t<command>/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ m "$1"-guns %ROM%</command> \n\t\t  <platform>"$1"-guns</platform> \n\t\t  <theme>"$1"</theme> \n\t\t</system>"
C1=$(echo $CONTENT1 | sed 's/\//\\\//g')
if grep -q "$1" "$HOME/.emulationstation/es_systems.cfg"; then echo "es_systems.cfg entry confirmed"
else
	sed "/<\/system>/ s/.*/${C1}\n&/" $HOME/.emulationstation/es_systems.cfg > $HOME/temp
	cat $HOME/temp > $HOME/.emulationstation/es_systems.cfg
	rm -f $HOME/temp
fi
dialog  --sleep 1 --title "MAKE DIRECTORY & EDIT ES EXIT MESSAGE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/gun-games/"$1" 
- home/Pi/.emulationstation/es_systems.cfg has been edited
- Your configs for "$1" have been copied to guns config" 0 0
}

function retroarch-config() {
sudo wget retroarch---config--path -P coming---soon
}

function apply-all-gun() {
es-edit-gun 
retroarch-config
}

gun-menu

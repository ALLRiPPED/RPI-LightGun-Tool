#!/bin/bash
export NCURSES_NO_UTF8_ACS=1
BACKTITLE="<-----RPI LIGHTGUN SETUP MENU----->V1.0"

function gun-menu() {
local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "RPI LIGHTGUN SETUP MENU " \
      --ok-label Install --cancel-label Exit \
      --menu "WHAT KIND OF GUN DO YOU HAVE?" 40 60 40 \
      1 "DOLPHIN BAR + WII MOTE" \
      2 "GUN4IR" \
      3 "MOUSE INPUT GUN" \
      4 "SINDEN" \
       + "<                                     >" \
       + "<---RPI LIGHTGUN SETUP TOOLS --->" \
       + "<                                     >" \
      T1 "-SETUP INFO/HELP         " \   
      T2 "-UPDATE SETUP MENU       " \
      T3 "-UNINSTALL SETUP MENU    " \                
      2>&1 >/dev/tty)

    case "$choice" in
    1) mouse-gun  ;;
    2) mouse-gun  ;;
    3) mouse-gun ;;
    4) sinden-menu ;;
    T1) gun-help ;;
    T2) update-script ;;
    T3) remove-script ;;
    -) no ;;
     *) break ;;
    esac
   done
}

####------------------------MOUSE INPUT--------------------------------####

function mouse-gun() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "RPI MOUSE GUN SETUP MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO SETUP CONSOLE" 40 60 40 \
      1 "Arcade Setup" \
      2 "Atari800 Setup" \
      3 "Atari2600 Setup" \
      4 "NES Setup" \
      5 "SNES Setup" \
      6 "Mastersystem Setup" \               
      2>&1 >/dev/tty)

    case "$choice" in
    1) ra-gun "arcade"  ;;
    2) ra-gun "atari800"  ;;
    3) ra-gun "atari2600" ;;
    4) ra-gun "nes" ".7z" ".nes" ".zip" ".7Z" ".NES" ".ZIP" ;;
    5) ra-gun "snes"   ;;
    6) ra-gun "mastersystem" ;;
    -) no ;;
     *) break ;;
    esac
   done
}


function ra-gun() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title " "$1" STANDALONE SETUP MENU " \
      --ok-label Select --cancel-label Back \
      --menu "WHAT OPTIONS DO YOU WANT FOR  "$1"?" 40 60 40 \
      1 "COPY CONFIGS, MAKE DIRECTORIES " \
      2 "OPTION 1(ABOVE) & EDIT ES SYSTEMS  " \ 
      3 "DOWNLOAD & APPLY RETROARCH CONFIG " \
      4 "APPLY ALL " \
      2>&1 >/dev/tty)

    case "$choice" in
    1) copy-configs "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" ;;
    1) es-edit-gun "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" ;;
    2) retroarch-config  "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" ;;
    3) apply-all-gun  ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function sa-gun() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title " "$1" STANDALONE SETUP MENU " \
      --ok-label Select --cancel-label Back \
      --menu "WHAT OPTIONS DO YOU WANT FOR  "$1"?" 40 60 40 \
      1 "COPY CONFIGS, MAKE DIRECTORIES " \
      2 "OPTION 1(ABOVE) & EDIT ES SYSTEMS  " \ 
      3 "DOWNLOAD & APPLY RETROARCH CONFIG " \
      4 "APPLY ALL " \
      2>&1 >/dev/tty)

    case "$choice" in
    1) copy-configs "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" ;;
    1) es-edit-gun "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" ;;
    2) retroarch-config  "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8";;
    3) apply-all-gun  ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function copy-configs() {
sudo cp /opt/retropie/configs/"$1" -P /opt/retropie/configs/"$1"-gun
mkdir "$HOME"/RetroPie/roms/gun-games/"$1"
}


function es-edit-gun() {
sudo cp /opt/retropie/configs/"$1" -P /opt/retropie/configs/"$1"-gun
mkdir "$HOME"/RetroPie/roms/gun-games/"$1"
if [ ! -s "$HOME/.emulationstation/es_systems.cfg" ]; then sudo rm -f $HOME/.emulationstation/es_systems.cfg; fi
if [ ! -f "$HOME/.emulationstation/es_systems.cfg" ]; then cp $HOME/.emulationstation/es_systems.cfg $HOME/RetroPie/retropiemenu/gamelist.xml; fi
CONTENT1="\t<system>\n\t\t  <name>"$1"-guns</name>\n\t\t  <fullname>"$1" Gun Games</fullname> \n\t\t  <path>/home/pi/RetroPie/roms/gun-games/"$1"</path> \n\t\t  <extension>"$2" "$3" "$4" "$5" "$6" "$7" "$8"</extension> \n\t\t<command>/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ m "$1"-guns %ROM%</command> \n\t\t  <platform>"$1"</platform> \n\t\t  <theme>"$1"</theme> \n\t\t</system>"
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
if [ ! -s "opt/retropie/configs/"$1"-gun" ]; then sudo wget https://github.com/Retro-Devils/RPI-LightGun-Tool/blob/main/ra-configs/"$1"-gun/retroarch.cfg -P /opt/retropie/configs/"$1"-gun/
else
sudo cp /opt/retropie/configs/"$1" -P /opt/retropie/configs/"$1"-gun
sudo chmod -R 755 /opt/retropie/configs/"$1"-gun
sudo wget https://github.com/Retro-Devils/RPI-LightGun-Tool/blob/main/ra-configs/"$1"-gun/retroarch.cfg -P /opt/retropie/configs/"$1"-gun/
dialog  --sleep 1 --title "RETROARCH CONFIG EXIT MESSAGE" --msgbox "
- Your config folder for "$1" has been copied as "$1"-gun
- You will need to manually edit es-systems.cfg to reflect this 
OR go back and press Make Directory & Edit ES Systems" 0 0
}
fi
}

function apply-all-gun() {
es-edit-gun 
retroarch-config
}



####------------------------SINDEN--------------------------------####

function sinden-menu() {
sleep 2 
echo "working"
sleep 1
echo "on"
sleep 1
echo "it"
}


gun-menu

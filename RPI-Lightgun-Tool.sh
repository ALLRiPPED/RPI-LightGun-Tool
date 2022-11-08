#!/bin/bash
export NCURSES_NO_UTF8_ACS=1
BACKTITLE="<-----RPI LIGHTGUN TOOL -----><->Version<->1.00"

function gun-menu() {
local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "MAIN MENU" \
      --ok-label Select --cancel-label Exit \
      --menu "WHAT KIND OF GUN DO YOU HAVE?" 40 60 40 \
      1 "Dolphin/WII Mote" \
      2 "Gun4IR Lightgun" \
      3 "Mouse Input Gun" \
      4 "Sinden Lightgun" \
      T1 "---ABOUT  RPI-LG-TOOL---" \
      T2 "---REMOVE RPI-LG-TOOL---" \
      T3 "---UPDATE RPI-LG-TOOL---" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) dolphin-bar  ;;
    2) gun4ir  ;;
    3) mouse-gun ;;
    4) sinden-menu ;;
    T1) gun-help ;;
    T2) remove-script ;;
    T3) update-script ;;
     *) break ;;
    esac
   done
}

######----------------------SCRIPT TOOLS-------------------------------#####

function gun-help() {
echo "blah"
}


function remove-script() {
sudo rm $HOME/RetroPie/retropiemenu/RPI-Lightgun-Tool.sh
sudo rm /usr/local/bin/RPI-Lightgun-Tool
}

function update-script() {
if [ -f "$HOME/RetroPie/retropiemenu/RPI-Lightgun-Tool.sh" ]; then sudo rm $HOME/RetroPie/retropiemenu/RPI-Lightgun-Tool.sh; fi
if [ -f "/usr/local/bin/RPI-Lightgun-Tool" ]; then sudo rm /usr/local/bin/RPI-Lightgun-Tool; fi
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/RPI-Lightgun-Tool.sh -P $HOME/RetroPie/retropiemenu/
sleep 1
sudo cp $HOME/RetroPie/retropiemenu/RPI-Lightgun-Tool.sh -f /usr/local/bin/RPI-Lightgun-Tool
sleep 1
chmod 755 $HOME/RetroPie/retropiemenu/RPI-Lightgun-Tool.sh
sudo chmod 755 /usr/local/bin/RPI-Lightgun-Tool
}

####------------------------MOUSE INPUTS--------------------------------####

#---GUN4IR---#
function gun4ir() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "RPI GUN4IR SETUP MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO LOAD CONSOLE MENU" 40 60 40 \
      1 "Gun4IR Offical Firmware" \
      2 "Console Selection" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) offical-gun4ir ;;
    2) gun4ir-consoles  ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function offical-gun4ir() {
dialog  --sleep 1 --title "ATTENTION MESSAGE" --msgbox "
- This is a gui for windows not linux(retropie).
- You might be able to run through wine, untested thus far.
- To our knowledge you do NOT need it for pi." 0 0
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "RPI GUN4IR SETUP MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO SELECT" 40 60 40 \
      1 "Download Firmware and GUI" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) gun4ir-firm  ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function gun4ir-consoles() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "RPI GUN4IR CONSOLES MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO LOAD MENU/SETUP" 40 60 40 \
      1 "RA--Arcade Menu" \
      2 "RA--Atari800 Menu" \
      3 "RA--Atari2600 Menu" \
      4 "RA--NES Menu" \
      5 "RA--SNES Menu" \
      6 "RA--Mastersystem Menu" \
      7 "SA--Model 3 Setup " \
      2>&1 >/dev/tty)

    case "$choice" in
    1) ra-gun4ir "arcade"  ;;
    2) ra-gun4ir "atari800"  ;;
    3) ra-gun4ir "atari2600" ;;
    4) ra-gun4ir "nes" ".7z" ".nes" ".zip" ".7Z" ".NES" ".ZIP" ;;
    5) ra-gun4ir "snes"   ;;
    6) ra-gun4ir "mastersystem" ;;
    7) model3-gun ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function gun-firm() {
wget https://github.com/gobozgz/GUN4IR/archive/refs/tags/2.16.zip -P "$HOME"
unzip 2.16.zip
}

function ra-gun4ir() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title " "$1" RETROARCH SETUP MENU " \
      --ok-label Select --cancel-label Back \
      --menu "WHAT OPTIONS DO YOU WANT FOR  "$1" ?" 40 60 40 \
      1 "MAKE DIRECTORY FOR GUN GAMES" \
      2 "MAKE DIRECTORY & EDIT ES SYSTEMS  " \
      3 "DOWNLOAD & APPLY RETROARCH CONFIG " \
      4 "--APPLY ALL THE ABOVE--- " \
      - "-------------------------------------" \
      5 "UNDO RETROARCH CONFIGS FROM THIS SCRIPT" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) copy-configs "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" ;;
    1) es-edit-gun "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" ;;
    2) retroarch-config-gun4ir  "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" ;;
    3) apply-all-gun4ir  ;;
    -) no ;;
    5) undo-retroarch ;;
     *) break ;;
    esac
   done
}


function retroarch-config-gun4ir() {
if [ -d "opt/retropie/configs/$1" ]; then 
dialog  --sleep 1 --title "EMU MISSING" --msgbox "
- EMU FOR "$1" MISSING PLEASE INSTALL FIRST!!" 0 0
else
sudo mv /opt/retropie/configs/"$1"/retroarch.cfg -P /opt/retropie/configs/"$1"/retroarch-cfg.backup
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/"$1"-gun/retroarch.cfg -P /opt/retropie/configs/"$1"/
chmod 755 /opt/retropie/configs/"$1"/retroarch.cfg
dialog  --sleep 1 --title "RETROARCH CONFIG EXIT MESSAGE" --msgbox "
- Your config folder for "$1" has been copied as "$1"-gun
- You will need to manually edit es-systems.cfg to reflect this 
OR go back and press Make Directory & Edit ES Systems" 0 0
fi
}


function apply-all-gun4ir() {
es-edit-gun 
retroarch-config-gun4ir
}


#--Dolphin/Wii---#

function dolphin-bar() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "DOLPHIN BAR/WII MOTE MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO LOAD MENU/SETUP" 40 60 40 \
      1 "RA--Arcade Menu" \
      2 "RA--Atari800 Menu" \
      3 "RA--Atari2600 Menu" \
      4 "RA--NES Menu" \
      5 "RA--SNES Menu" \
      6 "RA--Mastersystem Menu" \
      7 "SA--Model 3 Setup " \
      2>&1 >/dev/tty)

    case "$choice" in
    1) ra-wii "arcade"  ;;
    2) ra-wii "atari800"  ;;
    3) ra-wii "atari2600" ;;
    4) ra-wii "nes" ".7z" ".nes" ".zip" ".7Z" ".NES" ".ZIP" ;;
    5) ra-wii "snes"   ;;
    6) ra-wii "mastersystem" ;;
    7) model3-gun ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function ra-wii() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title " "$1" RETROARCH SETUP MENU " \
      --ok-label Select --cancel-label Back \
      --menu "WHAT OPTIONS DO YOU WANT FOR  "$1" ?" 40 60 40 \
      1 "--MAKE DIRECTORY FOR GUN GAMES--" \
      2 "--MAKE DIRECTORY & EDIT ES SYSTEMS--" \
      3 "--DOWNLOAD & APPLY RETROARCH CONFIG--" \
      4 "--APPLY ALL THE ABOVE--- " \
      - "-------------------------------------" \
      5 "UNDO RETROARCH CONFIGS FROM THIS SCRIPT" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) copy-configs "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" ;;
    2) es-edit-gun "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" ;;
    3) ra-config-wii  "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" ;;
    4) apply-all-wii  ;;
    -) no ;;
    5) undo-retroarch ;;
     *) break ;;
    esac
   done
}



function ra-config-wii() {
if [ -d "opt/retropie/configs/$1 " ]; then 
dialog  --sleep 1 --title "EMU MISSING" --msgbox "
- EMU FOR "$1" MISSING PLEASE INSTALL FIRST!!" 0 0
else
sudo mv /opt/retropie/configs/"$1"/retroarch.cfg -P /opt/retropie/configs/"$1"/retroarch-cfg.backup
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gwii-mote/"$1"-gun/retroarch.cfg -P /opt/retropie/configs/"$1"/
chmod 755 /opt/retropie/configs/"$1"/retroarch.cfg
dialog  --sleep 1 --title "RETROARCH CONFIG EXIT MESSAGE" --msgbox "
- Your config folder for "$1" has been copied as "$1"-gun
- You will need to manually edit es-systems.cfg to reflect this 
OR go back and press Make Directory & Edit ES Systems" 0 0
fi
}


function apply-all-wii() {
es-edit-gun 
ra-config-wii
}


#----Mouse Gun---#

function mouse-gun() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "MOUSE GUN MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO LOAD MENU/SETUP" 40 60 40 \
      1 "RA--Arcade Menu" \
      2 "RA--Atari800 Menu" \
      3 "RA--Atari2600 Menu" \
      4 "RA--NES Menu" \
      5 "RA--SNES Menu" \
      6 "RA--Mastersystem Menu" \
      7 "SA--Model 3 Setup " \
      2>&1 >/dev/tty)

    case "$choice" in
    1) ra-gun-mouse "arcade"  ;;
    2) ra-gun-mouse "atari800"  ;;
    3) ra-gun-mouse "atari2600" ;;
    4) ra-gun-mouse "nes" ".7z" ".nes" ".zip" ".7Z" ".NES" ".ZIP" ;;
    5) ra-gun-mouse "snes"   ;;
    6) ra-gun-mouse "mastersystem" ;;
    7) model3-gun ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function ra-gun-mouse() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title " "$1" RETROARCH SETUP MENU " \
      --ok-label Select --cancel-label Back \
      --menu "WHAT OPTIONS DO YOU WANT FOR  "$1" ?" 40 60 40 \
      1 "MAKE DIRECTORY FOR GUN GAMES " \
      2 "MAKE DIRECTORY & EDIT ES SYSTEMS  " \
      3 "DOWNLOAD & APPLY RETROARCH CONFIG " \
      4 "--APPLY ALL THE ABOVE--- " \
      - "-------------------------------------" \
      5 "UNDO RETROARCH CONFIGS FROM THIS SCRIPT" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) copy-configs "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" ;;
    2) es-edit-gun "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" ;;
    3) retroarch-config-mouse  "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" ;;
    4) apply-all-mouse  ;;
    -) no ;;
    5) undo-retroarch ;;
     *) break ;;
    esac
   done
}


function retroarch-config-mouse() {
if [ -d "opt/retropie/configs/$1" ]; then 
dialog  --sleep 1 --title "EMU MISSING" --msgbox "
- EMU FOR "$1" MISSING PLEASE INSTALL FIRST!!" 0 0
else
sudo mv /opt/retropie/configs/"$1"/retroarch.cfg -P /opt/retropie/configs/"$1"/retroarch-cfg.backup
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/mouse-gun/"$1"-gun/retroarch.cfg -P /opt/retropie/configs/"$1"/
chmod 755 /opt/retropie/configs/"$1"/retroarch.cfg
dialog  --sleep 1 --title "RETROARCH CONFIG EXIT MESSAGE" --msgbox "
- Your config folder for "$1" has been copied as "$1"-gun
- You will need to manually edit es-systems.cfg to reflect this 
OR go back and press Make Directory & Edit ES Systems" 0 0
fi
}



function apply-all-mouse() {
es-edit-gun "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8"
retroarch-config-mouse "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8"
}


function undo-retroarch() {
if [ ! -f "/opt/retropie/configs/"$1"/retroarch-cfg.backup" ]; then 
dialog  --sleep 1 --title "ERROR ERROR" --msgbox "
- RPI LIGHTGUN TOOL HASNT TOUCHED THIS SYSTEM
- IT CANNOT UNDO WHAT IT DIDNT DO LOL
- EXITING NOW" 0 0
else
sudo rm /opt/retropie/configs/"$1"/retroarch.cfg
sudo mv /opt/retropie/configs/"$1"/retroarch-cfg.backup -P /opt/retropie/configs/"$1"/retroarch.cfg
fi
}

####------------Multi guns--------------------####

function es-edit-gun() {
mkdir "$HOME"/RetroPie/roms/gun-games/"$1"
if [ ! -s "$HOME/.emulationstation/es_systems.cfg" ]; then sudo rm -f $HOME/.emulationstation/es_systems.cfg; fi
if [ ! -f "$HOME/.emulationstation/es_systems.cfg" ]; then sudo cp /etc/emulationstation/es_systems.cfg $HOME/.emulationstation/es_systems.cfg; sudo chown pi:pi $HOME/.emulationstation/es_systems.cfg; fi
CONTENT1="\t<system>\n\t\t  <name>"$1"-guns</name>\n\t\t  <fullname>"$1" Gun Games</fullname> \n\t\t  <path>/home/pi/RetroPie/roms/gun-games/"$1"</path> \n\t\t  <extension>"$2" "$3" "$4" "$5" "$6" "$7" "$8"</extension> \n\t\t<command>/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ m "$1" %ROM%</command> \n\t\t  <platform>"$1"</platform> \n\t\t  <theme>"$1"</theme> \n\t\t</system>"
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
- Your configs for "$1" have been backed up" 0 0
}


function copy-configs() {
if [ ! -d "$HOME/retropie/roms/gun-games/$1" ]; then mkdir "$HOME"/RetroPie/roms/gun-games/"$1"
else
dialog  --sleep 1 --title "MAKE DIRECTORY ERROR" --msgbox "
- DIRECTORY ALREADY EXSITS 
- CANNOT CREATE DIRECTORY" 0 0
fi
}


####------------------------SINDEN--------------------------------####

function sinden-menu() {
dialog  --sleep 1 --title "CREDITS" --msgbox "
- ALL CREDIT GOES TO 
https://github.com/SindenLightgun/SindenLightgunLinux
- WE JUST ADDED THOSE SCRIPTS IN UI" 0 0
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "SINDEN SETUP MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PLEASE SELECT A OPTION" 40 60 40 \
      1 "INSTALL SINDEN DRIVERS " \
      2 "CONFIGURE SINDEN GUN" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) sinden-install ;;
    2) sinden-config ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function sinden-config() {
if [ ! -d "$HOME/SindenLightgunLinux" ]; then
dialog  --sleep 1 --title "MISSING SINDEN DRIVERS" --msgbox "
- SINDEN DRIVERS/SOFTWARE NOT INSTALLED
- CANT CREATE GUN CONFIG WITHOUT DRIVERS 
- EXTING " 0 0
else
cd /home/pi/SindenLightgunLinux; \
chmod 755 *.sh; \
./setup-lightgun.sh; \
./setup-retropie.sh; \
fi
}


function sinden-install() {
if [ ! -d "$HOME/SindenLightgunLinux" ]; then
cd /home/pi; \
git clone https://github.com/SindenLightgun/SindenLightgunLinux.git; \
cd SindenLightgunLinux; \
echo ""; \
VERSION=$(git symbolic-ref --short -q HEAD); echo "Current Version ${VERSION}"
else
cd /home/pi/SindenLightgunLinux
git pull
fi
}

###------------------STANDALONES-----------------###

function model3-gun() {
if [ ! -d "opt/retropie/configs/model3" ]; then
dialog  --sleep 1 --title "MISSING EMU ERROR" --msgbox "
- SUPER MODEL 3 IS NOT INSTALLED 
- CANT CREATE GUN CONFIG WITHOUT EMU 
- EXTING " 0 0
else
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/sa-configs/all/model3-gun/supermodel.ini -P
fi
}




gun-menu

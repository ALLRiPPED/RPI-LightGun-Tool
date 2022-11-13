#!/bin/bash
export NCURSES_NO_UTF8_ACS=1
BACKTITLE="<-----RPI LIGHTGUN TOOL -----><->Version<->1.01"

function gun-menu() {
local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "MAIN MENU" \
      --ok-label Select --cancel-label Exit \
      --menu "WHAT KIND OF GUN DO YOU HAVE?" 40 60 40 \
      1 "Dolphin/WII Mote" \
      2 "Gun4IR Lightgun" \
      3 "General Mouse Gun Input" \
      4 "Sinden Lightgun" \
      T1 "---ABOUT  RPI-LG-TOOL---" \
      T2 "---REMOVE RPI-LG-TOOL---" \
      T3 "---UPDATE RPI-LG-TOOL---" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) dolphin-bar  ;;
    2) soon  ;;
    3) soon ;;
    4) sinden-menu ;;
    T1) gun-help ;;
    T2) remove-script ;;
    T3) update-script ;;
     *) break ;;
    esac
   done
}

function soon() {
dialog  --sleep 1 --title "ATTENTION MESSAGE" --msgbox "
COMING SOON TO MY FRIEND
APPRECIATE THE WAIT" 0 0 
}

######----------------------SCRIPT TOOLS-------------------------------#####

function gun-help() {
dialog  --sleep 1 --title "---START HELP---" --msgbox "

___________BASIC INSTRUCTIONS__________
- PICK YOUR GUN TYPE
- ALL GUN TYPES WILL LOAD A SUB MENU
- MOST SUB MENUS WILL BE A SYSTEMS LIST
- PRESS A/ENTER TO CONFIGURE SYSTEM

I DONT LIKE THIS . HOW DO I UNDO IT?
- GO BACK TO GUN TYPE SUBMENU
- CLICK -----UNDO MENU----
- SELECT SYSTEM TO UNDO" 0 0
dialog  --sleep 1 --title "---FAQ---" --msgbox "
- WHERE DO I PUT GAMES?
----PLACE YOUR GAMES IN .../roms/systemname/gun-games/
- WHY DONT GAMES I ADDED SHOW?
----MAKE SURE RETROPIE CAN SEE FOLDERS.
- WHY DIDNT GUN WORK IN GAME?
----MAKE SURE TO SELECT systemname-gun AS EMU. " 0 0
dialog  --sleep 1 --title "---CREDITS---" --msgbox "
ALL CREDITS TO CREATOR OF POKITTO EMU
felipemanga

HIS GITHUB IS HERE 
https://github.com/felipemanga/PokittoEmu

WE SIMPLY AUTOMATED/PORTED IT TO RETROPIE" 0 0
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

#---------------------------------------------------------------GUN4IR---------------------------------------------------------------#
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
if [ -d "opt/retropie/configs/"$1" " ]; then 
dialog  --sleep 1 --title "EMU MISSING" --msgbox "
- EMU FOR "$1" MISSING PLEASE INSTALL FIRST!!" 0 0
else
sudo mv /opt/retropie/configs/"$1"/retroarch.cfg /opt/retropie/configs/"$1"/retroarch-cfg.backup
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/"$1"-gun/retroarch.cfg -P /opt/retropie/configs/"$1"/
chmod 755 /opt/retropie/configs/"$1"/retroarch.cfg
dialog  --sleep 1 --title "RETROARCH CONFIG EXIT MESSAGE" --msgbox "
- Your retroarch config for "$1" has been backed up as retroarch-cfg.backup
- You will need to manually edit es-systems.cfg for gun system
OR go back and press Make Directory & Edit ES Systems" 0 0
fi
}


function apply-all-gun4ir() {
es-edit-gun 
retroarch-config-gun4ir
}


#--------------------------------------------------------------Dolphin/Wii-----------------------------------------------------------------------------------------------------#

function dolphin-bar() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "DOLPHIN BAR/WII MOTE MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO SETUP" 40 60 40 \
      1 "Apply NES Gun Config" \
      2 "Apply Model 3 Gun Config" \
      3 "-----UNDO MENU-----" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) ra-wii-config "nes" "lr-fceumm" "fceumm_libretro" ;;
    2) model3-gun ;;
    3) dolphin-bar-undo ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function dolphin-bar-undo() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "WII MOTE UNDO MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO UNDO" 40 60 40 \
      1 "Undo NES Gun Config" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) undo-retroarch "nes" ;;
    -) no ;;
     *) break ;;
    esac
   done
}


function ra-wii-config() {
if [ ! -d "/opt/retropie/configs/$1" ]; then emu-error; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/"$1"-gun/retroarch-gun.cfg -P /opt/retropie/configs/"$1"/
sudo chmod 755 /opt/retropie/configs/"$1"/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/$1/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/$1/gun-games/"; fi
sudo cp /opt/retropie/configs/"$1"/emulators.cfg /opt/retropie/configs/"$1"/emulators-cfg.backup
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/"$1"-gun/emulators.cfg -P /opt/retropie/configs/"$1"/
if [ ! -f "/opt/retropie/configs/"$1"/emulators.cfg.bak" ] ; then
sudo sed -i  .bak '"$1-gun = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/$2/$3.so --config /opt/retropie/configs/$1/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/"$1"/emulators.cfg
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/"$1"/gun-games/ 
- A new emu called "$1"-gun was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO "$1"-GUN" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
}

#--------------------------------------------------------------Mouse/Key-------------------------------------------------------------------------------------------------------#

function mouse-gun() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "MOUSE GUN INPUT MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO SETUP" 40 60 40 \
      1 "Apply NES Gun Config" \
      2 "Apply Model 3 Gun Config" \
      3 "-----UNDO MENU-----" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) ra-mouse-config "nes" ".7z" ".nes" ".zip" ".7Z" ".NES" ".ZIP" ;;
    2) model3-gun ;;
    3) mouse-gun-undo ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function mouse-gun-undo() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "MOUSE INPUT GUN UNDO MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO UNDO" 40 60 40 \
      1 "Undo NES Gun Config" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) undo-retroarch "nes" ;;
    -) no ;;
     *) break ;;
    esac
   done
}


function ra-mouse-config() {
if [ ! -d "/opt/retropie/configs/$1" ]; then emu-error; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/mouse-gun/"$1"-gun/retroarch-gun.cfg -P /opt/retropie/configs/"$1"/
sudo chmod 755 /opt/retropie/configs/"$1"/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/"$1"/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/"$1"/gun-games/"; fi
sudo cp /opt/retropie/configs/"$1"/emulators.cfg /opt/retropie/configs/"$1"/emulators-cfg.backup
if grep -q '$1-gun' "/opt/retropie/configs/$1/emulators.cfg"; then
   sudo sed -i '$1-gun = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/$2/$3.so --config /opt/retropie/configs/$1/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/"$1"/emulators.cfg
  fi
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/"$1"/gun-games/ 
- A new emu called "$1"-gun was added to retropie
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO "$1"-GUN" 0 0
}



####------------Multi guns--------------------####

function undo-retroarch() {
if [ ! -f "/opt/retropie/configs/"$1"/retroarch-gun.cfg" ]; then 
dialog  --sleep 1 --title "ERROR ERROR" --msgbox "
- RPI LIGHTGUN TOOL HASNT TOUCHED THIS SYSTEM
- IT CANNOT UNDO WHAT IT DIDNT DO LOL
- EXITING NOW" 0 0
else
sudo rm /opt/retropie/configs/"$1"/emulators.cfg
sudo mv /opt/retropie/configs/"$1"/emulators-cfg.backup /opt/retropie/configs/"$1"/emulators.cfg
sudo rm /opt/retropie/configs/"$1"/retroarch-gun.cfg
sudo rm /opt/retropie/configs/"$1"/emulators.cfg.bak.cfg
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

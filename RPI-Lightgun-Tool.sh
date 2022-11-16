#!/bin/bash
export NCURSES_NO_UTF8_ACS=1
BACKTITLE="<-----RPI LIGHTGUN TOOL -----><->Version<->1.01"

function gun-menu() {
local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "MAIN MENU" \
      --ok-label Select --cancel-label Exit \
      --menu "WHAT KIND OF GUN DO YOU HAVE?" 40 60 40 \
      1 "AE Lightgun" \
      2 "AimTrack lightgun" \
      3 "Dolphin/WII Mote" \
      4 "Gun4IR Lightgun" \
      5 "Infared Mouse Gun" \
      6 "Sinden Lightgun" \
      - "------------------------" \
      T1 "---ABOUT  RPI-LG-TOOL---" \
      T2 "---REMOVE RPI-LG-TOOL---" \
      T3 "---UPDATE RPI-LG-TOOL---" \
      oo "------------------------" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) soon ;;
    2) aimtrack ;;
    3) dolphin-bar  ;;
    4) soon  ;;
    5) soon ;;
    6) sinden-menu ;;
    T1) gun-help ;;
    T2) remove-script ;;
    T3) update-script ;;
    oo) secret-menu ;;
     -) no ;;
     *) break ;;
    esac
   done
}

######--------------------------------------------------------TEMPORARY----------------------------------------------------------------------------------#####

function soon() {
dialog  --sleep 1 --title "ATTENTION MESSAGE" --msgbox "
COMING SOON TO MY FRIEND
APPRECIATE THE WAIT" 0 0 
}

######--------------------------------------------------------SCRIPT TOOLS----------------------------------------------------------------------------------#####

function gun-help() {
dialog  --sleep 1 --title "---RPI LIGHTGUN TOOL HELP---" --msgbox "

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
}

function remove-script() {
sudo rm $HOME/RetroPie/retropiemenu/RPI-Lightgun-Tool.sh
sudo rm /usr/local/bin/RPI-Lightgun-Tool
}

function update-script() {
if [ -f "$HOME/RetroPie/retropiemenu/RPI-Lightgun-Tool.sh" ]; then sudo rm $HOME/RetroPie/retropiemenu/RPI-Lightgun-Tool.sh; fi
if [ -f "/usr/local/bin/RPI-Lightgun-Tool" ]; then sudo rm /usr/local/bin/RPI-Lightgun-Tool; fi
if [ ! -d "/$HOME/Lightgun-Tool/" ]; then mkdir /$HOME/Lightgun-Tool/; fi
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/RPI-Lightgun-Tool.sh -P $HOME/RetroPie/retropiemenu/
wget        WII LAYOUT PICS 
wget        SETUP VIDEO 
wget        IR MOUSE AND KEYBOARD PICs
sleep 1
sudo cp $HOME/RetroPie/retropiemenu/RPI-Lightgun-Tool.sh -f /usr/local/bin/RPI-Lightgun-Tool
sleep 1
chmod 755 $HOME/RetroPie/retropiemenu/RPI-Lightgun-Tool.sh
sudo chmod 755 /usr/local/bin/RPI-Lightgun-Tool
}

#--------------------------------------------------------------AIMTRACK---------------------------------------------------------------------------------------#
function aimtrack() {
dialog  --sleep 1 --title "AIMTRACK MESSAGE" --msgbox "
- UNFORTUNATELY MOST SAY AIMTRACK DOESNT WORK ON PI
- AIMTRACK IS UNTESTED ON PI TO OUR KNOWLEDGE
- WE DO NOT HAVE ANYWAY OF CONFIGURING IT
- SORRY FOR TROUBLE
- PLEASE REPORT TO DEVILS IF YOU HAVE TESTED" 0 0
}


#--------------------------------------------------------------AE LIGHTGUN---------------------------------------------------------------------------------------#

#---------------------------------------------------------------GUN4IR---------------------------------------------------------------#
function ae-lightgun() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "AE LIGHTGUN MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO SETUP" 40 60 40 \
      1 "Apply NES Gun Config" \
      2 "Apply Model 3 Gun Config" \
      3 "--Offical Scripts--" \
      4 "-----UNDO MENU-----" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) nes-ae ;;
    2) model3 ;;
    3) offical-ae ;;
    4) ae-undo ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function offical-ae() {
dialog  --sleep 1 --title "ATTENTION MESSAGE" --msgbox "
- This is a gui for windows not linux(retropie).
- You might be able to run through wine, untested thus far.
- To our knowledge you do NOT need it for pi." 0 0
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "RPI AELIGHT SETUP MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO SELECT" 40 60 40 \
      1 "Download Firmware" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) ae-firm  ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function ae-firm() {
scho "SOON"
}

function ae-undo() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "AE LIGHTGUN UNDO MENU " \
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


#--------------------------------------------------------------DOLPHIN BAR---------------------------------------------------------------------------------------#

function dolphin-bar() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "DOLPHIN BAR/WII MOTE MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO SETUP" 40 60 40 \
      1 "Apply Dreamcast Gun Config" \
      2 "Apply Genesis Gun Config" \
      3 "Apply NES Gun Config" \
      4 "Apply Masterystem Gun Config" \
      5 "Apply Model 3 Gun Config" \
      6 "Apply SNES Gun Config" \
      U "-----UNDO MENU-----" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) dreamcast-wii ;;
    2) genesis-wii ;;
    3) nes-wii ;;
    4) mastersystem-wii ;;
    5) model3 ;;
    6) snes-wii ;;
    U) dolphin-bar-undo ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function arcade-wii() {
if [ ! -d "/opt/retropie/configs/arcade" ]; then emu-error; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-flycast.sh" ]; then sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/scriptmodules/multi-input/libretrocores/lr-flycast.sh  -P $HOME/RetroPie-Setup/scriptmodules/libretrocores/; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-mame-StormedBubbles.sh" ]; then sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/scriptmodules/sinden/libretrocores/lr-mame-StormedBubbles.sh -P $HOME/RetroPie-Setup/scriptmodules/libretrocores/; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-mame2015-StormedBubbles.sh" ]; then sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/scriptmodules/sinden/libretrocores/lr-mame2015-StormedBubbles.sh -P $HOME/RetroPie-Setup/scriptmodules/libretrocores/; fi
]cd $HOME/RetroPie-Setup
sudo ./retropie_packages.sh lr-mame-StormedBubbles
sudo ./retropie_packages.sh lr-mame2015-StormedBubbles
sudo ./retropie_packages.sh lr-flycast
sudo ./retropie_packages.sh lr-mame2003plus
sudo ./retropie_packages.sh lr-mame2003
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/arcade/retroarch-gun-2003plus.cfg -P /opt/retropie/configs/arcade/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/arcade/retroarch-gun-2003.cfg -P /opt/retropie/configs/arcade/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/arcade/retroarch-gun-2016.cfg -P /opt/retropie/configs/arcade/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/arcade/retroarch-gun-stormbubb.cfg -P /opt/retropie/configs/arcade/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/arcade/retroarch-gun-2015stormbubb.cfg -P /opt/retropie/configs/arcade/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/arcade/retroarch-gun-flycast.cfg -P /opt/retropie/configs/arcade/
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-2003+.cfg
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-2003.cfg
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-2016.cfg
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-stormbubb.cfg
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-2015stormbubb.cfg
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-flycast.cfg
if [ ! -d "$HOME/RetroPie/roms/mastersytem/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/arcade/gun-games/"; fi
sudo cp /opt/retropie/configs/mastersytem/emulators.cfg /opt/retropie/configs/arcade/emulators-cfg.backup
if [ ! -f "/opt/retropie/configs/arcade/confirm-gun" ] ; then
sed -i '/default/a lightgun-2003+ = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-mame2003-plus/mame2003_plus_libretro.so --config /opt/retropie/configs/arcade/retroarch-gun-2003+.cfg %ROM%"' /opt/retropie/configs/arcade/emulators.cfg
sleep 1
sed -i '/lightgun-2003+/a lightgun-2003 = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-mame2003/mame2003_libretro.so --config /opt/retropie/configs/arcade/retroarch.cfg %ROM%"' /opt/retropie/configs/arcade/emulators.cfg
sleep 1
sed -i '/lightgun-2003/a lightgun-2016 = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-mame2016/mamearcade2016_libretro.so --config /opt/retropie/configs/arcade/retroarch.cfg %ROM%"' /opt/retropie/configs/arcade/emulators.cfg
sleep 1
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/confirm-gun -P /opt/retropie/configs/arcade
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/arcade/gun-games/ 
- New emus called lightgun-2003, lightgun-2003+, lightgun 2016 were added to emulators.cfg
- PLEASE SELECT MAME VERSION YOU NEED FOR ROM WHEN LAUNCHING GAME
- lightgun-2003 is LR MAME 2003, lightgun-2003+ is LR MAME 2003plus etc." 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
dolphin-layout
}

function dreamcast-wii() {
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-flycast.sh" ]; then sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/scriptmodules/multi-input/libretrocores/lr-flycast.sh  -P $HOME/RetroPie-Setup/scriptmodules/libretrocores/; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-flyinghead.sh" ]; then sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/scriptmodules/sinden/libretrocores/lr-flycast-flyinghead.sh -P $HOME/RetroPie-Setup/scriptmodules/libretrocores/; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-flycast-mazan.sh" ]; then sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/scriptmodules/sinden/libretrocores/lr-flycast-mazan.sh -P $HOME/RetroPie-Setup/scriptmodules/libretrocores/; fi
cd $HOME/RetroPie-Setup
sudo ./retropie_packages.sh lr-flycast
sudo ./retropie_packages.sh lr-flycast-mazan
sudo ./retropie_packages.sh lr-flycast-flyinghead
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/dreamcast/retroarch-gun-flycast.cfg -P /opt/retropie/configs/dreamcast/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/dreamcast/retroarch-gun-mazan.cfg -P /opt/retropie/configs/dreamcast/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/dreamcast/retroarch-gun-flyinghead.cfg -P /opt/retropie/configs/dreamcast/
sudo chmod 777 /opt/retropie/configs/dreamcast/retroarch-gun-flycast.cfg
sudo chmod 777 /opt/retropie/configs/dreamcast/retroarch-gun-mazan.cfg
sudo chmod 777 /opt/retropie/configs/dreamcast/retroarch-gun-flyinghead.cfg
if [ ! -d "$HOME/RetroPie/roms/mastersytem/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/dreamcast/gun-games/"; fi
sudo cp /opt/retropie/configs/mastersytem/emulators.cfg /opt/retropie/configs/dreamcast/emulators-cfg.backup
if [ ! -f "/opt/retropie/configs/dreamcast/confirm-gun" ] ; then
sed -i '/default/a lightgun-flycast = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-flycast/flycast_libretro.so </dev/null --config /opt/retropie/configs/dreamcast/retroarch.cfg %ROM%"' /opt/retropie/configs/dreamcast/emulators.cfg
sleep 1
sed -i '/gun-flycast/a lightgun-mazan = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-flycast-mazan/flycast_libretro.so </dev/null --config /opt/retropie/configs/dreamcast/retroarch.cfg %ROM%"' /opt/retropie/configs/dreamcast/emulators.cfg
sleep 1
sed -i '/gun-mazan/a lightgun-flyinghead = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-flycast-flyinghead/flycast_libretro.so </dev/null --config /opt/retropie/configs/dreamcast/retroarch.cfg %ROM%"' /opt/retropie/configs/dreamcast/emulators.cfg
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/confirm-gun -P /opt/retropie/configs/dreamcast
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/arcade/gun-games/ 
- New emus called lightgun-flycast, lightgun-mazan,and lightgun-flyinghead were added to emulators.cfg
- lightgun-flycast is LR FLYCAST, lightgun-mazan is LR FLYCAST-MAZAN etc.
- Most games you can use lightgun-flycast 
- For Virtua Cop 2 and Ninja (Naomi) you will need to use Mazan or Flyinghead" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
dolphin-layout
}

function genesis-wii() {
if [ ! -d "/opt/retropie/configs/genesis" ]; then emu-error; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/genesis/retroarch-gun.cfg -P /opt/retropie/configs/genesis/
sudo chmod 777 /opt/retropie/configs/genesis/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/genesis/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/genesis/gun-games/"; fi
sudo cp /opt/retropie/configs/genesis/emulators.cfg /opt/retropie/configs/genesis/emulators-cfg.backup
if [ ! -f "/opt/retropie/configs/genesis/confirm-gun" ] ; then
sed -i '/default/a lightgun-genesis = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-genesis-plus-gx/genesis_plus_gx_libretro.so --config /opt/retropie/configs/genesis/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/genesis/emulators.cfg
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/confirm-gun -P /opt/retropie/configs/genesis/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/genesis/gun-games/ 
- A new emu called lightgun-genesis was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-genesis" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
dolphin-layout
}

function nes-wii() {
if [ ! -d "/opt/retropie/configs/nes" ]; then emu-error; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/nes/retroarch-gun.cfg -P /opt/retropie/configs/nes/
sudo chmod 777 /opt/retropie/configs/nes/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/nes/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/nes/gun-games/"; fi
sudo cp /opt/retropie/configs/nes/emulators.cfg /opt/retropie/configs/nes/emulators-cfg.backup
if [ ! -f "/opt/retropie/configs/nes/confirm-gun" ] ; then
sed -i '/default/a lightgun-nes = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-fceumm/fceumm_libretro.so --config /opt/retropie/configs/nes/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/nes/emulators.cfg
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/confirm-gun -P /opt/retropie/configs/nes
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/nes/gun-games/ 
- A new emu called lightgun-nes was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-nes" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
dolhin-layout
}

function mastersystem-wii() {
if [ ! -d "/opt/retropie/configs/mastersystem" ]; then emu-error; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/mastersystem/retroarch-gun.cfg -P /opt/retropie/configs/mastersystem/
sudo chmod 777 /opt/retropie/configs/mastersystem/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/mastersytem/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/mastersystem/gun-games/"; fi
sudo cp /opt/retropie/configs/mastersytem/emulators.cfg /opt/retropie/configs/mastersystem/emulators-cfg.backup
if [ ! -f "/opt/retropie/configs/mastersystem/confirm-gun" ] ; then
sed -i '/default/a lightgun-mastersystem = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-genesis-plus-gx/genesis_plus_gx_libretro.so --config /opt/retropie/configs/mastersystem/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/mastersystem/emulators.cfg
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/confirm-gun -P /opt/retropie/configs/mastersystem
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/mastersystem/gun-games/ 
- A new emu called lightgun-mastersystem was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-mastersystem" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
dolhin-layout
}


function ps1-wii() {
if [ ! -d "/opt/retropie/configs/psx" ]; then emu-error; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-pcsx-rearmed.sh" ]; then sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/scriptmodules/multi-input/libretrocores/lr-pcsx-rearmed.sh  -P $HOME/RetroPie-Setup/scriptmodules/libretrocores/; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-duckstation.sh" ]; then sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/scriptmodules/multi-input/libretrocores/lr-swanstation.sh  -P $HOME/RetroPie-Setup/scriptmodules/libretrocores/; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-swanstation.sh" ]; then sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/scriptmodules/multi-input/libretrocores/lr-duckstation.sh  -P $HOME/RetroPie-Setup/scriptmodules/libretrocores/; fi
cd $HOME/RetroPie-Setup
sudo ./retropie_packages.sh lr-pcsx-rearmed
sudo ./retropie_packages.sh lr-duckstation
sudo ./retropie_packages.sh lr-swanstation
sleep 1
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/psx/retroarch-gun-duck.cfg -P /opt/retropie/configs/psx/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/psx/retroarch-gun-swan.cfg -P /opt/retropie/configs/psx/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/psx/retroarch-gun-rearmed.cfg -P /opt/retropie/configs/psx/
sudo chmod 777 /opt/retropie/configs/psx/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/psx/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/psx/gun-games/"; fi
sudo cp /opt/retropie/configs/psx/emulators.cfg /opt/retropie/configs/psx/emulators-cfg.backup
if [ ! -f "/opt/retropie/configs/psx/confirm-gun" ] ; then
sed -i '/default/a lightgun-pcsx = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-pcsx-rearmed/pcsx_rearmed_libretro.so --config /opt/retropie/configs/psx/retroarch-gun-pcsx.cfg %ROM%"' /opt/retropie/configs/psx/emulators.cfg
sleep 1
sed -i '/default/a lightgun-duck = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-duckstation/duckstation_libretro.so </dev/null --config /opt/retropie/configs/psx/retroarch-duck.cfg %ROM%"' /opt/retropie/configs/psx/emulators.cfg
sleep 1
sed -i '/default/a lightgun-swan = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-swanstation/swanstation_libretro.so --config /opt/retropie/configs/psx/retroarch.cfg %ROM%"' /opt/retropie/configs/psx/emulators.cfg
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/confirm-gun -P /opt/retropie/configs/psx
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/psx/gun-games/ 
- A new emu called lightgun-psx was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-psx" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
dolphin-layout
}

function segacd-wii() {
if [ ! -d "/opt/retropie/configs/segacd" ]; then emu-error; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/segacd/retroarch-gun.cfg -P /opt/retropie/configs/segacd/
sudo chmod 777 /opt/retropie/configs/segacd/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/segacd/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/segacd/gun-games/"; fi
sudo cp /opt/retropie/configs/mastersytem/emulators.cfg /opt/retropie/configs/segacd/emulators-cfg.backup
if [ ! -f "/opt/retropie/configs/segacd/confirm-gun" ] ; then
sed -i '/default/a lightgun-segacd = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-segacd-plus-gx/genesis_plus_gx_libretro.so --config /opt/retropie/configs/genesis/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/lightgun-segacd/emulators.cfg
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/confirm-gun -P /opt/retropie/configs/segacd
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/segacd/gun-games/ 
- A new emu called lightgun-segacd was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-segacd" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
dolphin-layout
}


function snes-wii() {
if [ ! -d "/opt/retropie/configs/snes" ]; then emu-error; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/snes/retroarch-gun.cfg -P /opt/retropie/configs/snes/
sudo chmod 777 /opt/retropie/configs/snes/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/snes/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/snes/gun-games/"; fi
sudo cp /opt/retropie/configs/snes/emulators.cfg /opt/retropie/configs/snes/emulators-cfg.backup
if [ ! -f "/opt/retropie/configs/snes/confirm-gun" ] ; then
sed -i '/default/a lightgun-snes = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-snes9x/snes9x_libretro.so --config /opt/retropie/configs/snes/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/snes/emulators.cfg
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/confirm-gun -P /opt/retropie/configs/snes
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/snes/gun-games/ 
- A new emu called lightgun-snes was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO light-snes" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
dolphin-layout
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

function dolphin-layout() {
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

#---------------------------------------------------------------GUN4IR---------------------------------------------------------------#
function gun4ir() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "GUN4IR LIGHTGUN MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO SETUP" 40 60 40 \
      1 "Apply NES Gun Config" \
      2 "Apply Model 3 Gun Config" \
      3 "--Offical Scripts--" \
      4 "-----UNDO MENU-----" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) nes-gun4ir ;;
    2) model3 ;;
    3) offical-gun4ir ;;
    4) gun4ir-undo ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function offical-gun4ir() {
dialog  --sleep 1 --title "ATTENTION MESSAGE" --msgbox "
- This is a gui for windows not linux(retropie).
- Parts might work, unlikely though .
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

function gun-firm() {
wget https://github.com/gobozgz/GUN4IR/archive/refs/tags/2.16.zip -P "$HOME"
unzip "$HOME"/gun4ir-2.16.zip
rm "$HOME"/gun4ir-2.16.zip
dialog  --sleep 1 --title "EXIT MESSAGE" --msgbox "
- GUN4IR software downloaded to home/pi/GUN4IR-2.16" 0 0
}

function gun4ir-undo() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "GUN4IR UNDO MENU " \
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


#--------------------------------------------------------------IR MOUSE GUN-------------------------------------------------------------------------------------------------------#

function mouse-gun() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "IR MOUSE GUN MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO SETUP" 40 60 40 \
      1 "Apply NES Gun Config" \
      2 "Apply Model 3 Gun Config" \
      3 "-----UNDO MENU-----" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) nes-mouse ;;
    2) model3 ;;
    3) mouse-undo ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function nes-mouse() {
if [ ! -d "/opt/retropie/configs/nes" ]; then emu-error; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/mouse-input/nes/retroarch-gun.cfg -P /opt/retropie/configs/nes/
sudo chmod 755 /opt/retropie/configs/nes/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/nes/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/nes/gun-games/"; fi
sudo cp /opt/retropie/configs/nes/emulators.cfg /opt/retropie/configs/nes/emulators-cfg.backup
#sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/mouse-input/nes/emulators.cfg -P /opt/retropie/configs/nes/
if [ ! -f "/opt/retropie/configs/nes/confirm-gun" ] ; then
sed -i '/default/a "nes-gun = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-fceumm/fceumm_libretro.so --config /opt/retropie/configs/nes/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/nes/emulators.cfg
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/confirm-gun -P /opt/retropie/configs/nes
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/nes/gun-games/ 
- A new emu called nes-gun was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO nes-gun" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
}

function snes-mouse() {
if [ ! -d "/opt/retropie/configs/snes" ]; then emu-error; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/mouse-input/snes/retroarch-gun.cfg -P /opt/retropie/configs/snes/
sudo chmod 755 /opt/retropie/configs/snes/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/snes/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/snes/gun-games/"; fi
sudo cp /opt/retropie/configs/snes/emulators.cfg /opt/retropie/configs/snes/emulators-cfg.backup
#sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/mouse-input/snes/emulators.cfg -P /opt/retropie/configs/snes/
if [ ! -f "/opt/retropie/configs/snes/confirm-gun" ] ; then
sed -i '/default/a "snes-gun = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-snes9x/snes9x_libretro.so --config /opt/retropie/configs/snes/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/snes/emulators.cfg
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/confirm-gun -P /opt/retropie/configs/snes
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/snes/gun-games/ 
- A new emu called snes-gun was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO snes-gun" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
}

function mouse-undo() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "IR MOUSE UNDO MENU " \
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



####--------------------------------------------------------------------------------MULTI INPUT-----------------------------------------------------------------------####

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

function emu-error() {
dialog  --sleep 1 --title "EMULATOR ERROR" --msgbox "
- YOU DO NOT HAVE THE CORRECT EMU INSTALLED
- TOOL CANT CONFIGURE A EMU NOT THIER
- EXITING NOW" 0 0
}

####--------------------------------------------------------------------------------------------SINDEN------------------------------------------------------------------####

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
      3 "CONSOLE SETUP MENU" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) sinden-install ;;
    2) sinden-config ;;
    3) sinden-consoles ;;
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

function sinden-consolesssssssssss() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "SINDEN LIGHTGUN MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO SETUP" 40 60 40 \
      1 "Apply NES Gun Config" \
      2 "Apply Model 3 Gun Config" \
      3 "-----UNDO MENU-----" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) nes-wii ;;
    2) model3 ;;
    3) dolphin-bar-undo ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function sinden-consoles() {
dialog  --sleep 1 --title "COMING SOON" --msgbox "
- COMING SOON
- PLEASE WAIT LOL" 0 0
}

function SINDEN-undo() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "SINDEN UNDO MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO UNDO" 40 60 40 \
      1 "Undo NES Gun Config" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) undo-sinden "nes" ;;
    -) no ;;
     *) break ;;
    esac
   done
}

###---------------------------------------------------------------------STANDALONES--------------------------------------------------------------------###

function model3() {
if [ ! -d "opt/retropie/configs/model3" ]; then
dialog  --sleep 1 --title "MISSING EMU ERROR" --msgbox "
- SUPER MODEL 3 IS NOT INSTALLED 
- CANT CREATE GUN CONFIG WITHOUT EMU 
- EXTING " 0 0
else
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/sa-configs/all/model3/supermodel.ini -P
fi
}



###---------------------------------------------------------------------SECRET SHHHH SECRET--------------------------------------------------------------------###

function secret-menu() {
dialog  --sleep 1 --title "CONGRATULATIONS" --msgbox "
- CONGRATS MY FRIEND 
- YOU HAVE FOUND THE SECRET MENU 
- PLEASE SELECT PACK TO DOWNLOAD " 0 0
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "SECRET MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO SELECT" 40 60 40 \
      1 "NES Pack" \
      2 "SNES Packs" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) wget-pack "nes" ;;
    2) wget-pack "snes" ;;
    3) wget-all ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function wget-pack() {
wget https://archive.org/download/RPI-Lightgun-Games/"$1"-lightgun-games.zip -P "$HOME"/RetroPie/roms/"$1"/gun-games/
sudo unzip "$HOME"/RetroPie/roms/"$1"/gun-games/"$1"-lightgun-games
sleep 1
sudo rm "$HOME"/RetroPie/roms/"$1"/gun-games/"$1"-lightgun-games
}

function wget-all() {
wget-pack "nes"
wget pack "snes"
}

gun-menu

#!/bin/bash
export NCURSES_NO_UTF8_ACS=1
BACKTITLE="<-----RPI LIGHTGUN TOOL -----><->Version<->1.01"

function gun-menu() {
local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "LIGHTGUN TOOL MAIN MENU" \
      --ok-label Select --cancel-label Exit \
      --menu "WHAT KIND OF GUN DO U WANNA USE?" 40 60 40 \
      1 "AE Lightgun" \
      2 "AimTrack Lightgun" \
      3 "Dolphin/WII Mote" \
      4 "Gun4IR Lightgun" \
      5 "Infared Mouse Gun" \
      6 "Sinden Lightgun" \
      - "----------<><><>---------" \
      T1 "---ABOUT  RPI-LG-TOOL---" \
      T2 "---DISPLAY GUN LAYOUTS--" \
      T3 "---REMOVE RPI-LG-TOOL---" \
      T4 "---UPDATE RPI-LG-TOOL---" \
      oo "---------<><><>---------" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) ae-menu ;;
    2) aimtrack ;;
    3) dolphin-bar-menu  ;;
    4) gun4ir-menu  ;;
    5) ir-mouse-menu ;;
    6) sinden-menu ;;
    7) soon ;;
    T1) gun-help ;;
    T2) layouts ;;
    T3) remove-script ;;
    T4) update-script ;;
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
if [ ! -d "/$HOME/Lightgun-Tool/" ]; then sudo rm -R $HOME/Lightgun-Tool/; fi
mkdir $HOME/Lightgun-Tool/
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/RPI-Lightgun-Tool.sh -P $HOME/RetroPie/retropiemenu/
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/Lightgun-Tool/ir-mouse-layout.sh -P $HOME/Lightgun-Tool/
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/Lightgun-Tool/wii-layout.sh -P $HOME/Lightgun-Tool/ 
wget https://github.com/Retro-Devils/RPI-LightGun-Tool/blob/main/Lightgun-Tool/wii-layout.mp4 -P $HOME/Lightgun-Tool/
wget https://github.com/Retro-Devils/RPI-LightGun-Tool/blob/main/Lightgun-Tool/ir-mouse-layout.mp4 -P $HOME/Lightgun-Tool/
sleep 1
sudo cp $HOME/RetroPie/retropiemenu/RPI-Lightgun-Tool.sh -f /usr/local/bin/RPI-Lightgun-Tool
sleep 1
chmod 777 $HOME/RetroPie/retropiemenu/RPI-Lightgun-Tool.sh
sudo chmod 777 /usr/local/bin/RPI-Lightgun-Tool
chmod 777 -R $HOME/Lightgun-Tool/
}

function layouts() {
local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "MAIN MENU" \
      --ok-label Select --cancel-label Exit \
      --menu "WHAT KIND OF GUN DO YOU HAVE?" 40 60 40 \
      1 "Dolphin/WII Mote" \
      2 "Infared Mouse Gun" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) bash $HOME/Lightgun-Tool/wii-layout.sh ;;
    2) bash $HOME/Lightgun-Tool/ir-mouse-layout.sh  ;;
     -) no ;;
     *) break ;;
    esac
   done
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


function ae-menu() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "DOLPHIN BAR/WII MOTE MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO SETUP" 40 60 40 \
      1 "Apply----Arcade Config" \
      2 "Apply----Dreamcast Config" \
      3 "Apply----Genesis Config" \
      4 "Apply----NES Config" \
      5 "Apply----Masterystem Config" \
      6 "Apply----Model 3 Config" \
      7 "Apply----PS1 Config" \
      8 "Apply----Sega CD Config" \
      9 "Apply----SNES Config" \
      A "-----APPLY ALL-----" \
      U "-----UNDO MENU-----" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) arcade-ae ;;
    2) dreamcast-ae ;;
    3) genesis-ae ;;
    4) nes-ae ;;
    5) mastersystem-ae ;;
    6) model3 ;;
    7) ps1-ae ;;
    8) segacd-ae ;;
    9) snes-ae ;;
    A) all-ae ;;
    U) ae-undo ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function arcade-ae() {
if [ ! -d "/opt/retropie/configs/arcade" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/arcade/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/arcade/sinden-confirm" ]; then setup-error "sinden" ; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-flycast.sh" ]; then arcade-emu "lr-flycast"; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-mame-StormedBubbles.sh" ]; then arcade-emu "lr-mame-StormedBubbles" ; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-mame2015-StormedBubbles.sh" ]; then arcade-emu "lr-mame2015-StormedBubbles" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/arcade/retroarch-gun-2003plus.cfg -P /opt/retropie/configs/arcade/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/arcade/retroarch-gun-2003.cfg -P /opt/retropie/configs/arcade/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/arcade/retroarch-gun-2016.cfg -P /opt/retropie/configs/arcade/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/arcade/retroarch-gun-stormbubb.cfg -P /opt/retropie/configs/arcade/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/arcade/retroarch-gun-2015stormbubb.cfg -P /opt/retropie/configs/arcade/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/arcade/retroarch-gun-flycast.cfg -P /opt/retropie/configs/arcade/
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-2003+.cfg
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-2003.cfg
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-2016.cfg
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-stormbubb.cfg
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-2015stormbubb.cfg
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-flycast.cfg
if [ ! -d "$HOME/RetroPie/roms/arcade/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/arcade/gun-games/"; fi
sudo cp /opt/retropie/configs/arcade/emulators.cfg /opt/retropie/configs/arcade/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/arcade/wii-confirm" ] ; then
sed -i '/default/a lightgun-2003+ = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-mame2003-plus/mame2003_plus_libretro.so --config /opt/retropie/configs/arcade/retroarch-gun-2003+.cfg %ROM%"' /opt/retropie/configs/arcade/emulators.cfg
sleep 1
sed -i '/lightgun-2003+/a lightgun-2003 = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-mame2003/mame2003_libretro.so --config /opt/retropie/configs/arcade/retroarch.cfg %ROM%"' /opt/retropie/configs/arcade/emulators.cfg
sleep 1
sed -i '/lightgun-2003/a lightgun-2016 = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-mame2016/mamearcade2016_libretro.so --config /opt/retropie/configs/arcade/retroarch.cfg %ROM%"' /opt/retropie/configs/arcade/emulators.cfg
sleep 1
mkdir "$HOME/Lightgun-Tool/arcade/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/ae-confirm -P $HOME/Lightgun-Tool/arcade/
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
ae-layout
}


function dreamcast-ae() {
if [ -f "$HOME/Lightgun-Tool/dreamcast/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/dreamcast/sinden-confirm" ]; then setup-error "sinden" ; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-flycast.sh" ]; then  dreamcast-emu "lr-flycast" ; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-flyinghead.sh" ]; then dremcast-emu "lr-flyinghead"; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/dreamcast/retroarch-gun-flycast.cfg -P /opt/retropie/configs/dreamcast/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/dreamcast/retroarch-gun-flyinghead.cfg -P /opt/retropie/configs/dreamcast/
sudo chmod 777 /opt/retropie/configs/dreamcast/retroarch-gun-flycast.cfg
sudo chmod 777 /opt/retropie/configs/dreamcast/retroarch-gun-flyinghead.cfg
if [ ! -d "$HOME/RetroPie/roms/dreamcast/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/dreamcast/gun-games/"; fi
sudo cp /opt/retropie/configs/mastersytem/emulators.cfg /opt/retropie/configs/dreamcast/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/dreamcast/wii-confirm" ] ; then
sed -i '/default/a lightgun-flycast = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-flycast/flycast_libretro.so </dev/null --config /opt/retropie/configs/dreamcast/retroarch-gun-flycast.cfg %ROM%"' /opt/retropie/configs/dreamcast/emulators.cfg
sleep 1
sed -i '/lightgun-flycast/a lightgun-flyinghead = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-flycast-flyinghead/flycast_libretro.so </dev/null --config /opt/retropie/configs/dreamcast/retroarch-gun-flyinghead.cfg %ROM%"' /opt/retropie/configs/dreamcast/emulators.cfg
mkdir "$HOME/Lightgun-Tool/dreamcast/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/ae-confirm -P $HOME/Lightgun-Tool/dreamcast/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/arcade/gun-games/ 
- New emus called lightgun-flycast and lightgun-flyinghead were added to emulators.cfg
- lightgun-flycast is LR FLYCAST, lightgun-mazan is LR FLYCAST-MAZAN etc.
- Most games you can use lightgun-flycast 
- For Virtua Cop 2 and Ninja (Naomi) you will need to use Mazan or Flyinghead" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
ae-layout
}

function genesis-ae() {
if [ ! -d "/opt/retropie/configs/genesis" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/genesis/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/genesis/sinden-confirm" ]; then setup-error "sinden" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/genesis/retroarch-gun.cfg -P /opt/retropie/configs/genesis/
sudo chmod 777 /opt/retropie/configs/genesis/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/genesis/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/genesis/gun-games/"; fi
sudo cp /opt/retropie/configs/genesis/emulators.cfg /opt/retropie/configs/genesis/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/wii-confirm" ] ; then
sed -i '/default/a lightgun-genesis = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-genesis-plus-gx/genesis_plus_gx_libretro.so --config /opt/retropie/configs/genesis/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/genesis/emulators.cfg
mkdir "$HOME/Lightgun-Tool/genesis/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/ae-confirm -P $HOME/Lightgun-Tool/genesis/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/genesis/gun-games/ 
- A new emu called lightgun-genesis was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-genesis" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
ae-layout
}

function nes-ae() {
if [ ! -d "/opt/retropie/configs/nes" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/nes/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/nes/sinden-confirm" ]; then setup-error "sinden" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/nes/retroarch-gun.cfg -P /opt/retropie/configs/nes/
sudo chmod 777 /opt/retropie/configs/nes/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/nes/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/nes/gun-games/"; fi
sudo cp /opt/retropie/configs/nes/emulators.cfg /opt/retropie/configs/nes/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/sinden-confirm" ] ; then
sed -i '/default/a lightgun-nes = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-fceumm/fceumm_libretro.so --config /opt/retropie/configs/nes/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/nes/emulators.cfg
mkdir "$HOME/Lightgun-Tool/nes/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/ae-confirm -P $HOME/Lightgun-Tool/nes/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/nes/gun-games/ 
- A new emu called lightgun-nes was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-nes" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
ae-layout
}

function mastersystem-ae() {
if [ ! -d "/opt/retropie/configs/mastersystem" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/mastersystem/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/mastersystem/sinden-confirm" ]; then setup-error "sinden" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/mastersystem/retroarch-gun.cfg -P /opt/retropie/configs/mastersystem/
sudo chmod 777 /opt/retropie/configs/mastersystem/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/mastersytem/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/mastersystem/gun-games/"; fi
sudo cp /opt/retropie/configs/mastersytem/emulators.cfg /opt/retropie/configs/mastersystem/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/mastersystem/wii-confirm" ] ; then
sed -i '/default/a lightgun-mastersystem = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-genesis-plus-gx/genesis_plus_gx_libretro.so --config /opt/retropie/configs/mastersystem/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/mastersystem/emulators.cfg
mkdir "$HOME/Lightgun-Tool/mastersystem/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/ae-confirm -P $HOME/Lightgun-Tool/mastersystem/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/mastersystem/gun-games/ 
- A new emu called lightgun-mastersystem was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-mastersystem" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
ae-layout
}


function ps1-ae() {
if [ ! -d "/opt/retropie/configs/psx" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/psx/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/psx/sinden-confirm" ]; then setup-error "sinden" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/psx/retroarch-gun-mouse.cfg -P /opt/retropie/configs/psx/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/psx/retroarch-gun-gcon.cfg -P /opt/retropie/configs/psx/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/psx/retroarch-gun-ngun.cfg -P /opt/retropie/configs/psx/
sudo chmod 777 /opt/retropie/configs/psx/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/psx/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/psx/gun-games/"; fi
sudo cp /opt/retropie/configs/psx/emulators.cfg /opt/retropie/configs/psx/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/psx/wii-confirm" ] ; then
sed -i '/default/a lightgun-mouse = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-pcsx-rearmed/pcsx_rearmed_libretro.so --config /opt/retropie/configs/psx/retroarch-gun-mouse.cfg %ROM%"' /opt/retropie/configs/psx/emulators.cfg
sleep 1
sed -i '/default/a lightgun-guncon = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-pcsx-rearmed/pcsx_rearmed_libretro.so --config /opt/retropie/configs/psx/retroarch-gun-gcon.cfg %ROM%"' /opt/retropie/configs/psx/emulators.cfg
sleep 1
sed -i '/default/a lightgun-negun = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-pcsx-rearmed/pcsx_rearmed_libretro.so --config /opt/retropie/configs/psx/retroarch-gun-ngun.cfg %ROM%"' /opt/retropie/configs/psx/emulators.cfg
mkdir "$HOME/Lightgun-Tool/psx/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/ae-confirm -P $HOME/Lightgun-Tool/psx/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/psx/gun-games/ 
- A new emu called lightgun-mouse was added to emulators.cfg
- A new emu called lightgun-guncon was added to emulators.cfg
- A new emu called lightgun-negun was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-psx" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
ae-layout
}

function segacd-ae() {
if [ ! -d "/opt/retropie/configs/segacd" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/segacd/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/segacd/sinden-confirm" ]; then setup-error "sinden" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/segacd/retroarch-gun.cfg -P /opt/retropie/configs/segacd/
sudo chmod 777 /opt/retropie/configs/segacd/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/segacd/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/segacd/gun-games/"; fi
sudo cp /opt/retropie/configs/segacd/emulators.cfg /opt/retropie/configs/segacd/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/segacd/wii-confirm" ] ; then
sed -i '/default/a lightgun-segacd = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-segacd-plus-gx/genesis_plus_gx_libretro.so --config /opt/retropie/configs/genesis/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/segacd/emulators.cfg
mkdir "$HOME/Lightgun-Tool/segacd/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/ae-confirm -P $HOME/Lightgun-Tool/segacd/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/segacd/gun-games/ 
- A new emu called lightgun-segacd was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-segacd" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
ae-layout
}


function snes-ae() {
if [ ! -d "/opt/retropie/configs/snes" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/snes/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/snes/sinden-confirm" ]; then setup-error "sinden" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/snes/retroarch-gun.cfg -P /opt/retropie/configs/snes/
sudo chmod 777 /opt/retropie/configs/snes/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/snes/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/snes/gun-games/"; fi
sudo cp /opt/retropie/configs/snes/emulators.cfg /opt/retropie/configs/snes/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/snes/wii-confirm" ] ; then
sed -i '/default/a lightgun-snes = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-snes9x/snes9x_libretro.so --config /opt/retropie/configs/snes/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/snes/emulators.cfg
mkdir "$HOME/Lightgun-Tool/snes/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ae/ae-confirm -P $HOME/Lightgun-Tool/snes/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/snes/gun-games/ 
- A new emu called lightgun-snes was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO light-snes" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
ae-layout
}



function ae-undo() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "WII MOTE UNDO MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO UNDO" 40 60 40 \
      1 "Undo Arcade Gun Config" \
      2 "Undo Dreamcast Gun Config" \
      3 "Undo Genesis Gun Config" \
      4 "Undo NES Gun Config" \
      5 "Undo Mastersystem Gun Config" \
      6 "Undo PS1 Gun Config" \
      7 "Undo SegaCd Gun Config" \
      8 "Undo SNES Gun Config" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) undo-retroarch "arcade" ;;
    2) undo-retroarch "dreamcast" ;;
    3) undo-retroarch "genesis" ;;
    4) undo-retroarch "nes" ;;
    5) undo-retroarch "mastersystem" ;;
    6) undo-retroarch "psx" ;;
    7) undo-retroarch "segacd" ;;
    8) undo-retroarch "snes" ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function ae-layout() {
dialog  --sleep 1 --title "ATTENTION MESSAGE" --msgbox "
BLAH" 0 0
}

function all-ae() {
arcade-ae
dreamcast-ae
genesis-ae
mastersystem-ae
nes-ae
snes-ae
ps1-ae
segcd-ae
snes-ae
}


#--------------------------------------------------------------DOLPHIN BAR---------------------------------------------------------------------------------------#

function dolphin-bar-menu() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "DOLPHIN BAR/WII MOTE MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO SETUP" 40 60 40 \
      1 "Apply----Arcade Config" \
      2 "Apply----Dreamcast Config" \
      3 "Apply----Genesis Config" \
      4 "Apply----NES Config" \
      5 "Apply----Masterystem Config" \
      6 "Apply----Model 3 Config" \
      7 "Apply----PS1 Config" \
      8 "Apply----Sega CD Config" \
      9 "Apply----SNES Config" \
      A "-----APPLY ALL-----" \
      U "-----UNDO MENU-----" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) arcade-wii ;;
    2) dreamcast-wii ;;
    3) genesis-wii ;;
    4) nes-wii ;;
    5) mastersystem-wii ;;
    6) model3 ;;
    7) ps1-wii ;;
    8) segacd-wii ;;
    9) snes-wii ;;
    A) all-wii ;;
    U) dolphin-bar-undo ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function arcade-wii() {
if [ ! -d "/opt/retropie/configs/arcade" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/arcade/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/arcade/sinden-confirm" ]; then setup-error "sinden" ; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-flycast.sh" ]; then arcade-emu "lr-flycast"; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-mame-StormedBubbles.sh" ]; then arcade-emu "lr-mame-StormedBubbles" ; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-mame2015-StormedBubbles.sh" ]; then arcade-emu "lr-mame2015-StormedBubbles" ; fi
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
if [ ! -d "$HOME/RetroPie/roms/arcade/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/arcade/gun-games/"; fi
sudo cp /opt/retropie/configs/arcade/emulators.cfg /opt/retropie/configs/arcade/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/arcade/wii-confirm" ] ; then
sed -i '/default/a lightgun-2003+ = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-mame2003-plus/mame2003_plus_libretro.so --config /opt/retropie/configs/arcade/retroarch-gun-2003+.cfg %ROM%"' /opt/retropie/configs/arcade/emulators.cfg
sleep 1
sed -i '/lightgun-2003+/a lightgun-2003 = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-mame2003/mame2003_libretro.so --config /opt/retropie/configs/arcade/retroarch.cfg %ROM%"' /opt/retropie/configs/arcade/emulators.cfg
sleep 1
sed -i '/lightgun-2003/a lightgun-2016 = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-mame2016/mamearcade2016_libretro.so --config /opt/retropie/configs/arcade/retroarch.cfg %ROM%"' /opt/retropie/configs/arcade/emulators.cfg
sleep 1
mkdir "$HOME/Lightgun-Tool/arcade/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/wii-confirm -P $HOME/Lightgun-Tool/arcade/
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

function arcade-emu() {
cd $HOME/RetroPie-Setup
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/scriptmodules/multi-input/libretrocores/"$1".sh -P $HOME/RetroPie-Setup/scriptmodules/libretrocores/
git pull
sudo ./retropie_packages.sh "$1"
}

function dreamcast-wii() {
if [ -f "$HOME/Lightgun-Tool/dreamcast/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/dreamcast/sinden-confirm" ]; then setup-error "sinden" ; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-flycast.sh" ]; then  dreamcast-emu "lr-flycast" ; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-flyinghead.sh" ]; then dremcast-emu "lr-flyinghead"; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/dreamcast/retroarch-gun-flycast.cfg -P /opt/retropie/configs/dreamcast/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/dreamcast/retroarch-gun-flyinghead.cfg -P /opt/retropie/configs/dreamcast/
sudo chmod 777 /opt/retropie/configs/dreamcast/retroarch-gun-flycast.cfg
sudo chmod 777 /opt/retropie/configs/dreamcast/retroarch-gun-flyinghead.cfg
if [ ! -d "$HOME/RetroPie/roms/dreamcast/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/dreamcast/gun-games/"; fi
sudo cp /opt/retropie/configs/mastersytem/emulators.cfg /opt/retropie/configs/dreamcast/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/dreamcast/wii-confirm" ] ; then
sed -i '/default/a lightgun-flycast = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-flycast/flycast_libretro.so </dev/null --config /opt/retropie/configs/dreamcast/retroarch-gun-flycast.cfg %ROM%"' /opt/retropie/configs/dreamcast/emulators.cfg
sleep 1
sed -i '/lightgun-flycast/a lightgun-flyinghead = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-flycast-flyinghead/flycast_libretro.so </dev/null --config /opt/retropie/configs/dreamcast/retroarch-gun-flyinghead.cfg %ROM%"' /opt/retropie/configs/dreamcast/emulators.cfg
mkdir "$HOME/Lightgun-Tool/dreamcast/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/wii-confirm -P $HOME/Lightgun-Tool/dreamcast/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/arcade/gun-games/ 
- New emus called lightgun-flycast and lightgun-flyinghead were added to emulators.cfg
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

function dreamcast-emu() {
cd $HOME/RetroPie-Setup
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/scriptmodules/multi-input/libretrocores/"$1".sh -P $HOME/RetroPie-Setup/scriptmodules/libretrocores/
git pull
sudo ./retropie_packages.sh "$1"
}


function genesis-wii() {
if [ ! -d "/opt/retropie/configs/genesis" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/genesis/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/genesis/sinden-confirm" ]; then setup-error "sinden" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/genesis/retroarch-gun.cfg -P /opt/retropie/configs/genesis/
sudo chmod 777 /opt/retropie/configs/genesis/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/genesis/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/genesis/gun-games/"; fi
sudo cp /opt/retropie/configs/genesis/emulators.cfg /opt/retropie/configs/genesis/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/wii-confirm" ] ; then
sed -i '/default/a lightgun-genesis = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-genesis-plus-gx/genesis_plus_gx_libretro.so --config /opt/retropie/configs/genesis/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/genesis/emulators.cfg
mkdir "$HOME/Lightgun-Tool/genesis/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/wii-confirm -P $HOME/Lightgun-Tool/genesis/
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
if [ -f "$HOME/Lightgun-Tool/nes/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/nes/sinden-confirm" ]; then setup-error "sinden" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/nes/retroarch-gun.cfg -P /opt/retropie/configs/nes/
sudo chmod 777 /opt/retropie/configs/nes/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/nes/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/nes/gun-games/"; fi
sudo cp /opt/retropie/configs/nes/emulators.cfg /opt/retropie/configs/nes/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/sinden-confirm" ] ; then
sed -i '/default/a lightgun-nes = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-fceumm/fceumm_libretro.so --config /opt/retropie/configs/nes/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/nes/emulators.cfg
mkdir "$HOME/Lightgun-Tool/nes/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/wii-confirm -P $HOME/Lightgun-Tool/nes/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/nes/gun-games/ 
- A new emu called lightgun-nes was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-nes" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
dolphin-layout
}

function mastersystem-wii() {
if [ ! -d "/opt/retropie/configs/mastersystem" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/mastersystem/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/mastersystem/sinden-confirm" ]; then setup-error "sinden" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/mastersystem/retroarch-gun.cfg -P /opt/retropie/configs/mastersystem/
sudo chmod 777 /opt/retropie/configs/mastersystem/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/mastersytem/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/mastersystem/gun-games/"; fi
sudo cp /opt/retropie/configs/mastersytem/emulators.cfg /opt/retropie/configs/mastersystem/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/mastersystem/wii-confirm" ] ; then
sed -i '/default/a lightgun-mastersystem = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-genesis-plus-gx/genesis_plus_gx_libretro.so --config /opt/retropie/configs/mastersystem/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/mastersystem/emulators.cfg
mkdir "$HOME/Lightgun-Tool/mastersystem/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/wii-confirm -P $HOME/Lightgun-Tool/mastersystem/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/mastersystem/gun-games/ 
- A new emu called lightgun-mastersystem was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-mastersystem" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
dolphin-layout
}


function ps1-wii() {
if [ ! -d "/opt/retropie/configs/psx" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/psx/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/psx/sinden-confirm" ]; then setup-error "sinden" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/psx/retroarch-gun-mouse.cfg -P /opt/retropie/configs/psx/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/psx/retroarch-gun-gcon.cfg -P /opt/retropie/configs/psx/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/psx/retroarch-gun-ngun.cfg -P /opt/retropie/configs/psx/
sudo chmod 777 /opt/retropie/configs/psx/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/psx/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/psx/gun-games/"; fi
sudo cp /opt/retropie/configs/psx/emulators.cfg /opt/retropie/configs/psx/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/psx/wii-confirm" ] ; then
sed -i '/default/a lightgun-mouse = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-pcsx-rearmed/pcsx_rearmed_libretro.so --config /opt/retropie/configs/psx/retroarch-gun-mouse.cfg %ROM%"' /opt/retropie/configs/psx/emulators.cfg
sleep 1
sed -i '/default/a lightgun-guncon = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-pcsx-rearmed/pcsx_rearmed_libretro.so --config /opt/retropie/configs/psx/retroarch-gun-gcon.cfg %ROM%"' /opt/retropie/configs/psx/emulators.cfg
sleep 1
sed -i '/default/a lightgun-negun = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-pcsx-rearmed/pcsx_rearmed_libretro.so --config /opt/retropie/configs/psx/retroarch-gun-ngun.cfg %ROM%"' /opt/retropie/configs/psx/emulators.cfg
mkdir "$HOME/Lightgun-Tool/psx/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/wii-confirm -P $HOME/Lightgun-Tool/psx/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/psx/gun-games/ 
- A new emu called lightgun-mouse was added to emulators.cfg
- A new emu called lightgun-guncon was added to emulators.cfg
- A new emu called lightgun-negun was added to emulators.cfg
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
if [ -f "$HOME/Lightgun-Tool/segacd/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/segacd/sinden-confirm" ]; then setup-error "sinden" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/segacd/retroarch-gun.cfg -P /opt/retropie/configs/segacd/
sudo chmod 777 /opt/retropie/configs/segacd/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/segacd/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/segacd/gun-games/"; fi
sudo cp /opt/retropie/configs/segacd/emulators.cfg /opt/retropie/configs/segacd/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/segacd/wii-confirm" ] ; then
sed -i '/default/a lightgun-segacd = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-segacd-plus-gx/genesis_plus_gx_libretro.so --config /opt/retropie/configs/genesis/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/segacd/emulators.cfg
mkdir "$HOME/Lightgun-Tool/segacd/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/wii-confirm -P $HOME/Lightgun-Tool/segacd/
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
if [ -f "$HOME/Lightgun-Tool/snes/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/snes/sinden-confirm" ]; then setup-error "sinden" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/snes/retroarch-gun.cfg -P /opt/retropie/configs/snes/
sudo chmod 777 /opt/retropie/configs/snes/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/snes/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/snes/gun-games/"; fi
sudo cp /opt/retropie/configs/snes/emulators.cfg /opt/retropie/configs/snes/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/snes/wii-confirm" ] ; then
sed -i '/default/a lightgun-snes = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-snes9x/snes9x_libretro.so --config /opt/retropie/configs/snes/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/snes/emulators.cfg
mkdir "$HOME/Lightgun-Tool/snes/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/wii-confirm -P $HOME/Lightgun-Tool/snes/
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
      1 "Undo Arcade Gun Config" \
      2 "Undo Dreamcast Gun Config" \
      3 "Undo Genesis Gun Config" \
      4 "Undo NES Gun Config" \
      5 "Undo Mastersystem Gun Config" \
      6 "Undo PS1 Gun Config" \
      7 "Undo SegaCd Gun Config" \
      8 "Undo SNES Gun Config" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) undo-retroarch "arcade" ;;
    2) undo-retroarch "dreamcast" ;;
    3) undo-retroarch "genesis" ;;
    4) undo-retroarch "nes" ;;
    5) undo-retroarch "mastersystem" ;;
    6) undo-retroarch "psx" ;;
    7) undo-retroarch "segacd" ;;
    8) undo-retroarch "snes" ;;
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

function all-wii() {
arcade-wii
dreamcast-wii
genesis-wii
mastersystem-wii
nes-wii
snes-wii
ps1-wii
segcd-wii
snes-wii
}


#---------------------------------------------------------------GUN4IR---------------------------------------------------------------#

function gun4ir-menu() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "DOLPHIN BAR/WII MOTE MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO SETUP" 40 60 40 \
      1 "Apply----Arcade Config" \
      2 "Apply----Dreamcast Config" \
      3 "Apply----Genesis Config" \
      4 "Apply----NES Config" \
      5 "Apply----Masterystem Config" \
      6 "Apply----Model 3 Config" \
      7 "Apply----PS1 Config" \
      8 "Apply----Sega CD Config" \
      9 "Apply----SNES Config" \
      A "-----APPLY ALL-----" \
      U "-----UNDO MENU-----" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) arcade-gun4ir ;;
    2) dreamcast-gun4ir ;;
    3) genesis-gun4ir ;;
    4) nes-gun4ir ;;
    5) mastersystem-gun4ir ;;
    6) model3 ;;
    7) ps1-gun4ir ;;
    8) segacd-gun4ir ;;
    9) snes-gun4ir ;;
    A) all-gun4ir ;;
    U) gun4ir-undo ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function arcade-gun4ir() {
if [ ! -d "/opt/retropie/configs/arcade" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/arcade/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/arcade/sinden-confirm" ]; then setup-error "sinden" ; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-flycast.sh" ]; then arcade-emu "lr-flycast"; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-mame-StormedBubbles.sh" ]; then arcade-emu "lr-mame-StormedBubbles" ; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-mame2015-StormedBubbles.sh" ]; then arcade-emu "lr-mame2015-StormedBubbles" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/arcade/retroarch-gun-2003plus.cfg -P /opt/retropie/configs/arcade/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/arcade/retroarch-gun-2003.cfg -P /opt/retropie/configs/arcade/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/arcade/retroarch-gun-2016.cfg -P /opt/retropie/configs/arcade/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/arcade/retroarch-gun-stormbubb.cfg -P /opt/retropie/configs/arcade/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/arcade/retroarch-gun-2015stormbubb.cfg -P /opt/retropie/configs/arcade/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/arcade/retroarch-gun-flycast.cfg -P /opt/retropie/configs/arcade/
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-2003+.cfg
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-2003.cfg
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-2016.cfg
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-stormbubb.cfg
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-2015stormbubb.cfg
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-flycast.cfg
if [ ! -d "$HOME/RetroPie/roms/arcade/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/arcade/gun-games/"; fi
sudo cp /opt/retropie/configs/arcade/emulators.cfg /opt/retropie/configs/arcade/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/arcade/wii-confirm" ] ; then
sed -i '/default/a lightgun-2003+ = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-mame2003-plus/mame2003_plus_libretro.so --config /opt/retropie/configs/arcade/retroarch-gun-2003+.cfg %ROM%"' /opt/retropie/configs/arcade/emulators.cfg
sleep 1
sed -i '/lightgun-2003+/a lightgun-2003 = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-mame2003/mame2003_libretro.so --config /opt/retropie/configs/arcade/retroarch.cfg %ROM%"' /opt/retropie/configs/arcade/emulators.cfg
sleep 1
sed -i '/lightgun-2003/a lightgun-2016 = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-mame2016/mamearcade2016_libretro.so --config /opt/retropie/configs/arcade/retroarch.cfg %ROM%"' /opt/retropie/configs/arcade/emulators.cfg
sleep 1
mkdir "$HOME/Lightgun-Tool/arcade/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/gun4ir-confirm -P $HOME/Lightgun-Tool/arcade/
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
gun4ir-layout
}

function dreamcast-gun4ir() {
if [ -f "$HOME/Lightgun-Tool/dreamcast/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/dreamcast/sinden-confirm" ]; then setup-error "sinden" ; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-flycast.sh" ]; then  dreamcast-emu "lr-flycast" ; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-flyinghead.sh" ]; then dremcast-emu "lr-flyinghead"; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/dreamcast/retroarch-gun-flycast.cfg -P /opt/retropie/configs/dreamcast/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/dreamcast/retroarch-gun-flyinghead.cfg -P /opt/retropie/configs/dreamcast/
sudo chmod 777 /opt/retropie/configs/dreamcast/retroarch-gun-flycast.cfg
sudo chmod 777 /opt/retropie/configs/dreamcast/retroarch-gun-flyinghead.cfg
if [ ! -d "$HOME/RetroPie/roms/dreamcast/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/dreamcast/gun-games/"; fi
sudo cp /opt/retropie/configs/mastersytem/emulators.cfg /opt/retropie/configs/dreamcast/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/dreamcast/wii-confirm" ] ; then
sed -i '/default/a lightgun-flycast = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-flycast/flycast_libretro.so </dev/null --config /opt/retropie/configs/dreamcast/retroarch-gun-flycast.cfg %ROM%"' /opt/retropie/configs/dreamcast/emulators.cfg
sleep 1
sed -i '/lightgun-flycast/a lightgun-flyinghead = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-flycast-flyinghead/flycast_libretro.so </dev/null --config /opt/retropie/configs/dreamcast/retroarch-gun-flyinghead.cfg %ROM%"' /opt/retropie/configs/dreamcast/emulators.cfg
mkdir "$HOME/Lightgun-Tool/dreamcast/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/gun4ir-confirm -P $HOME/Lightgun-Tool/dreamcast/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/arcade/gun-games/ 
- New emus called lightgun-flycast and lightgun-flyinghead were added to emulators.cfg
- lightgun-flycast is LR FLYCAST, lightgun-mazan is LR FLYCAST-MAZAN etc.
- Most games you can use lightgun-flycast 
- For Virtua Cop 2 and Ninja (Naomi) you will need to use Mazan or Flyinghead" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
gun4ir-layout
}


function genesis-gun4ir() {
if [ ! -d "/opt/retropie/configs/genesis" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/genesis/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/genesis/sinden-confirm" ]; then setup-error "sinden" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/genesis/retroarch-gun.cfg -P /opt/retropie/configs/genesis/
sudo chmod 777 /opt/retropie/configs/genesis/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/genesis/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/genesis/gun-games/"; fi
sudo cp /opt/retropie/configs/genesis/emulators.cfg /opt/retropie/configs/genesis/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/wii-confirm" ] ; then
sed -i '/default/a lightgun-genesis = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-genesis-plus-gx/genesis_plus_gx_libretro.so --config /opt/retropie/configs/genesis/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/genesis/emulators.cfg
mkdir "$HOME/Lightgun-Tool/genesis/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/gun4ir-confirm -P $HOME/Lightgun-Tool/genesis/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/genesis/gun-games/ 
- A new emu called lightgun-genesis was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-genesis" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
gun4ir-layout
}

function nes-gun4ir() {
if [ ! -d "/opt/retropie/configs/nes" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/nes/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/nes/sinden-confirm" ]; then setup-error "sinden" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/nes/retroarch-gun.cfg -P /opt/retropie/configs/nes/
sudo chmod 777 /opt/retropie/configs/nes/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/nes/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/nes/gun-games/"; fi
sudo cp /opt/retropie/configs/nes/emulators.cfg /opt/retropie/configs/nes/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/sinden-confirm" ] ; then
sed -i '/default/a lightgun-nes = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-fceumm/fceumm_libretro.so --config /opt/retropie/configs/nes/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/nes/emulators.cfg
mkdir "$HOME/Lightgun-Tool/nes/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/gun4ir-confirm -P $HOME/Lightgun-Tool/nes/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/nes/gun-games/ 
- A new emu called lightgun-nes was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-nes" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
gun4ir-layout
}

function mastersystem-gun4ir() {
if [ ! -d "/opt/retropie/configs/mastersystem" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/mastersystem/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/mastersystem/sinden-confirm" ]; then setup-error "sinden" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/mastersystem/retroarch-gun.cfg -P /opt/retropie/configs/mastersystem/
sudo chmod 777 /opt/retropie/configs/mastersystem/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/mastersytem/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/mastersystem/gun-games/"; fi
sudo cp /opt/retropie/configs/mastersytem/emulators.cfg /opt/retropie/configs/mastersystem/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/mastersystem/wii-confirm" ] ; then
sed -i '/default/a lightgun-mastersystem = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-genesis-plus-gx/genesis_plus_gx_libretro.so --config /opt/retropie/configs/mastersystem/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/mastersystem/emulators.cfg
mkdir "$HOME/Lightgun-Tool/mastersystem/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/gun4ir-confirm -P $HOME/Lightgun-Tool/mastersystem/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/mastersystem/gun-games/ 
- A new emu called lightgun-mastersystem was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-mastersystem" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
gun4ir-layout
}


function ps1-gun4ir() {
if [ ! -d "/opt/retropie/configs/psx" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/psx/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/psx/sinden-confirm" ]; then setup-error "sinden" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/psx/retroarch-gun-mouse.cfg -P /opt/retropie/configs/psx/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/psx/retroarch-gun-gcon.cfg -P /opt/retropie/configs/psx/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/psx/retroarch-gun-ngun.cfg -P /opt/retropie/configs/psx/
sudo chmod 777 /opt/retropie/configs/psx/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/psx/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/psx/gun-games/"; fi
sudo cp /opt/retropie/configs/psx/emulators.cfg /opt/retropie/configs/psx/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/psx/wii-confirm" ] ; then
sed -i '/default/a lightgun-mouse = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-pcsx-rearmed/pcsx_rearmed_libretro.so --config /opt/retropie/configs/psx/retroarch-gun-mouse.cfg %ROM%"' /opt/retropie/configs/psx/emulators.cfg
sleep 1
sed -i '/default/a lightgun-guncon = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-pcsx-rearmed/pcsx_rearmed_libretro.so --config /opt/retropie/configs/psx/retroarch-gun-gcon.cfg %ROM%"' /opt/retropie/configs/psx/emulators.cfg
sleep 1
sed -i '/default/a lightgun-negun = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-pcsx-rearmed/pcsx_rearmed_libretro.so --config /opt/retropie/configs/psx/retroarch-gun-ngun.cfg %ROM%"' /opt/retropie/configs/psx/emulators.cfg
mkdir "$HOME/Lightgun-Tool/psx/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/gun4ir-confirm -P $HOME/Lightgun-Tool/psx/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/psx/gun-games/ 
- A new emu called lightgun-mouse was added to emulators.cfg
- A new emu called lightgun-guncon was added to emulators.cfg
- A new emu called lightgun-negun was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-psx" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
gun4ir-layout
}

function segacd-gun4ir() {
if [ ! -d "/opt/retropie/configs/segacd" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/segacd/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/segacd/sinden-confirm" ]; then setup-error "sinden" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/segacd/retroarch-gun.cfg -P /opt/retropie/configs/segacd/
sudo chmod 777 /opt/retropie/configs/segacd/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/segacd/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/segacd/gun-games/"; fi
sudo cp /opt/retropie/configs/segacd/emulators.cfg /opt/retropie/configs/segacd/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/segacd/wii-confirm" ] ; then
sed -i '/default/a lightgun-segacd = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-segacd-plus-gx/genesis_plus_gx_libretro.so --config /opt/retropie/configs/genesis/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/segacd/emulators.cfg
mkdir "$HOME/Lightgun-Tool/segacd/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/gun4ir-confirm -P $HOME/Lightgun-Tool/segacd/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/segacd/gun-games/ 
- A new emu called lightgun-segacd was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-segacd" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
gun4ir-layout
}


function snes-gun4ir() {
if [ ! -d "/opt/retropie/configs/snes" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/snes/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/snes/sinden-confirm" ]; then setup-error "sinden" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/snes/retroarch-gun.cfg -P /opt/retropie/configs/snes/
sudo chmod 777 /opt/retropie/configs/snes/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/snes/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/snes/gun-games/"; fi
sudo cp /opt/retropie/configs/snes/emulators.cfg /opt/retropie/configs/snes/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/snes/wii-confirm" ] ; then
sed -i '/default/a lightgun-snes = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-snes9x/snes9x_libretro.so --config /opt/retropie/configs/snes/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/snes/emulators.cfg
mkdir "$HOME/Lightgun-Tool/snes/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/gun4ir/gun4ir-confirm -P $HOME/Lightgun-Tool/snes/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/snes/gun-games/ 
- A new emu called lightgun-snes was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO light-snes" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
gun4ir-layout
}



function gun4ir-undo() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "GUN4IR UNDO MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO UNDO" 40 60 40 \
      1 "Undo Arcade Gun Config" \
      2 "Undo Dreamcast Gun Config" \
      3 "Undo Genesis Gun Config" \
      4 "Undo NES Gun Config" \
      5 "Undo Mastersystem Gun Config" \
      6 "Undo PS1 Gun Config" \
      7 "Undo SegaCd Gun Config" \
      8 "Undo SNES Gun Config" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) undo-retroarch "arcade" ;;
    2) undo-retroarch "dreamcast" ;;
    3) undo-retroarch "genesis" ;;
    4) undo-retroarch "nes" ;;
    5) undo-retroarch "mastersystem" ;;
    6) undo-retroarch "psx" ;;
    7) undo-retroarch "segacd" ;;
    8) undo-retroarch "snes" ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function gun4ir-layout() {
dialog  --sleep 1 --title "ATTENTION MESSAGE" --msgbox "
GUN4IR LAYOUT IS AS FOLLOWS

FOR RETROARCH/IN GAME
WII MOTE -----IN RETROARCH
trigger ------------- a & shoot
left side button ---- b & reload 
right side button --- gun c & action" 0 0
}

function all-gun4ir() {
arcade-gun4ir
dreamcast-gun4ir
genesis-gun4ir
mastersystem-gun4ir
nes-gun4ir
snes-gun4ir
ps1-gun4ir
segcd-gun4ir
snes-gun4ir
}




#--------------------------------------------------------------IR MOUSE GUN-------------------------------------------------------------------------------------------------------#
function ir-mouse-menu() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title " INFARED MOUSE GUN MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO SETUP" 40 60 40 \
      1 "Apply----Arcade Config" \
      2 "Apply----Dreamcast Config" \
      3 "Apply----Genesis Config" \
      4 "Apply----NES Config" \
      5 "Apply----Masterystem Config" \
      6 "Apply----Model 3 Config" \
      7 "Apply----PS1 Config" \
      8 "Apply----Sega CD Config" \
      9 "Apply----SNES Config" \
      A "-----APPLY ALL-----" \
      U "-----UNDO MENU-----" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) arcade-mouse ;;
    2) dreamcast-mouse ;;
    3) genesis-mouse ;;
    4) nes-mouse ;;
    5) mastersystem-mouse ;;
    6) model3 ;;
    7) ps1-mouse ;;
    8) segacd-mouse ;;
    9) snes-mouse ;;
    A) all-mouse ;;
    U) undo-mouse ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function arcade-mouse() {
if [ ! -d "/opt/retropie/configs/arcade" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/arcade/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/arcade/sinden-confirm" ]; then setup-error "sinden" ; fi
if [ -f "$HOME/Lightgun-Tool/arcade/wii-confirm" ]; then setup-error "wii-mote" ; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-flycast.sh" ]; then arcade-emu "lr-flycast"; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-mame-StormedBubbles.sh" ]; then arcade-emu "lr-mame-StormedBubbles" ; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-mame2015-StormedBubbles.sh" ]; then arcade-emu "lr-mame2015-StormedBubbles" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/arcade/retroarch-gun-2003plus.cfg -P /opt/retropie/configs/arcade/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/arcade/retroarch-gun-2003.cfg -P /opt/retropie/configs/arcade/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/arcade/retroarch-gun-2016.cfg -P /opt/retropie/configs/arcade/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/arcade/retroarch-gun-stormbubb.cfg -P /opt/retropie/configs/arcade/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/arcade/retroarch-gun-2015stormbubb.cfg -P /opt/retropie/configs/arcade/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/arcade/retroarch-gun-flycast.cfg -P /opt/retropie/configs/arcade/
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-2003+.cfg
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-2003.cfg
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-2016.cfg
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-stormbubb.cfg
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-2015stormbubb.cfg
sudo chmod 777 /opt/retropie/configs/arcade/retroarch-gun-flycast.cfg
if [ ! -d "$HOME/RetroPie/roms/arcade/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/arcade/gun-games/"; fi
sudo cp /opt/retropie/configs/arcade/emulators.cfg /opt/retropie/configs/arcade/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/arcade/mouse-confirm" ] ; then
sed -i '/default/a lightgun-2003+ = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-mame2003-plus/mame2003_plus_libretro.so --config /opt/retropie/configs/arcade/retroarch-gun-2003+.cfg %ROM%"' /opt/retropie/configs/arcade/emulators.cfg
sleep 1
sed -i '/lightgun-2003+/a lightgun-2003 = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-mame2003/mame2003_libretro.so --config /opt/retropie/configs/arcade/retroarch.cfg %ROM%"' /opt/retropie/configs/arcade/emulators.cfg
sleep 1
sed -i '/lightgun-2003/a lightgun-2016 = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-mame2016/mamearcade2016_libretro.so --config /opt/retropie/configs/arcade/retroarch.cfg %ROM%"' /opt/retropie/configs/arcade/emulators.cfg
sleep 1
mkdir "$HOME/Lightgun-Tool/arcade/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/wii-confirm -P $HOME/Lightgun-Tool/arcade/
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
mouse-layout
}

function arcade-emu() {
cd $HOME/RetroPie-Setup
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/scriptmodules/multi-input/libretrocores/"$1".sh -P $HOME/RetroPie-Setup/scriptmodules/libretrocores/
git pull
sudo ./retropie_packages.sh "$1"
}

function dreamcast-mouse() {
if [ -f "$HOME/Lightgun-Tool/dreamcast/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/dreamcast/sinden-confirm" ]; then setup-error "sinden" ; fi
if [ -f "$HOME/Lightgun-Tool/dreamcast/wii-confirm" ]; then setup-error "wii-mote" ; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-flycast.sh" ]; then  dreamcast-emu "lr-flycast" ; fi
if [ ! -f "$HOME/RetroPie-Setup/scriptmodules/libretrocores/lr-flyinghead.sh" ]; then dremcast-emu "lr-flyinghead"; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/dreamcast/retroarch-gun-flycast.cfg -P /opt/retropie/configs/dreamcast/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/dreamcast/retroarch-gun-flyinghead.cfg -P /opt/retropie/configs/dreamcast/
sudo chmod 777 /opt/retropie/configs/dreamcast/retroarch-gun-flycast.cfg
sudo chmod 777 /opt/retropie/configs/dreamcast/retroarch-gun-flyinghead.cfg
if [ ! -d "$HOME/RetroPie/roms/dreamcast/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/dreamcast/gun-games/"; fi
sudo cp /opt/retropie/configs/mastersytem/emulators.cfg /opt/retropie/configs/dreamcast/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/dreamcast/mouse-confirm" ] ; then
sed -i '/default/a lightgun-flycast = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-flycast/flycast_libretro.so </dev/null --config /opt/retropie/configs/dreamcast/retroarch-gun-flycast.cfg %ROM%"' /opt/retropie/configs/dreamcast/emulators.cfg
sleep 1
sed -i '/lightgun-flycast/a lightgun-flyinghead = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-flycast-flyinghead/flycast_libretro.so </dev/null --config /opt/retropie/configs/dreamcast/retroarch-gun-flyinghead.cfg %ROM%"' /opt/retropie/configs/dreamcast/emulators.cfg
mkdir "$HOME/Lightgun-Tool/dreamcast/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/mouse-confirm -P $HOME/Lightgun-Tool/dreamcast/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/arcade/gun-games/ 
- New emus called lightgun-flycast and lightgun-flyinghead were added to emulators.cfg
- lightgun-flycast is LR FLYCAST, lightgun-mazan is LR FLYCAST-MAZAN etc.
- Most games you can use lightgun-flycast 
- For Virtua Cop 2 and Ninja (Naomi) you will need to use Mazan or Flyinghead" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
mouse-layout
}

function dreamcast-emu() {
cd $HOME/RetroPie-Setup
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/scriptmodules/multi-input/libretrocores/"$1".sh -P $HOME/RetroPie-Setup/scriptmodules/libretrocores/
git pull
sudo ./retropie_packages.sh "$1"
}


function genesis-mouse() {
if [ ! -d "/opt/retropie/configs/genesis" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/genesis/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/genesis/sinden-confirm" ]; then setup-error "sinden" ; fi
if [ -f "$HOME/Lightgun-Tool/genesis/wii-confirm" ]; then setup-error "wii-mote" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/wii-mote/genesis/retroarch-gun.cfg -P /opt/retropie/configs/genesis/
sudo chmod 777 /opt/retropie/configs/genesis/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/genesis/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/genesis/gun-games/"; fi
sudo cp /opt/retropie/configs/genesis/emulators.cfg /opt/retropie/configs/genesis/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/mouse-confirm" ] ; then
sed -i '/default/a lightgun-genesis = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-genesis-plus-gx/genesis_plus_gx_libretro.so --config /opt/retropie/configs/genesis/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/genesis/emulators.cfg
mkdir "$HOME/Lightgun-Tool/genesis/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/wii-confirm -P $HOME/Lightgun-Tool/genesis/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/genesis/gun-games/ 
- A new emu called lightgun-genesis was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-genesis" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
mouse-layout
}

function nes-mouse() {
if [ ! -d "/opt/retropie/configs/nes" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/nes/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/nes/sinden-confirm" ]; then setup-error "sinden" ; fi
if [ -f "$HOME/Lightgun-Tool/nes/wii-confirm" ]; then setup-error "wii-mote" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/nes/retroarch-gun.cfg -P /opt/retropie/configs/nes/
sudo chmod 777 /opt/retropie/configs/nes/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/nes/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/nes/gun-games/"; fi
sudo cp /opt/retropie/configs/nes/emulators.cfg /opt/retropie/configs/nes/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/mouse-confirm" ] ; then
sed -i '/default/a lightgun-nes = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-fceumm/fceumm_libretro.so --config /opt/retropie/configs/nes/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/nes/emulators.cfg
mkdir "$HOME/Lightgun-Tool/nes/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/wii-confirm -P $HOME/Lightgun-Tool/nes/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/nes/gun-games/ 
- A new emu called lightgun-nes was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-nes" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
mouse-layout
}

function mastersystem-mouse() {
if [ ! -d "/opt/retropie/configs/mastersystem" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/mastersystem/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/mastersystem/sinden-confirm" ]; then setup-error "sinden" ; fi
if [ -f "$HOME/Lightgun-Tool/mastersystem/wii-confirm" ]; then setup-error "wii-mote" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/mastersystem/retroarch-gun.cfg -P /opt/retropie/configs/mastersystem/
sudo chmod 777 /opt/retropie/configs/mastersystem/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/mastersytem/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/mastersystem/gun-games/"; fi
sudo cp /opt/retropie/configs/mastersytem/emulators.cfg /opt/retropie/configs/mastersystem/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/mastersystem/mouse-confirm" ] ; then
sed -i '/default/a lightgun-mastersystem = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-genesis-plus-gx/genesis_plus_gx_libretro.so --config /opt/retropie/configs/mastersystem/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/mastersystem/emulators.cfg
mkdir "$HOME/Lightgun-Tool/mastersystem/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/mouse-confirm -P $HOME/Lightgun-Tool/mastersystem/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/mastersystem/gun-games/ 
- A new emu called lightgun-mastersystem was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-mastersystem" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
mouse-layout
}


function ps1-mouse() {
if [ ! -d "/opt/retropie/configs/psx" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/psx/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/psx/sinden-confirm" ]; then setup-error "sinden" ; fi
if [ -f "$HOME/Lightgun-Tool/psx/wii-confirm" ]; then setup-error "wii-mote" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/psx/retroarch-gun-mouse.cfg -P /opt/retropie/configs/psx/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/psx/retroarch-gun-gcon.cfg -P /opt/retropie/configs/psx/
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/psx/retroarch-gun-ngun.cfg -P /opt/retropie/configs/psx/
sudo chmod 777 /opt/retropie/configs/psx/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/psx/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/psx/gun-games/"; fi
sudo cp /opt/retropie/configs/psx/emulators.cfg /opt/retropie/configs/psx/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/psx/mouse-confirm" ] ; then
sed -i '/default/a lightgun-mouse = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-pcsx-rearmed/pcsx_rearmed_libretro.so --config /opt/retropie/configs/psx/retroarch-gun-mouse.cfg %ROM%"' /opt/retropie/configs/psx/emulators.cfg
sleep 1
sed -i '/default/a lightgun-guncon = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-pcsx-rearmed/pcsx_rearmed_libretro.so --config /opt/retropie/configs/psx/retroarch-gun-gcon.cfg %ROM%"' /opt/retropie/configs/psx/emulators.cfg
sleep 1
sed -i '/default/a lightgun-negun = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-pcsx-rearmed/pcsx_rearmed_libretro.so --config /opt/retropie/configs/psx/retroarch-gun-ngun.cfg %ROM%"' /opt/retropie/configs/psx/emulators.cfg
mkdir "$HOME/Lightgun-Tool/psx/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/mouse-confirm -P $HOME/Lightgun-Tool/psx/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/psx/gun-games/ 
- A new emu called lightgun-mouse was added to emulators.cfg
- A new emu called lightgun-guncon was added to emulators.cfg
- A new emu called lightgun-negun was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-psx" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
mouse-layout
}

function segacd-mouse() {
if [ ! -d "/opt/retropie/configs/segacd" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/segacd/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/segacd/sinden-confirm" ]; then setup-error "sinden" ; fi
if [ -f "$HOME/Lightgun-Tool/segacd/wii-confirm" ]; then setup-error "wii-mote" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/segacd/retroarch-gun.cfg -P /opt/retropie/configs/segacd/
sudo chmod 777 /opt/retropie/configs/segacd/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/segacd/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/segacd/gun-games/"; fi
sudo cp /opt/retropie/configs/segacd/emulators.cfg /opt/retropie/configs/segacd/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/segacd/mouse-confirm" ] ; then
sed -i '/default/a lightgun-segacd = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-segacd-plus-gx/genesis_plus_gx_libretro.so --config /opt/retropie/configs/genesis/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/segacd/emulators.cfg
mkdir "$HOME/Lightgun-Tool/segacd/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/mouse-confirm -P $HOME/Lightgun-Tool/segacd/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/segacd/gun-games/ 
- A new emu called lightgun-segacd was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO lightgun-segacd" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
mouse-layout
}


function snes-mouse() {
if [ ! -d "/opt/retropie/configs/snes" ]; then emu-error; fi
if [ -f "$HOME/Lightgun-Tool/snes/gun4ir-confirm" ]; then setup-error "gun4ir" ; fi
if [ -f "$HOME/Lightgun-Tool/snes/sinden-confirm" ]; then setup-error "sinden" ; fi
if [ -f "$HOME/Lightgun-Tool/snes/wii-confirm" ]; then setup-error "wii-mote" ; fi
sudo wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/snes/retroarch-gun.cfg -P /opt/retropie/configs/snes/
sudo chmod 777 /opt/retropie/configs/snes/retroarch-gun.cfg
if [ ! -d "$HOME/RetroPie/roms/snes/gun-games/" ]; then mkdir "$HOME/RetroPie/roms/snes/gun-games/"; fi
sudo cp /opt/retropie/configs/snes/emulators.cfg /opt/retropie/configs/snes/emulators-cfg.backup
if [ ! -f "$HOME/Lightgun-Tool/snes/mouse-confirm" ] ; then
sed -i '/default/a lightgun-snes = "/opt/retropie/emulators/retroarch/bin/retroarch -L /opt/retropie/libretrocores/lr-snes9x/snes9x_libretro.so --config /opt/retropie/configs/snes/retroarch-gun.cfg %ROM%"' /opt/retropie/configs/snes/emulators.cfg
mkdir "$HOME/Lightgun-Tool/snes/"
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/ra-configs/ir-mouse/mouse-confirm -P $HOME/Lightgun-Tool/snes/
dialog  --sleep 1 --title "GUN CONFIG COMPLETE" --msgbox "
- A FOLDER HAS BEEN MADE UNDER Home/Pi/RetroPie/roms/snes/gun-games/ 
- A new emu called lightgun-snes was added to emulators.cfg
- WHEN YOU START A GUN GAME PRESS A WHILE LOADING CHANGE EMU TO light-snes" 0 0
else
dialog  --sleep 1 --title "GUN ALREADY CONFIGURED" --msgbox "
- NO NEED TO CONFIGURE WITH THIS TOOL
- PLEASE REPORT ERRORS TO RETRO DEVILS" 0 0
fi
mouse-layout
}



function undo-mouse() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "WII MOTE UNDO MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PRESS A/ENTER TO UNDO" 40 60 40 \
      1 "Undo Arcade Gun Config" \
      2 "Undo Dreamcast Gun Config" \
      3 "Undo Genesis Gun Config" \
      4 "Undo NES Gun Config" \
      5 "Undo Mastersystem Gun Config" \
      6 "Undo PS1 Gun Config" \
      7 "Undo SegaCD Gun Config" \
      8 "Undo SNES Gun Config" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) undo-retroarch "arcade" ;;
    2) undo-retroarch "dreamcast" ;;
    3) undo-retroarch "genesis" ;;
    4) undo-retroarch "nes" ;;
    5) undo-retroarch "mastersystem" ;;
    6) undo-retroarch "psx" ;;
    7) undo-retroarch "segacd" ;;
    8) undo-retroarch "snes" ;;
    -) no ;;
     *) break ;;
    esac
   done
}

function mouse-layout() {
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

function all-mouse() {
arcade-mouse
dreamcast-mouse
genesis-mouse
mastersystem-mouse
nes-mouse
snes-mouse
ps1-mouse
segcd-mouse
snes-mouse
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

function setup-error() {
dialog  --sleep 1 --title "SETUP ERROR" --msgbox "
- "$1" IS ALREADY CONFIGURED ON THIS SYSTEM
- A ERROR MENU WILL NOW LOAD " 0 0
local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "SETUP ERROR MENU " \
      --ok-label Select --cancel-label Back \
      --menu "PLEASE SELECT A OPTION" 40 60 40 \
      1 "UNDO "$1" SETUP" \
      2 "EXIT " \
      2>&1 >/dev/tty)

    case "$choice" in
    1)  undo-retroach "$1" ;;
    2)  no ;;
    -) no ;;
     *) break ;;
    esac
   done
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

function sinden-hold() {
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
    3) sinden-undo ;;
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

function sinden-undo() {
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

#---------------------------------TWO GUNS-------------------------------------#

function 2guns-menu() {
  local choice
  while true; do
    choice=$(dialog --backtitle "$BACKTITLE" --title "2 LIGHTGUNS MENU " \
      --ok-label Select --cancel-label Back \
      --menu "WHAT LIGHTGUNS YOU WANNA USE?" 40 60 40 \
      - "----AE LIGHTGUN AS P1----" \
      1 "AE LIGHTGUN & WII MOTE" \
      2 "AE LIGHTGUN & GUN4IR" \
      3 "AE LIGHTGUN & SINDEN" \
      4 "2 AE LIGHTGUNS" \
      - "------GUN4IR AS P1-------" \
      5 "GUN4IR & AE LIGHTGUN" \
      6 "GUN4IR & WII MOTE" \
      7 "GUN4IR & SINDEN" \
      8 "2 GUN4IR LIGHTGUNS" \
      9 "----WII MOTE AS P1-------" \
      10 "WII MOTE & AE LIGHTGUN" \
      11 "WII MOTE & GUN4IR" \
      12 "WII MOTE & SINDEN" \
      13 "2 WII MOTES" \
      2>&1 >/dev/tty)

    case "$choice" in
    1) un  ;;
    -) no ;;
     *) break ;;
    esac
   done
}

gun-menu

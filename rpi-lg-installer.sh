
export NCURSES_NO_UTF8_ACS=1
###----------------------------###
### INSTALLER MENU FUNCTIONS   ###
###----------------------------###
function gun-install-menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " RPI LIGHTGUN TOOL V--1.00---UPDATED 11/5/22 " \
            --ok-label Select --cancel-label Exit-Installer \
            --menu "----RPI LIGHTGUN TOOL INSTALLER----" 25 50 30 \
            1 "Install/Update RPI LightGun Tool " \
            2 "RPI LightGun Tool Info   " \
            2>&1 > /dev/tty)

        case "$choice" in
            1) install  ;;
            2) info        ;;
            -) no ;;
            *) break       ;;
        esac
    done
}



function install() {
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

function info() {
dialog  --sleep 1 --title "---RPI LIGHTGUN TOOL INFO 1---" --msgbox "
Info
     This is a tool to make using Lightguns on Retropie as easy as possible.
     Version:                BETA 1.01
     Last Update:            11/5/22
FEATURES
      Grabs a pre setup retroarch-gun.cfg file for Retroarch systems.
      Grabs or edits files on standalone emu configs.
      Make new folders for gun games. 
      Ask what type of gun your using, & loads different menus for different guns.
      Makes a new emulator in retropie, called lightgun-systemname. ex lightgun-nes
HOW TO USE?
   In Retropie
      1.Go to Retropie/Config
      2.Launch RPI Lightgun Tool       
      3.Select Gun Type
      4.Select system/console
      5.Press A/Enter
      6.Select From The Options 
   From Command Line/Terminal
      1.Type RPI-Lightgun-Tool                  
      2.See steps 3-6 above" 0 0
      
dialog  --sleep 1 --title "---RPI LIGHTGUN TOOL INFO 2---" --msgbox "
FREQUENTLY ASKED QUESTIONS
Where does it make new folder for gun games ?
home/pi/RetroPie/roms/systemname/gun-games/

What is new configs called? Where are they at?
The new retroarch config is located at 
            /opt/retropie/configs/systemname/retroarch-gun.cfg  
            
The new edited emulators.cfg is located at
            /opt/retropie/configs/systemname/emulators.cfg
            
Your emulators.cfg backup is located at 
            /opt/retropie/configs/systemname/emulators-cfg.backup
            
What gun(s) is this for ?
- Aimtrack(untested, Unlikely)
- AE Lightgun
- Dolphin Bar with Wii mote
- Gun4IR Lightgun
- Infared Mouse Input Guns
- Sinden Lightgun

How do I undo the changes the script made?
   - Open RPI Lightgun Tool
   - Click Gun Type   
   - Click on ---UNDO MENU---   
   - Select system youd like to undo" 0 0
}


gun-install-menu

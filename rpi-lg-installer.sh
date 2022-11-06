





export NCURSES_NO_UTF8_ACS=1
###----------------------------###
### INSTALLER MENU FUNCTIONS   ###
###----------------------------###
function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " RPI LIGHTGUN TOOL V--1.00---UPDATED 11/5/22 " \
            --ok-label Select --cancel-label Exit-Installer \
            --menu "RPI LIGHTGUN TOOL INSTALLER" 25 50 30 \
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
wget https://raw.githubusercontent.com/Retro-Devils/RPI-LightGun-Tool/main/RPI-Lightgun-Tool.sh -P $HOME/RetroPie/retropiemenu/
sleep 1
sudo cp $HOME/RetroPie/retropiemenu/RPI-Lightgun-Tool.sh -f /usr/local/bin/RPI-Lightgun-Tool
sleep 1
chmod 755 $HOME/RetroPie/retropiemenu/RPI-Lightgun-Tool.sh
sudo chmod 755 /usr/local/bin/RPI-Lightgun-Tool
}

function info() {
echo "blah blah blah "
sleep 5
}

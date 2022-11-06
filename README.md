# RPI-LightGun-Tool
WORK IN PROGRESS

This is a tool to make using Lightguns on Retropie as easy as possible.

Last Update:            11/5/22

## FEATURES 

          Grabs a pre setup retroarch config file for Retroarch systems.

          Grabs or edits files on standalone emus .

          Edit es_systems.cfg to add gun systems

          Make new folders for gun games. 

          Ask what type of gun your using, & loads different menus 

## INSTALLATION

curl -sSL WORK IN PROGRESS WORK IN PROGRESS

## HOW TO USE?

- In Retropie

            Go to Retropie/Config
            
            Launch RPI Lightgun Tool 
            
            Select Gun Type

            Select system/console

            Press A/Enter

            Select From The Options 
            
            
- From Command Line/Terminal

            Type "RPI-Lightgun-Tool" 
                        
            Press Enter
            
            Select Gun Type
            
            Select system/console

            Press A/Enter

            Select from the options
## FAQ

- Where does it make new folder for gun games ?
      
      home/pi/RetroPie/roms/gun-games/"systemname"
      
- What is new config called? Where is it?

      The new config is located at /opt/retropie/configs/systemname-gun . 
      It is a config with just gun setup . 
      
- Whats this edit in es_systems.cfg?

      This makes new systems for gun games.
      
      Example for nes-gun system (not exact do NOT copy)
      <system>
      <name>nes-gun<name> 
      <fullname>NES Gun Games<fullname>
      <launch> ................../nes-gun<launch>
      <path>home/pi/RetroPie/roms/gun-games/nes/<path>
      <system>
       
- What gun(s) is this for ?
      
      - Gun4IR
      - Wii Mote Guns
      - Actual mouse
      - Aimtrack(untested, Unlikely)
      - Sinden (adding soon)


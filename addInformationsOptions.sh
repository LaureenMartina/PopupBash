#!/bin/bash

#COLORS
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan

displayPopup()
(
    # créer la popup
    if [ -z $(command -v zenity) ]; then
        echo "$Cyan Installation de zenity... $Color_Off"
        apt-get install zenity
    fi
    if [ -z $(command -v curl) ]; then
        echo "$Cyan Installation de curl... $Color_Off"
        apt install curl
    fi

    zenity --title="$1" --text="$2" --$3
)

#05 * * * * /media/sf_PROJET/addInformationsOptions.sh

#laisser le choix à l'utilisateur pour décider s'il souhaite procéder à une installation de modules supplémentaires (météo et/ou newspaper)
displayPopup

zenity --title="Installation" --text="Souhaitez-vous installer des options supplémentaires ?\n Disponibles : Info Météo | Info News" --question

if [ $? = 0 ]; then
    choice=$(zenity  --list  --text "Que souhaitez-vous installer ?" --radiolist  --column "Choix" --column "Option" TRUE "Météo" FALSE "News");
    if [ $choice == "Météo" ]; then
        #vérifier les droits pour l'installation
        fileMeteo="testAPI.sh"
        if [ -f $fileMeteo ]; then
            echo "$Purple Service météo activée $Color_Off"
            ./$fileMeteo
        fi
    elif [ $choice == "News" ]; then
        fileNews="news.sh"
        if [ -f $fileNews ]; then
            echo "$Purple Service news activée $Color_Off"
            ./$fileNews
        fi
    else
        echo "$Purple Arrêt de l'installation... $Color_Off"
    fi
fi
#!/bin/bash

displayPopup()
(
    # créer la popup
    if [ -z $(command -v zenity) ]; then
        echo "Installation de zenity..."
        apt-get install zenity
    fi
    if [ -z $(command -v curl) ]; then
        echo "Installation de curl..."
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
            echo "Service météo activée"
            ./$fileMeteo
        fi
    elif [ $choice == "News" ]; then
        fileNews="news.sh"
        if [ -f $fileNews ]; then
            echo "Service news activée"
            ./$fileNews
        fi
    else
        echo "Arrêt de l'installation..."
    fi
fi
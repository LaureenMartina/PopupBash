#!/bin/bash

displayPopup()
(
    # créer la popup
    if [ -z $(command -v zenity) ]; then
        apt-get install zenity
    fi

    zenity --title="$1" --text="$2" --$3
)

#laisser le choix à l'utilisateur pour décider s'il souhaite procéder à une installation de modules supplémentaires (météo et/ou newspaper)
displayPopup

zenity --title="Installation" --text="Souhaitez-vous installer des options supplémentaires ?\n Disponibles : Info Météo | Info News" --question

if [ $? = "0" ]; then
    choice=$(zenity  --list  --text "Que souhaitez-vous installer ?" --radiolist  --column "Choix" --column "Option" TRUE "Météo" FALSE "News");
    if [ $choice eq "Météo" ]; then
        #vérifier les droits pour l'installation
        fileMeteo="/media/sf_PROJET/testAPI.sh"
        if [ -e -x $fileMeteo]; then
            echo "installation météo activée"
            ./$fileMeteo
        fi
    else
        fileNews="/media/sf_PROJET/news.sh"
        if [ -e -x $fileNews]; then
            echo "installation news activée"
            ./$fileNews
        fi
    fi
fi
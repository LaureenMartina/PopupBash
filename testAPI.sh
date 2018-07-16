#!/bin/bash

#fonctions
displayWeather()
(
    # créer la popup
    if [ -z $(command -v zenity) ]; then
        apt-get install zenity
    fi

    zenity --title="METEO DU JOUR" --text="Description: $1\nTempérature annoncée: $2°C\navec $3°C min et $4°C max \nHumidité: $5%\nVent: $6" --info
)

logWeather()
(
    now=$(date +%s)
    mkdir -p "/etc/weather/logs"
    touch "/etc/weather/logs/$now.html"
    chmod 777 "/etc/weather/logs/$now.html"

    echo "<span>$1</span><br/><img src=\"/etc/weather/weather-icons/png/$2.png\">" > "/etc/weather/logs/$now.html"
)

infoUser=$(curl -s ipinfo.io/23.66.166.151)
country=$(echo $infoUser | jq -r ".country")
#echo $country
city=$(echo $infoUser | jq -r ".city")
#echo $city

#replace url
weatherData=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=$city,$country&units=metric&appid=3543da1a78501f1823db167188346285&lang=fr")

# appel + parse curl
description=$(echo $weatherData | jq -r ".weather[].description")
temp=$(echo $weatherData | jq -r ".main.temp")
temp_min=$(echo $weatherData | jq -r ".main.temp_min")
temp_max=$(echo $weatherData | jq -r ".main.temp_max")
humidity=$(echo $weatherData | jq -r ".main.humidity")
wind=$(echo $weatherData | jq -r ".wind.speed")


displayWeather "$description" "$temp" "$temp_min" "$temp_max" "$humidity" "$wind"

#création du dossier contenant le futur fichier log
iconId=$(echo $weatherData | jq -r ".weather[].icon")
logWeather "$description" "$iconId"
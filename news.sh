#!/bin/bash

#tableau à déclarer
declare -a sources

#fonctions
installDepencies()
(
    # add python librairy
    if [ -z $(command -v python-3) ]; then
        echo "installing..."
        apt-get install -y python3-pip python3
    fi
    if [ -z $(command -v tofrodos) ]; then
        apt-get install tofrodos
    fi
)

displayNews()
(
    zenity --title="$1" --text="Author: $2\nTitle: $3\nDescription: $4\nPublished: $5\nurl: $6" --info
)

# ---------- call python scripts -----------
#path="/media/sf_PROJET/init__.py"
#echo $path
#dos2unix $path
#echo "dos2unix effectué..."
# get result JSON
#responseJSON=python $path
#echo $responseJSON

key="8df18dcd35f649e3843d25920cdab720"

sources[0]="le-monde"
sources[1]="google-news-fr"
sources[2]="hacker-news"
sources[3]="liberation"
sources[4]="metro"
sources[5]="lequipe"
sources[6]="les-echos"

size=${#sources[*]}

randomSource=$[($RANDOM%($[$size-0]))]

count=0
for article in ${sources[*]};
do
    if [ $count -eq $randomSource ]; then
        res=$article;
    fi
    ((count++))
done

#replace url
newsData=$(curl -s "https://newsapi.org/v2/top-headlines?sources=$res&apiKey=$key")

#Select one of these 10 articles
randomArticle=$[($RANDOM%($[10-0]))]

# appel + parse curl
name=$(echo $newsData | jq -r ".articles[$randomArticle].source.name")
author=$(echo $newsData | jq -r ".articles[$randomArticle].author")
title=$(echo $newsData | jq -r ".articles[$randomArticle].title")
description=$(echo $newsData | jq -r ".articles[$randomArticle].description")
published=$(echo $newsData | jq -r ".articles[$randomArticle].publishedAt" | cut -c1-10)
url=$(echo $newsData | jq -r ".articles[$randomArticle].url")

displayNews "$name" "$author" "$title" "$description" "$published" "$url"
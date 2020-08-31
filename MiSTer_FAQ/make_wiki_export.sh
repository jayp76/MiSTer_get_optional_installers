#!/bin/bash
# https://github.com/yakivmospan/github-wikito-converter

mkdir wiki_temp
cd ./wiki_temp

wget https://github.com/jayp76/MiSTer_get_optional_installers/raw/master/MiSTer_FAQ/misterkun_logo.png

git clone https://github.com/MiSTer-devel/Main_MiSTer.wiki.git

gwtc -v -t "MiSTer Wiki" --logo-img misterkun_logo.png -n MiSTer_Wiki_"`date +%F`" ./Main_MiSTer.wiki

gwtc -v -f pdf -t "MiSTer Wiki" --logo-img misterkun_logo.png -n MiSTer_Wiki_"`date +%F`" ./Main_MiSTer.wiki
#!/bin/bash
# https://github.com/yakivmospan/github-wikito-converter

mkdir wiki_temp
cd ./wiki_temp
rm -rf *

wget https://raw.githubusercontent.com/jayp76/MiSTer_get_optional_installers/master/MiSTer_FAQ/misterkun_logo.png

git clone https://github.com/MiSTer-devel/Main_MiSTer.wiki.git

gwtc -v -t "MiSTer Wiki" --logo-img misterkun_logo.png -n MiSTer_Wiki ./Main_MiSTer.wiki

# gwtc -v -f pdf -t "MiSTer Wiki" --logo-img misterkun_logo.png -n MiSTer_Wiki_"`date +%F`" ./Main_MiSTer.wiki

xz -z -v *.html

mv MiSTer_Wiki.html.xz MiSTer_Wiki_"`date +%F`".html.xz

#!/bin/bash
# https://github.com/yakivmospan/github-wikito-converter

mkdir -p wiki_temp
cd ./wiki_temp
rm -rf *

wget https://raw.githubusercontent.com/jayp76/MiSTer_get_optional_installers/master/MiSTer_FAQ/misterkun_logo.png

#git clone https://github.com/MiSTer-devel/Main_MiSTer.wiki.git
git clone https://github.com/MiSTer-devel/Wiki_MiSTer.wiki.git
# Workaround
#touch ./Wiki_MiSTer.wiki/Arcade-Cores-Top
#touch ./Wiki_MiSTer.wiki/Arcade-Cores-Bottom


#gwtc -v -t "MiSTer Wiki" --logo-img misterkun_logo.png -n MiSTer_Wiki ./Main_MiSTer.wiki
gwtc -v -t "MiSTer Wiki" --logo-img misterkun_logo.png -n MiSTer_Wiki ./Wiki_MiSTer.wiki
#lwc -v -t "MiSTer Wiki" --logo-img misterkun_logo.png -n MiSTer_Wiki ./Main_MiSTer.wiki

#gwtc -v -f pdf -t "MiSTer Wiki" --logo-img misterkun_logo.png --pdf-page-count -n MiSTer_Wiki_"`date +%F`" ./Main_MiSTer.wiki
gwtc -v -f pdf -t "MiSTer Wiki" --logo-img misterkun_logo.png --pdf-page-count -n MiSTer_Wiki_"`date +%F`" ./Wiki_MiSTer.wiki

#xz -z -v -e *.html

#mv MiSTer_Wiki.html.xz MiSTer_Wiki_"`date +%F`".html.xz

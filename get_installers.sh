#!/bin/bash

# Yet another random MiSTer utility script = YARMUS? LOL
#

# Version 2.7 - 2022-04-28 - added GamesMenu from wizzomafizzo
# Version 2.6 - 2022-05-17 - removed(uncommented) old MSU1 core due to official MSU1 release
#			   - removed xow driver due to official xow and xone support in latest MiSTer kernel 
# Version 2.5 - 2022-04-28 - added bgm.sh and favorites.sh from wizzomafizzo
# Version 2.4 - 2022-04-04 - now that MiSTer has "docs" support (.md, .txt, .pdf) i moved the cheatsheet and wiki/manual to docs folder.
# Version 2.3 - 2021-11-15 - added MiSTer_WebMenu by nilp0inter
# Version 2.2 - 2021-10-05 - added Arcade Offset by atrac17
# Version 2.1 - 2021-09-17 - added iniswitcher.sh by morfeus77, Retrodriven CRT Wallpapers, corrections, etc
#			   - MiSTer Custom Aspect Ratios by meauxdal
# Version 2.0 - 2021-09-16 - added Downloader_MiSTer from theypsilon 
# Version 1.9 - 2021-08-27 - added MSU1 core by dentnz (not official and latest core yet, but tested working), simplyfied SAM download script section
# Version 1.8 - 2021-04-26 - added Super Attract Mode (SAM) from mrchrisster
# Version 1.7 - 2021-04-13 - added Mister Attract Mode from mrchrisster (Arcade, Genesis, Mega CD, Neo Geo, SNES, TurboGrafx-16 CD AKA PC Engine CD)
#			   - added NES Attract Mode
# Version 1.6 - 2021-04-06 - added MiSTer Manual from adreeve
# 			   - Code optimizations and some stuff deactivated
#			   - added MiSTer_Duke Hyperkin Duke controller support for the MiSTer FPGA
# Version 1.5 - 2021-03-31 - added xow_Mister Linux driver for the Xbox One wireless dongle compiled for MiSTer
# 			   - added Mister Arcade Attract Mode and AO486_Update_Top300_Pack.ini
# Version 1.4 - 2021-01-28 - added flynnsbit eXoDOS Top 300 for ao486
# Version 1.3 - 2020-10-12 - added NX-Engine Cave Story port
# Version 1.2 - 2020-09-30 - added DevilutionX and Cannonball Ports, Best practice help text
# Version 1.1 - 2020-08-31 - added MiSTer Wiki download to #help folder and Owlnonymous Cheatsheet
# Version 1.0 - 2020-07-03 - First commit

BASE_DIR="/media/fat"  		#${BASE_DIR}
SVERSION="2.7"			#${SVERSION}
URL="https://github.com"
CURL_RETRY="--connect-timeout 15 --max-time 120 --retry 3 --retry-delay 5"
S_OPT="--silent"
# test network and https by pinging the target website 
SSL_SECURITY_OPTION=""
ALLOW_INSECURE_SSL="true"
curl ${CURL_RETRY} "${URL}" > /dev/null 2>&1
case $? in
	0)
		;;
	60)
		if [[ "${ALLOW_INSECURE_SSL}" == "true" ]]
		then
			SSL_SECURITY_OPTION="--insecure"
		else
			echo "CA certificates need"
			echo "to be fixed for"
			echo "using SSL certificate"
			echo "verification."
			echo "Please fix them i.e."
			echo "using security_fixes.sh"
			exit 2
		fi
		;;
	*)
		echo "No Internet connection"
		exit 1
		;;
esac

echo " Yarmus Version ${SVERSION} "
sleep 4

function get_installers {
  echo " ======================================================================="
  echo " Downloading installer scripts, please wait..."


  [[ -d ${BASE_DIR}/Scripts/installers ]] || mkdir -p ${BASE_DIR}/Scripts/installers ; cd ${BASE_DIR}/Scripts/installers
   curl ${CURL_RETRY} --insecure -o ${1} ${2}
   echo " "
   echo "***"
   echo " "
}

function get_std {
  echo " ======================================================================="
  echo " Downloading ${3}..."


  [[ -d ${BASE_DIR}/Scripts/${3} ]] || mkdir -p ${BASE_DIR}/Scripts/${3} ; cd ${BASE_DIR}/Scripts/${3}
   curl ${CURL_RETRY} --insecure -L -o ${1} ${2}
   echo " "
   echo "***"
   echo " "
}

function get_Wiki {
  echo " ======================================================================="
  echo " Downloading Wiki into "docs" folder"


  [[ -d ${BASE_DIR}/docs ]] || mkdir -p ${BASE_DIR}/docs ; cd ${BASE_DIR}/docs
   curl ${CURL_RETRY} --insecure -o ${1} ${2}
   echo " "
   echo "***"
   echo " "
}

function get_addons {
  echo " ======================================================================="
  echo " Downloading Addons"


  [[ -d ${BASE_DIR}/Scripts/${3} ]] || mkdir -p ${BASE_DIR}/Scripts/${3} ; cd ${BASE_DIR}/Scripts/${3}
   curl ${CURL_RETRY} --insecure -L -o ${1} ${2}
   unzip -j -o ${BASE_DIR}/Scripts/${3}/${1}
   rm ${BASE_DIR}/Scripts/${3}/${1}
   echo " "
   echo "***"
   echo " "
   #sleep 5
}

function get_addons2 {
  echo " ======================================================================="
  echo " Downloading Addons"


  [[ -d ${BASE_DIR}/Scripts/${3} ]] || mkdir -p ${BASE_DIR}/Scripts/${3} ; cd ${BASE_DIR}/Scripts/${3}
   curl ${CURL_RETRY} --insecure -L -o ${1} ${2}
   unzip -o ${BASE_DIR}/Scripts/${3}/${1}
   rm ${BASE_DIR}/Scripts/${3}/${1}
   echo " "
   echo "***"
   echo " "
   #sleep 5
}



# Updaters

echo "Getting theypsilon update_all"
get_installers update_all.sh https://raw.githubusercontent.com/theypsilon/Update_All_MiSTer/master/update_all.sh

echo "Getting theypsilon Downloader_MiSTer"
get_installers downloader.sh https://raw.githubusercontent.com/MiSTer-devel/Downloader_MiSTer/main/downloader.sh
get_installers downloader.ini https://raw.githubusercontent.com/jayp76/MiSTer_get_optional_installers/master/misc/MiSTer_downloader_example.ini

#echo "Getting RetroDriven_Update_Suite" #obsolete
#get_installers RetroDriven_Update_Suite.sh https://raw.githubusercontent.com/RetroDriven/MiSTerUpdateSuite/master/RetroDriven_Update_Suite.sh

#echo "Getting RetroDriven_MAME_SE and .ini" #obsolete
#get_installers Update_RetroDriven_MAME_SE.sh https://raw.githubusercontent.com/RetroDriven/MiSTerMAME/master/Update_RetroDriven_MAME_SE.sh
#get_installers Update_RetroDriven_MAME_SE.ini https://raw.githubusercontent.com/RetroDriven/MiSTerMAME/master/Update_RetroDriven_MAME_SE.ini

echo "Getting RetroDriven Update_MiSTerWallpapers and .ini"
get_installers Update_MiSTerWallpapers.sh https://raw.githubusercontent.com/RetroDriven/MiSTerWallpapers/master/Update_MiSTerWallpapers.sh
get_installers Update_MiSTerWallpapers.ini https://raw.githubusercontent.com/RetroDriven/MiSTerWallpapers/master/Update_MiSTerWallpapers.ini

echo "Getting RetroDriven MiSTer-CRT-Wallpapers and .ini"
get_installers Update_MiSTer-CRT-Wallpapers.sh https://raw.githubusercontent.com/RetroDriven/MiSTer-CRT-Wallpapers/main/Update_MiSTer-CRT-Wallpapers.sh
get_installers Update_MiSTer-CRT-Wallpapers.ini https://raw.githubusercontent.com/RetroDriven/MiSTer-CRT-Wallpapers/main/Update_MiSTer-CRT-Wallpapers.ini

#echo "Getting RetroDriven Update_MiSTerBIOS and .ini" #obsolete
#get_installers Update_MiSTerBIOS.sh https://raw.githubusercontent.com/RetroDriven/MiSTerBIOS/master/Update_MiSTerBIOS.sh
#get_installers Update_MiSTerBIOS.ini https://raw.githubusercontent.com/RetroDriven/MiSTerBIOS/master/Update_MiSTerBIOS.ini



# Installers

echo "Getting Homebrew Pack Installer (Retrobrew)"
get_installers get_homebrews.sh https://raw.githubusercontent.com/jayp76/installers/testing/%23get_homebrews.sh

echo "Getting bbond007 Install_ScummVM"
get_installers Install_ScummVM.sh https://raw.githubusercontent.com/bbond007/MiSTer_ScummVM/master/Install_ScummVM.sh

echo "Getting bbond007 PrBoom-Plus_Installer"
get_installers PrBoom-Plus_Installer.sh https://raw.githubusercontent.com/bbond007/MiSTer_PrBoom-Plus/master/PrBoom-Plus_Installer.sh

echo "Getting bbond007 MiSTer_BasiliskII"
get_installers Install_BasiliskII.sh https://raw.githubusercontent.com/bbond007/MiSTer_BasiliskII/master/Install_BasiliskII.sh

echo "Getting DevilutionX from misterkun-io"
echo "Put diabdat.mpq in Diablo folder. Optinally add \"vmode -r 640x480 rgb16\" to Diablo.sh in scripts folder."
get_installers install_devilutionx.sh https://raw.githubusercontent.com/jayp76/MiSTer_get_optional_installers/master/misc/install_devilutionx.sh

echo "Getting Boogerman Cannonball unofficial Port"
get_installers get_cannonball.sh https://raw.githubusercontent.com/jayp76/MiSTer_get_optional_installers/master/misc/get_cannonball.sh

echo "Getting EXL/NX-Engine Cave Story Port (playable with Keyboard)"
get_installers get_cave.sh https://raw.githubusercontent.com/jayp76/MiSTer_get_optional_installers/master/misc/get_cave.sh

# Help and FAQ documents

echo "Getting Wiki as HTML"
get_Wiki MiSTer_Wiki.html.xz https://raw.githubusercontent.com/jayp76/MiSTer_get_optional_installers/master/MiSTer_FAQ/MiSTer_Wiki.html.xz
/bin/xz -d -v -f MiSTer_Wiki.html.xz

echo "Getting Wiki as PDF"
get_Wiki MiSTer_Wiki.pdf https://raw.githubusercontent.com/jayp76/MiSTer_get_optional_installers/master/MiSTer_FAQ/MiSTer_Wiki.pdf

echo "Get Best Practice tips into your #help folder"
get_Wiki MiSTer_Best_Practice_for_installing_and_updating.txt https://raw.githubusercontent.com/jayp76/MiSTer_get_optional_installers/master/MiSTer_FAQ/MiSTer_Best_Practice_for_installing_and_updating.txt

echo "-=MiSTer Computer Cheat Sheet FAQ by Owlnonymous=-"
curl -ksLf https://pastebin.com/raw/pM1XMe5E > ${BASE_DIR}/docs/cheatsheet_$(date +"%Y_%m_%d").txt

echo "MiSTer Manual from adreeve"
get_Wiki MISTer_Manual.pdf https://raw.githubusercontent.com/adreeve/MiSTerManual/master/MISTer%20Manual.pdf

# Arcade Organizer
echo "Getting theypsilon update_arcade-organizer"
#get_installers update_arcade-organizer.sh https://raw.githubusercontent.com/MAME-GETTER/_arcade-organizer/master/update_arcade-organizer.sh
get_installers update_arcade-organizer.sh https://raw.githubusercontent.com/theypsilon/_arcade-organizer/master/update_arcade-organizer.sh

# Arcade Offset
echo "Getting atrac17 Arcade Offset"
get_installers arcade_offset_update.sh https://raw.githubusercontent.com/atrac17/Arcade_Offset/main/arcade_offset_update.sh

# flynnsbit eXoDOS Top 300
echo "Getting flynnsbit eXoDOS Top 300 for ao486"
get_installers AO486_Update_Top300_Pack.sh https://raw.githubusercontent.com/flynnsbit/Top300_updates/main/_mister/AO486_Update_Top300_Pack.sh
get_installers AO486_Update_Top300_Pack.ini https://raw.githubusercontent.com/flynnsbit/Top300_updates/main/_mister/AO486_Update_Top300_Pack.ini

# more addons 

# xow_Mister 
# echo "Getting xow_Mister Linux driver for the Xbox One wireless dongle compiled for MiSTer"
# get_addons xow.zip https://github.com/MiSTer-devel/xow_MiSTer/zipball/main/ xow
# mv xow xow_init_script ${BASE_DIR}/linux

# MiSTer_Duke
echo "Getting Hyperkin Duke controller support for the MiSTer FPGA"
get_addons MiSTer_Duke.zip https://github.com/Mellified/MiSTer_Duke/zipball/main/ MiSTer_Duke
mv duke_init_script ${BASE_DIR}/linux

# Mister Arcade Attract Mode
echo "Getting Mister Arcade Attract Mode from mrchrisster"
get_addons Attract_Arcade.zip https://github.com/mrchrisster/mister-arcade-attract/zipball/main/ Attract_Arcade

# Mister Attract Mode
echo "Getting Mister Attract Mode from mrchrisster"
get_addons Attract_Mode.zip https://github.com/mrchrisster/attract_mode/zipball/main/ Attract_Mode

# Mister Attract Mode
echo "Getting Mister NES Attract Mode from mrchrisster"
get_addons Attract_NES.zip https://github.com/mrchrisster/mister-nes-attract/zipball/master/ Attract_NES

# Super Attract Mode
echo "Getting Super Attract Mode from mrchrisster"
get_installers MiSTer_SAM_on.sh https://raw.githubusercontent.com/mrchrisster/MiSTer_SAM/main/MiSTer_SAM_on.sh
if [ ! -d /media/fat/Scripts/MiSTer_SAM ]
then
        mkdir /media/fat/Scripts/MiSTer_SAM
fi
mv MiSTer_SAM_on.sh /media/fat/Scripts/MiSTer_SAM

# MSU-1 core by dentnz (not official and latest core yet, but tested working)
# echo "MSU-1 core (tested working, read Instructions.txt)"
# get_addons2 MSU1_core.zip https://archive.org/download/mister-msu1-core/MSU1_core.zip MSU1_core
# cp -R -f * ${BASE_DIR}

# iniswitcher.sh by morfeus77
echo "iniswitcher.sh by morfeus77"
get_installers iniswitcher.sh https://raw.githubusercontent.com/morfeus77/MiSTerTools/main/iniswitcher.sh

# MiSTer Custom Aspect Ratios by meauxdal
echo "MiSTer Custom Aspect Ratios by meauxdal, please check README.md"
get_addons MiSTer_custom_aspect_ratios.zip https://github.com/meauxdal/MiSTer_Custom_Aspect_Ratios/zipball/main/MiSTer_custom_aspect_ratios

# MiSTer_WebMenu by nilp0inter
echo "Getting MiSTer_WebMenu"
get_std webmenu.sh https://raw.githubusercontent.com/nilp0inter/MiSTer_WebMenu/releases/download/v0.5.0/webmenu.sh MiSTer_WebMenu

# BGM by wizzomafizzo
echo "Getting bgm.sh"
get_addons bgm.sh https://raw.githubusercontent.com/wizzomafizzo/MiSTer_BGM/main/bgm.sh

# Favorites by wizzomafizzo
echo "Getting favortites.sh"
get_addons favortites.sh https://raw.githubusercontent.com/wizzomafizzo/MiSTer_Favorites/main/favorites.sh

# GemsMenu by wizzomafizzo
echo "Getting games_menu.sh"
get_addons games_menu.sh https://raw.githubusercontent.com/wizzomafizzo/MiSTer_Favorites/main/favorites.sh

echo " "
echo "***"
echo " "

echo " ======================================================================="
echo " Thanks goes to Locutus73, Retrodriven, theypsilon, bbond007, retrobrews"
echo " Boogerman, Owlnonymous, EXL, flynnsbit, mrchrisster, Mellified, adreeve"
echo " nilp0inter, wizzomafizzo and many more."
echo " "

echo "    _____  .__  ____________________           "
echo "   /     \ |__|/   _____/\__    ___/__________ "
echo "  /  \ /  \|  |\_____  \   |    |_/ __ \_  __ \\"
echo " /    Y    \  |/        \  |    |\  ___/|  | \/"
echo " \____|__  /__/_______  /  |____| \___  >__|   "
echo "         \/           \/              \/       "
echo " ======================================================================="

# Resources used:
# https://github.com/MiSTer-devel
# https://github.com/morfeus77/MiSTerTools
# https://github.com/mrchrisster/MiSTer_SAM
# https://github.com/adreeve/MiSTerManual
# https://github.com/Mellified/MiSTer_Duke
# https://github.com/mrchrisster/mister-arcade-attract
# https://github.com/retrobrews/installers
# https://github.com/misterkun-io/MiSTer_DeViL
# https://github.com/flynnsbit/Top300_updates
# https://github.com/theypsilon/Update_All_MiSTer
# https://github.com/MiSTer-devel/xow_MiSTer
# https://pastebin.com/raw/pM1XMe5E
# https://github.com/bbond007
# https://github.com/RetroDriven/MiSTerWallpapers
# https://github.com/meauxdal/MiSTer_Custom_Aspect_Ratios
# https://github.com/nilp0inter/MiSTer_WebMenu
# https://github.com/wizzomafizzo

exit 0

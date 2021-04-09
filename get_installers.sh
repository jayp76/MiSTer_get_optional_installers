#!/bin/bash

# Yet another random MiSTer utility script = YARMUS? LOL
#

# Version 1.6 - 2021-04-06 - added MiSTer Manual from adreeve
# Version 1.5c - 2021-04-06 - Code optimizations and some stuff deactivated
# Version 1.5b - 2021-04-06 - added MiSTer_Duke Hyperkin Duke controller support for the MiSTer FPGA
# Version 1.5a - 2021-03-31 - added xow_Mister Linux driver for the Xbox One wireless dongle compiled for MiSTer
# Version 1.5 - 2021-03-31 - added Mister Arcade Attract Mode and AO486_Update_Top300_Pack.ini
# Version 1.4 - 2021-01-28 - added flynnsbit eXoDOS Top 300 for ao486
# Version 1.3 - 2020-10-12 - added NX-Engine Cave Story port
# Version 1.2 - 2020-09-30 - added DevilutionX and Cannonball Ports, Best practice help text
# Version 1.1 - 2020-08-31 - added MiSTer Wiki download to #help folder and Owlnonymous Cheatsheet
# Version 1.0 - 2020-07-03 - First commit

BASE_DIR="/media/fat"  		#${BASE_DIR}
SVERSION="1.6"			#${SVERSION}
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

function get_Wiki {
  echo " ======================================================================="
  echo " Downloading Wiki into Help folder"


  [[ -d ${BASE_DIR}/#help ]] || mkdir -p ${BASE_DIR}/#help ; cd ${BASE_DIR}/#help
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
}


# Updaters

#echo "Getting RetroDriven_Update_Suite"
#get_installers RetroDriven_Update_Suite.sh https://raw.githubusercontent.com/RetroDriven/MiSTerUpdateSuite/master/RetroDriven_Update_Suite.sh

#echo "Getting RetroDriven_MAME_SE and .ini"
#get_installers Update_RetroDriven_MAME_SE.sh https://raw.githubusercontent.com/RetroDriven/MiSTerMAME/master/Update_RetroDriven_MAME_SE.sh
#get_installers Update_RetroDriven_MAME_SE.ini https://raw.githubusercontent.com/RetroDriven/MiSTerMAME/master/Update_RetroDriven_MAME_SE.ini

echo "Getting RetroDriven Update_MiSTerWallpapers and .ini"
get_installers Update_MiSTerWallpapers.sh https://raw.githubusercontent.com/RetroDriven/MiSTerWallpapers/master/Update_MiSTerWallpapers.sh
get_installers Update_MiSTerWallpapers.ini https://raw.githubusercontent.com/RetroDriven/MiSTerWallpapers/master/Update_MiSTerWallpapers.ini

#echo "Getting RetroDriven Update_MiSTerBIOS and .ini"
#get_installers Update_MiSTerBIOS.sh https://raw.githubusercontent.com/RetroDriven/MiSTerBIOS/master/Update_MiSTerBIOS.sh
#get_installers Update_MiSTerBIOS.ini https://raw.githubusercontent.com/RetroDriven/MiSTerBIOS/master/Update_MiSTerBIOS.ini

echo "Getting theypsilon update_all"
get_installers update_all.sh https://raw.githubusercontent.com/theypsilon/Update_All_MiSTer/master/update_all.sh


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

echo "Getting EXL/NX-Engine Cave Story Port"
get_installers get_cave.sh https://raw.githubusercontent.com/jayp76/MiSTer_get_optional_installers/master/misc/get_cave.sh

# Help and FAQ documents

echo "Getting Wiki as HTML"
get_Wiki MiSTer_Wiki.html.xz https://raw.githubusercontent.com/jayp76/MiSTer_get_optional_installers/master/MiSTer_FAQ/MiSTer_Wiki.html.xz
/bin/xz -d -v -f MiSTer_Wiki.html.xz

echo "Get Best Practice tips into your #help folder"
get_Wiki MiSTer_Best_Practice_for_installing_and_updating.txt https://raw.githubusercontent.com/jayp76/MiSTer_get_optional_installers/master/MiSTer_FAQ/MiSTer_Best_Practice_for_installing_and_updating.txt

echo "-=MiSTer Computer Cheat Sheet FAQ by Owlnonymous=-"
curl -ksLf https://pastebin.com/raw/pM1XMe5E > ${BASE_DIR}/#help/cheatsheet_$(date +"%Y_%m_%d").txt

echo "MiSTer Manual from adreeve"
get_Wiki MISTer_Manual.pdf https://raw.githubusercontent.com/adreeve/MiSTerManual/master/MISTer%20Manual.pdf

# Arcade Organizer
echo "Getting theypsilon update_arcade-organizer"
get_installers update_arcade-organizer.sh https://raw.githubusercontent.com/MAME-GETTER/_arcade-organizer/master/update_arcade-organizer.sh

# flynnsbit eXoDOS Top 300
echo "Getting flynnsbit eXoDOS Top 300 for ao486"
get_installers AO486_Update_Top300_Pack.sh https://raw.githubusercontent.com/flynnsbit/Top300_updates/main/_mister/AO486_Update_Top300_Pack.sh
get_installers AO486_Update_Top300_Pack.ini https://raw.githubusercontent.com/flynnsbit/Top300_updates/main/_mister/AO486_Update_Top300_Pack.ini

# more addons 

# Mister Arcade Attract Mode
echo "Getting Mister Arcade Attract Mode from mrchrisster"
get_addons Attract_Mode.zip https://github.com/mrchrisster/mister-arcade-attract/zipball/main/ Attract_Mode

# xow_Mister 
echo "Getting xow_Mister Linux driver for the Xbox One wireless dongle compiled for MiSTer"
get_addons xow.zip https://github.com/MiSTer-devel/xow_MiSTer/zipball/main/ xow
mv xow xow_init_script ${BASE_DIR}/linux

# MiSTer_Duke
echo "Getting Hyperkin Duke controller support for the MiSTer FPGA"
get_addons MiSTer_Duke.zip https://github.com/Mellified/MiSTer_Duke/zipball/main/ MiSTer_Duke
mv duke_init_script ${BASE_DIR}/linux



echo " "
echo "***"
echo " "

echo " ======================================================================="
echo " Thanks goes to Locutus73, Retrodriven, theypsilon, bbond007, retrobrews"
echo " Boogerman, Owlnonymous, EXL, flynnsbit, mrchrisster, Mellified, adreeve"
echo " "

echo "    _____  .__  ____________________           "
echo "   /     \ |__|/   _____/\__    ___/__________ "
echo "  /  \ /  \|  |\_____  \   |    |_/ __ \_  __ \\"
echo " /    Y    \  |/        \  |    |\  ___/|  | \/"
echo " \____|__  /__/_______  /  |____| \___  >__|   "
echo "         \/           \/              \/       "
echo " ======================================================================="

exit 0

#!/bin/bash

# Yet another random MiSTer utility script = YARMUS? LOL
#

# Version 1.3 - 2020-10-12 - added NX-Engine Cave Story port
# Version 1.2 - 2020-09-30 - added DevilutionX and Cannonball Ports, Best practice help text
# Version 1.1 - 2020-08-31 - added MiSTer Wiki download to #help folder and Owlnonymous Cheatsheet
# Version 1.0 - 2020-07-03 - First commit


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

function get_installers {
  echo " ======================================================================="
  echo " Downloading installer scripts, please wait..."


  [[ -d /media/fat/Scripts/installers ]] || mkdir -p /media/fat/Scripts/installers ; cd /media/fat/Scripts/installers
   curl ${CURL_RETRY} --insecure -o ${1} ${2}
   echo " "
   echo "***"
   echo " "
}

function get_Wiki {
  echo " ======================================================================="
  echo " Downloading Wiki into Help folder"


  [[ -d /media/fat/#help ]] || mkdir -p /media/fat/#help ; cd /media/fat/#help
   curl ${CURL_RETRY} --insecure -o ${1} ${2}
   echo " "
   echo "***"
   echo " "
}

# Updaters

echo "Getting RetroDriven_Update_Suite"
get_installers RetroDriven_Update_Suite.sh https://raw.githubusercontent.com/RetroDriven/MiSTerUpdateSuite/master/RetroDriven_Update_Suite.sh

echo "Getting RetroDriven_MAME_SE and .ini"
get_installers Update_RetroDriven_MAME_SE.sh https://raw.githubusercontent.com/RetroDriven/MiSTerMAME/master/Update_RetroDriven_MAME_SE.sh
get_installers Update_RetroDriven_MAME_SE.ini https://raw.githubusercontent.com/RetroDriven/MiSTerMAME/master/Update_RetroDriven_MAME_SE.ini

echo "Getting RetroDriven Update_MiSTerWallpapers and .ini"
get_installers Update_MiSTerWallpapers.sh https://raw.githubusercontent.com/RetroDriven/MiSTerWallpapers/master/Update_MiSTerWallpapers.sh
get_installers Update_MiSTerWallpapers.ini https://raw.githubusercontent.com/RetroDriven/MiSTerWallpapers/master/Update_MiSTerWallpapers.ini

echo "Getting RetroDriven Update_MiSTerBIOS and .ini"
get_installers Update_MiSTerBIOS.sh https://raw.githubusercontent.com/RetroDriven/MiSTerBIOS/master/Update_MiSTerBIOS.sh
get_installers Update_MiSTerBIOS.ini https://raw.githubusercontent.com/RetroDriven/MiSTerBIOS/master/Update_MiSTerBIOS.ini

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
curl -ksLf https://pastebin.com/raw/pM1XMe5E > /media/fat/#help/cheatsheet_$(date +"%Y_%m_%d").txt

# Arcade Organizer
echo "Getting theypsilon update_arcade-organizer"
get_installers update_arcade-organizer.sh https://raw.githubusercontent.com/MAME-GETTER/_arcade-organizer/master/update_arcade-organizer.sh


echo " "
echo "***"
echo " "

echo " ======================================================================="
echo " Thanks goes to Locutus73, Retrodriven, theypsilon, bbond007, retrobrews"
echo " Boogerman, Owlnonymous, EXL "


echo "    _____  .__  ____________________           "
echo "   /     \ |__|/   _____/\__    ___/__________ "
echo "  /  \ /  \|  |\_____  \   |    |_/ __ \_  __ \\"
echo " /    Y    \  |/        \  |    |\  ___/|  | \/"
echo " \____|__  /__/_______  /  |____| \___  >__|   "
echo "         \/           \/              \/       "
echo " ======================================================================="

exit 0

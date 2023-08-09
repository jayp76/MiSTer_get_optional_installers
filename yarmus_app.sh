#!/bin/bash

# Yet another random MiSTer utility script = YARMUS? LOL
#


# Version 1.0 - 2023-08-08 - First commit of refactored script with *.ini support

BASE_DIR="/media/fat"  		#${BASE_DIR}
SVERSION="1.0"			#${SVERSION}
URL="https://github.com"
RAWURL="https://raw.githubusercontent.com"
YARMUSCONF=${RAWURL}"/jayp76/MiSTer_get_optional_installers/refactoring/yarmus_config.ini" 

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
echo " "
sleep 4

# basepath/Scripts/installers
function get_updaters {
  echo " ======================================================================="
  echo " Downloading installer scripts, please wait..."


  [[ -d ${BASE_DIR}/Scripts/Update_Scripts ]] || mkdir -p ${BASE_DIR}/Scripts/Update_Scripts ; cd ${BASE_DIR}/Scripts/Update_Scripts
   curl ${CURL_RETRY} --insecure -o ${2} ${3}
   echo "Processing: " ${2}
   echo "***"
   echo " "
}

# basepath/Scripts/appname
function get_addons {
  echo " ======================================================================="
  echo " Downloading ${2}..."

  [[ -d ${BASE_DIR}/Scripts/Addons/${1} ]] || mkdir -p ${BASE_DIR}/Scripts/Addons/${1} ; cd ${BASE_DIR}/Scripts/Addons/${1}
   curl ${CURL_RETRY} --insecure -L -o ${2} ${3}
   echo "Processing: " ${2}
   echo "***"
   echo " "
}

# basepath/docs
function get_Wiki {
  echo " ======================================================================="
  echo " Downloading Wiki and FAQ's into "docs" folder"


  [[ -d ${BASE_DIR}/${1} ]] || mkdir -p ${BASE_DIR}/${1}  ; cd ${BASE_DIR}/${1} 
   curl ${CURL_RETRY} --insecure -o ${2} ${3}
   echo "Processing: " ${2}
   echo "***"
   echo " "
}

function get_games {
  echo " ======================================================================="
  echo " Downloading Games "


  [[ -d ${BASE_DIR}/Scripts/Games/${1} ]] || mkdir -p ${BASE_DIR}/Scripts/Games/${1} ; cd ${BASE_DIR}/Scripts/Games/${1}
   curl ${CURL_RETRY} --insecure -L -o ${2} ${3}
   #unzip -j -o ${BASE_DIR}/Scripts/Games/${1}/${2}
   #rm ${BASE_DIR}/Scripts/Games/${1}/${2}
   echo "Processing: " ${2}
   echo "***"
   echo " "
   #sleep 5
}

# basepath/Scripts/appname + unzip
function get_addons_z {
  echo " ======================================================================="
  echo " Downloading Addons"


  [[ -d ${BASE_DIR}/Scripts/Addons/${1} ]] || mkdir -p ${BASE_DIR}/Scripts/Addons/${1} ; cd ${BASE_DIR}/Scripts/Addons/${1}
   curl ${CURL_RETRY} --insecure -L -o ${2} ${3}
   unzip -j -o ${BASE_DIR}/Scripts/Addons/${1}/${2}
   #rm ${BASE_DIR}/Scripts/Addons/${1}/${2}
   echo "Processing: " ${2}
   echo "***"
   echo " "
   #sleep 5
}




# basepath/Scripts/appname + 7z unzip
function get_addons_7z {
  echo " ======================================================================="
  echo " Downloading Addons"


  [[ -d ${BASE_DIR}/Scripts/Addons/${1} ]] || mkdir -p ${BASE_DIR}/Scripts/Addons/${1} ; cd ${BASE_DIR}/Scripts/Addons/${1}
   curl ${CURL_RETRY} --insecure -L -o ${2} ${3}
   7zr x -y -o{3} ${BASE_DIR}/Scripts/Addons/${1}/${2}
   rm ${BASE_DIR}/Scripts/Addons/${1}/${2}
   echo "Processing: " ${2}
   echo "***"
   echo " "
   #sleep 5
}

# Check if the primary ini file exists, if not, use the alternative ini file
if [ -f "config.ini" ]; then
    echo " Using local ini file "
    echo " "
    ini_file="yarmus_config.ini"
else
    # wget/curl alternative config to tmp folder
    echo " Downloading Standard ini file "
    echo " "
    cd /tmp
    curl ${CURL_RETRY} --insecure -L -o yarmus_config.ini ${YARMUSCONF}
    if [ -f "/tmp/yarmus_config.ini" ]; then
        ini_file="/tmp/yarmus_config.ini"
    else
        echo "Error: Both config.ini and alternative_config.ini files not found!"
        exit 1
    fi
fi

# Read the ini file and execute functions based on the contents
while IFS=, read -r skip_value function param2 param3 param4 param5; do
    if [[ "$skip_value" == "true" ]]; then
        case "$function" in
            "get_updaters") get_updaters "$param2" "$param3" "$param4" ;;
	    "get_games") get_games "$param2" "$param3" "$param4" ;;
            "get_Wiki") get_Wiki "$param2" "$param3" "$param4" ;;
            "get_addons") get_addons "$param2" "$param3" "$param4" ;;
	    "get_addons_z") get_addons_z "$param2" "$param3" "$param4" ;;
            "get_addons_7z") get_addons_7z "$param2" "$param3" "$param4" ;;
        esac
#    else
#	echo "Skipped line with parameters: $skip_value, $function_num, $param2, $param3, $param4, $param5"
    fi
done < "$ini_file"

# cleanup
#rm -f /tmp/yarmus_config.ini

echo " "
echo "***"
echo " "

echo " ======================================================================="
echo " Thanks goes to Locutus73, Retrodriven, theypsilon, bbond007, retrobrews"
echo " Boogerman, Owlnonymous, EXL, flynnsbit, mrchrisster, Mellified, adreeve"
echo " nilp0inter, wizzomafizzo, funkycochise and many more."
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
# https://github.com/funkycochise/Coin-Op
# https://github.com/MiSTer-devel/Distribution_MiSTer


exit 0

#!/usr/bin/env bash
# GET YARMUS!!!!

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Copyright 2019-2020 Alessandro "Locutus73" Miele --- many thanks to Alessandro "Locutus73" Miele

# You can download the latest version of this script from:
# https://github.com/jayp76/MiSTer_get_optional_installers

# Version 1.0 - 2023-08-15 - First commit


# ========= OPTIONS ==================
URL="https://github.com"
SCRIPT_URL="${URL}/jayp76/MiSTer_get_optional_installers/blob/master/yarmus_app.sh"
CURL_RETRY="--connect-timeout 15 --max-time 120 --retry 3 --retry-delay 5 --silent --show-error"
RAWURL="https://raw.githubusercontent.com"
YARMUSCONF=${RAWURL}"/jayp76/MiSTer_get_optional_installers/master/yarmus_config.ini" 
SCRIPTS_PATH="/media/fat/Scripts"

# ========= ADVANCED OPTIONS =========
# ALLOW_INSECURE_SSL="true" will check if SSL certificate verification (see https://curl.haxx.se/docs/sslcerts.html )
# is working (CA certificates installed) and when it's working it will use this feature for safe curl HTTPS downloads,
# otherwise it will use --insecure option for disabling SSL certificate verification.
# If CA certificates aren't installed it's advised to install them (i.e. using security_fixes.sh).
# ALLOW_INSECURE_SSL="false" will never use --insecure option and if CA certificates aren't installed
# any download will fail.
ALLOW_INSECURE_SSL="true"

# ========= CODE STARTS HERE =========
# get the name of the script, or of the parent script if called through a 'curl ... | bash -'
#ORIGINAL_SCRIPT_PATH="${0}"
#[[ "${ORIGINAL_SCRIPT_PATH}" == "bash" ]] && \
#	ORIGINAL_SCRIPT_PATH="$(ps -o comm,pid | awk -v PPID=${PPID} '$2 == PPID {print $1}')"
# echo "orig ${ORIGINAL_SCRIPT_PATH}"

# ini file can contain user defined variables (as bash commands)
# Load and execute the content of the ini file, if there is one
#INI_PATH="${ORIGINAL_SCRIPT_PATH%.*}.ini"
#SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
#echo ${INI_PATH}
#echo ${SCRIPT_DIR}
#if [[ -f "${SCRIPT_DIR}/${INI_PATH}" ]] ; then
#	TMP=$(mktemp)
#	# preventively eliminate DOS-specific format and exit command  
#	dos2unix < "${SCRIPT_DIR}/${INI_PATH}" 2> /dev/null | grep -v "^exit" > ${TMP}
#	source ${TMP}
#	echo ${TMP}
#	rm -f ${TMP}
#fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# Check if the primary ini file exists, if not, use the alternative ini file
if [ -f "${SCRIPT_DIR}/yarmus_config.ini" ]; then
    #echo " Using local ini file "
    echo " "
    #ini_file="${SCRIPTS_PATH}/yarmus_config.ini"
    #echo "local: ${SCRIPT_DIR}/yarmus_config"
else
    # wget/curl alternative config to tmp folder
    echo "No ini file found.!"
    echo "Downloading ini file "
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

# test network and https by pinging the target website 
SSL_SECURITY_OPTION=""
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

# download and execute the latest script
echo "Downloading and executing script"
echo "${SCRIPT_URL/*\//}"
echo ""
curl \
	${CURL_RETRY} \
	${SSL_SECURITY_OPTION} \
	--fail \
	--location \
	"${SCRIPT_URL}?raw=true" | \
	bash -s "${SCRIPT_DIR}" 

echo " "

exit 0

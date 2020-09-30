#!/usr/bin/env bash
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

function get_cannonball {
  echo " ======================================================================="
  echo " Downloading Cannonball, please wait..."


  [[ -d /media/fat/Cannonball ]] || mkdir -p /media/fat/Cannonball ; cd /media/fat/Cannonball
   curl ${CURL_RETRY} --insecure -o ${1} ${2}
   echo " "
   echo "***"
   echo " "
}

echo "Getting Cannonball"
get_cannonball cannonball.7z 'https://docs.google.com/uc?export=download&id=10AuxYS48DkEy2xkqTBaIgMgcBw7cMW9T'
get_cannonball 7za https://https//raw.githubusercontent.com/develar/7zip-bin//master/linux/arm/7za
chmod +x 7za
mv Cannonball-OutRun.sh /media/fat/Scripts
mv Cannonball-OutRun.sh /medai/fat/Scripts/Games

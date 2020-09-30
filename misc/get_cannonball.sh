#!/bin/bash
[[ -d /media/fat/Cannonball ]] || mkdir -p /media/fat/Cannonball ; cd /media/fat/Cannonball
echo "Getting Cannonball"
curl -ksJLO --insecure "https://docs.google.com/uc?export=download&id=10AuxYS48DkEy2xkqTBaIgMgcBw7cMW9T"
curl -LJO --insecure https://raw.githubusercontent.com/develar/7zip-bin//master/linux/arm/7za
cd /media/fat/Cannonball
chmod +x 7za
./7za x ./cannonball.7z
cp ./Cannonball-OutRun.sh /media/fat/Scripts
mv ./Cannonball-OutRun.sh /media/fat/Scripts/Games

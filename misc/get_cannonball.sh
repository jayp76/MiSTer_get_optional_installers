#!/bin/bash
cd /media/fat
echo "Getting Cannonball"
curl -ksJLO --insecure "https://docs.google.com/uc?export=download&id=10AuxYS48DkEy2xkqTBaIgMgcBw7cMW9T"
curl -LJO --insecure https://raw.githubusercontent.com/develar/7zip-bin//master/linux/arm/7za
chmod +x 7za
./7za x ./cannonball.7z
cp ./Cannonball-OutRun.sh /media/fat/Scripts
mv ./Cannonball-OutRun.sh /media/fat/Scripts/Games
rm /media/fat/cannonball.7z
rm /media/fat/7za

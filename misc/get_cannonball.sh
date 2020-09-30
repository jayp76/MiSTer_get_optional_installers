#!/usr/bin/env bash
[[ -d /media/fat/Cannonball ]] || mkdir -p /media/fat/Cannonball ; cd /media/fat/Cannonball
echo "Getting Cannonball"
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=10AuxYS48DkEy2xkqTBaIgMgcBw7cMW9T' -O cannonball.7z
wget --no-check-certificate https://https//raw.githubusercontent.com/develar/7zip-bin//master/linux/arm/7za
chmod +x 7za
7za x cannonball.7z
mv Cannonball-OutRun.sh /media/fat/Scripts
mv Cannonball-OutRun.sh /medai/fat/Scripts/Games

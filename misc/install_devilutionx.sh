#!/usr/bin/env bash
#Copy DIABDAT.MPQ from the original Diablo game disc or the GOG version to the Diablo folder on your SD Card.
echo "Copy DIABDAT.MPQ from the original Diablo game disc or the GOG version to the Diablo folder on your SD Card."
wget -qO- https://github.com/misterkun-io/MiSTer_DeViL/raw/master/releases/Arm-DevilutionX_0.5.0.zip | busybox unzip - -d /media/fat

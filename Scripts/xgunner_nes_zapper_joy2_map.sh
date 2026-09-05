#!/bin/sh
set -eu

SRC="/media/fat/config/inputs/NES_input_1209_0001_v3.zapper.map"
DST="/media/fat/config/inputs/NES_input_1209_0001_v3.map"
RADST="/media/fat/config/inputs/RA_NES_input_1209_0001_v3.map"
CFG="/media/fat/config/NES.zapper_joy2.CFG"
CFGDST="/media/fat/config/NES.CFG"
RACFG="/media/fat/config/RA_NES.zapper_joy2.CFG"
RACFGDST="/media/fat/config/RA_NES.CFG"

cp "$SRC" "$DST"
cp "$SRC" "$RADST"
cp "$CFG" "$CFGDST"
cp "$RACFG" "$RACFGDST"
sync
echo "X-GUNNER NES map set to Zapper using Joy2 source"
echo "X-GUNNER RA_NES config set to Zapper using Joy2 source"
echo "Use this only if the X-GUNNER is assigned as MiSTer player 2"
echo "Trigger: Zapper/Vaus button"

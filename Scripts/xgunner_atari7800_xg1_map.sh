#!/bin/sh
set -eu

SRC="/media/fat/config/inputs/Atari7800_input_1209_0001_v3.xg1.map"
DST="/media/fat/config/inputs/Atari7800_input_1209_0001_v3.map"
RADST="/media/fat/config/inputs/RA_Atari7800_input_1209_0001_v3.map"
CFG="/media/fat/config/Atari7800.xg1.CFG"
CFGDST="/media/fat/config/Atari7800.CFG"
RACFG="/media/fat/config/RA_Atari7800.xg1.CFG"
RACFGDST="/media/fat/config/RA_Atari7800.CFG"

cp "$SRC" "$DST"
cp "$SRC" "$RADST"
cp "$CFG" "$CFGDST"
cp "$RACFG" "$RACFGDST"
sync
echo "X-GUNNER Atari 7800 map set to XG-1"
echo "X-GUNNER RA_Atari7800 config set to XG-1"
echo "Trigger: Fire 1"

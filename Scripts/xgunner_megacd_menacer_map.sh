#!/bin/sh
set -eu

SRC="/media/fat/config/inputs/MegaCD_input_1209_0001_v3.menacer.map"
DST="/media/fat/config/inputs/MegaCD_input_1209_0001_v3.map"
RADST="/media/fat/config/inputs/RA_MegaCD_input_1209_0001_v3.map"
CFG="/media/fat/config/MegaCD.menacer.CFG"
CFGDST="/media/fat/config/MegaCD.CFG"
RACFG="/media/fat/config/RA_MegaCD.menacer.CFG"
RACFGDST="/media/fat/config/RA_MegaCD.CFG"

cp "$SRC" "$DST"
cp "$SRC" "$RADST"
cp "$CFG" "$CFGDST"
cp "$RACFG" "$RACFGDST"
sync
echo "X-GUNNER MegaCD map set to Menacer"
echo "X-GUNNER RA_MegaCD config set to Menacer"
echo "Trigger: A"
echo "Right button: B"
echo "Middle button: C"
echo "Front button: Start"

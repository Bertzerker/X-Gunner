#!/bin/sh
set -eu

SRC="/media/fat/config/inputs/SNES_input_1209_0001_v3.justifier.map"
DST="/media/fat/config/inputs/SNES_input_1209_0001_v3.map"
RADST="/media/fat/config/inputs/RA_SNES_input_1209_0001_v3.map"
CFG="/media/fat/config/SNES.justifier.CFG"
CFGDST="/media/fat/config/SNES.CFG"
RACFG="/media/fat/config/RA_SNES.justifier.CFG"
RACFGDST="/media/fat/config/RA_SNES.CFG"

cp "$SRC" "$DST"
cp "$SRC" "$RADST"
cp "$CFG" "$CFGDST"
cp "$RACFG" "$RACFGDST"
sync
echo "X-GUNNER SNES map set to Justifier"
echo "X-GUNNER RA_SNES config set to Justifier"
echo "Trigger: Fire"
echo "Right button: Start"

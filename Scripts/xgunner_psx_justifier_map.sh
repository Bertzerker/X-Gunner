#!/bin/sh
set -eu

SRC="/media/fat/config/inputs/PSX_input_1209_0001_v3.justifier.map"
DST="/media/fat/config/inputs/PSX_input_1209_0001_v3.map"
RADST="/media/fat/config/inputs/RA_PSX_input_1209_0001_v3.map"

cp "$SRC" "$DST"
cp "$SRC" "$RADST"
sync
echo "X-GUNNER PSX map set to Justifier"
echo "Trigger: Circle/Shoot"
echo "Right button: X/Special"
echo "Middle button: Triangle/Reload"
echo "Keyboard-side other button: Start"

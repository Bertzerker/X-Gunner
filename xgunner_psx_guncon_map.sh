#!/bin/sh
set -eu

SRC="/media/fat/config/inputs/PSX_input_1209_0001_v3.guncon.map"
DST="/media/fat/config/inputs/PSX_input_1209_0001_v3.map"
RADST="/media/fat/config/inputs/RA_PSX_input_1209_0001_v3.map"

cp "$SRC" "$DST"
cp "$SRC" "$RADST"
sync
echo "X-GUNNER PSX map set to GunCon"
echo "Trigger: Circle/Shoot"
echo "Right button: Start/Gun A"
echo "Middle button: X/Gun B"

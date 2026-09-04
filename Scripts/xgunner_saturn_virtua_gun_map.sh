#!/bin/sh
set -eu

SRC="/media/fat/config/inputs/Saturn_input_1209_0001_v3.virtua_gun.map"
DST="/media/fat/config/inputs/Saturn_input_1209_0001_v3.map"
RADST="/media/fat/config/inputs/RA_Saturn_input_1209_0001_v3.map"
CDDST="/media/fat/config/inputs/A0CD-Saturn_input_1209_0001_v3.map"

cp "$SRC" "$DST"
cp "$SRC" "$RADST"
cp "$SRC" "$CDDST"
sync
echo "X-GUNNER Saturn map set to Virtua Gun"
echo "Trigger: A/Shoot"
echo "Front button: Start"
echo "Right button: B"
echo "Middle button: C"

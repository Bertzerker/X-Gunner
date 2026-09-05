#!/bin/sh
set -eu

SRC="/media/fat/config/inputs/S32X_input_1209_0001_v3.lightgun.map"
DST="/media/fat/config/inputs/S32X_input_1209_0001_v3.map"
RADST="/media/fat/config/inputs/RA_S32X_input_1209_0001_v3.map"

cp "$SRC" "$DST"
cp "$SRC" "$RADST"
sync
echo "X-GUNNER S32X map set to lightgun"
echo "X-GUNNER RA_S32X config set to lightgun"
echo "Trigger: A"
echo "Right button: B"
echo "Middle button: C"
echo "Front button: Start"

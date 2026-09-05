#!/bin/sh
set -eu

SRC="/media/fat/config/inputs/SMS_input_1209_0001_v3.phaser.map"
DST="/media/fat/config/inputs/SMS_input_1209_0001_v3.map"
RADST="/media/fat/config/inputs/RA_SMS_input_1209_0001_v3.map"
CFG="/media/fat/config/SMS.phaser.CFG"
CFGDST="/media/fat/config/SMS.CFG"
RACFG="/media/fat/config/RA_SMS.phaser.CFG"
RACFGDST="/media/fat/config/RA_SMS.CFG"

cp "$SRC" "$DST"
cp "$SRC" "$RADST"
cp "$CFG" "$CFGDST"
cp "$RACFG" "$RACFGDST"
sync
echo "X-GUNNER SMS map set to Phaser"
echo "X-GUNNER RA_SMS config set to Phaser"
echo "Trigger: Fire 1"

#!/bin/sh
set -eu

INPUT_DIR="/media/fat/config/inputs"
CONFIG_DIR="/media/fat/config"

copy_if_exists() {
  src="$1"
  dst="$2"
  if [ -f "$src" ]; then
    cp "$src" "$dst"
    echo "Updated $dst"
  else
    echo "Missing $src"
  fi
}

set_psx_profile() {
  profile="$1"
  copy_if_exists "$INPUT_DIR/PSX_input_1209_0001_v3.$profile.map" "$INPUT_DIR/PSX_input_1209_0001_v3.map"
  copy_if_exists "$INPUT_DIR/RA_PSX_input_1209_0001_v3.$profile.map" "$INPUT_DIR/RA_PSX_input_1209_0001_v3.map"
  copy_if_exists "$INPUT_DIR/PSX_2XCPU_input_1209_0001_v3.$profile.map" "$INPUT_DIR/PSX_2XCPU_input_1209_0001_v3.map"
  copy_if_exists "$INPUT_DIR/PSX2XCPU_input_1209_0001_v3.$profile.map" "$INPUT_DIR/PSX2XCPU_input_1209_0001_v3.map"
  copy_if_exists "$CONFIG_DIR/PSX.$profile.CFG" "$CONFIG_DIR/PSX.CFG"
  copy_if_exists "$CONFIG_DIR/RA_PSX.$profile.CFG" "$CONFIG_DIR/RA_PSX.CFG"
  copy_if_exists "$CONFIG_DIR/PSX_2XCPU.$profile.CFG" "$CONFIG_DIR/PSX_2XCPU.CFG"
  copy_if_exists "$CONFIG_DIR/PSX2XCPU.$profile.CFG" "$CONFIG_DIR/PSX2XCPU.CFG"
}

set_pair_profile() {
  base="$1"
  ra_base="$2"
  profile="$3"
  copy_if_exists "$INPUT_DIR/${base}_input_1209_0001_v3.$profile.map" "$INPUT_DIR/${base}_input_1209_0001_v3.map"
  copy_if_exists "$INPUT_DIR/${ra_base}_input_1209_0001_v3.$profile.map" "$INPUT_DIR/${ra_base}_input_1209_0001_v3.map"
  copy_if_exists "$CONFIG_DIR/${base}.$profile.CFG" "$CONFIG_DIR/${base}.CFG"
  copy_if_exists "$CONFIG_DIR/${ra_base}.$profile.CFG" "$CONFIG_DIR/${ra_base}.CFG"
}

set_saturn_profile() {
  copy_if_exists "$INPUT_DIR/Saturn_input_1209_0001_v3.virtua_gun.map" "$INPUT_DIR/Saturn_input_1209_0001_v3.map"
  copy_if_exists "$INPUT_DIR/RA_Saturn_input_1209_0001_v3.virtua_gun.map" "$INPUT_DIR/RA_Saturn_input_1209_0001_v3.map"
  copy_if_exists "$INPUT_DIR/A0CD-Saturn_input_1209_0001_v3.virtua_gun.map" "$INPUT_DIR/A0CD-Saturn_input_1209_0001_v3.map"
}

show_arcade_profile() {
  cat <<'EOF'
Arcade maps are selected automatically by MRA setname.

X-GUNNER arcade layout:
  Trigger: shoot/fire
  Mouse2: secondary weapon when the core exposes one
  Mouse3: reserved for reload/offscreen shot
  Space: OSD menu
  BTN_START: Start
  5/e: B button when the core exposes one
  s: Coin/Select
  w: Pause when the core exposes one
  Enter: not mapped; remap it in the X-GUNNER GUI before using it

Configured sets include Colt, N.Y. Captor, Bronx, Operation Wolf variants,
Laser Ghost variants, Point Blank 2 variants, and Gunbarl.
EOF
}

show_menu() {
  cat <<'EOF'
Choose X-GUNNER profile:
  1) PSX GunCon
  2) PSX Justifier
  3) Saturn Virtua Gun
  4) NES Zapper
  5) SNES Super Scope
  6) SNES Justifier
  7) Genesis lightgun
  8) MegaCD Justifier
  9) MegaCD Menacer
  10) S32X lightgun
  11) SMS Phaser
  12) Atari 7800 XG-1
  13) Arcade setname maps
EOF
  printf "Profile number: "
  read -r choice
  case "$choice" in
    1) profile="psx-guncon" ;;
    2) profile="psx-justifier" ;;
    3) profile="saturn" ;;
    4) profile="nes" ;;
    5) profile="snes-super-scope" ;;
    6) profile="snes-justifier" ;;
    7) profile="genesis" ;;
    8) profile="megacd-justifier" ;;
    9) profile="megacd-menacer" ;;
    10) profile="s32x" ;;
    11) profile="sms" ;;
    12) profile="atari7800" ;;
    13) profile="arcade" ;;
    *) echo "Unknown profile number: $choice"; exit 1 ;;
  esac
}

profile="${1:-}"
[ -n "$profile" ] || show_menu

case "$profile" in
  psx-guncon|guncon)
    set_psx_profile "guncon"
    echo "PSX GunCon: trigger=shoot, mouse2=GunCon A, mouse3=reserved reload/offscreen, 5/e=GunCon B"
    ;;
  psx-justifier|justifier)
    set_psx_profile "justifier"
    echo "PSX Justifier: trigger=shoot, mouse2=special, mouse3=reserved reload/offscreen, BTN_START=Start, Space=OSD"
    ;;
  saturn|saturn-virtua-gun|virtua-gun)
    set_saturn_profile
    echo "Saturn Virtua Gun: trigger=A/shoot, mouse2=B, mouse3=reserved reload/offscreen, BTN_START=Start, 5/e=C, Space=OSD"
    ;;
  nes|nes-zapper)
    set_pair_profile "NES" "RA_NES" "zapper"
    echo "NES Zapper: trigger=shoot, mouse3=reserved reload/offscreen"
    ;;
  nes-zapper-joy2)
    copy_if_exists "$INPUT_DIR/NES_input_1209_0001_v3.zapper.map" "$INPUT_DIR/NES_input_1209_0001_v3.map"
    copy_if_exists "$INPUT_DIR/RA_NES_input_1209_0001_v3.zapper.map" "$INPUT_DIR/RA_NES_input_1209_0001_v3.map"
    copy_if_exists "$CONFIG_DIR/NES.zapper_joy2.CFG" "$CONFIG_DIR/NES.CFG"
    copy_if_exists "$CONFIG_DIR/RA_NES.zapper_joy2.CFG" "$CONFIG_DIR/RA_NES.CFG"
    echo "NES Zapper Joy2 source profile selected"
    ;;
  snes-super-scope|super-scope)
    set_pair_profile "SNES" "RA_SNES" "super_scope"
    echo "SNES Super Scope: trigger=Fire, mouse2=Cursor, mouse3=reserved reload/offscreen, w=Pause"
    ;;
  snes-justifier)
    set_pair_profile "SNES" "RA_SNES" "justifier"
    echo "SNES Justifier: trigger=Fire, mouse2=secondary, mouse3=reserved reload/offscreen"
    ;;
  genesis|megadrive)
    set_pair_profile "Genesis" "RA_MegaDrive" "lightgun"
    echo "Genesis/Mega Drive: trigger=A, mouse2=B, mouse3=reserved reload/offscreen, BTN_START=Start, 5/e=C, Space=OSD"
    ;;
  megacd-justifier|segacd-justifier)
    set_pair_profile "MegaCD" "RA_MegaCD" "justifier"
    echo "MegaCD Justifier: trigger=A, mouse2=B, mouse3=reserved reload/offscreen, BTN_START=Start, 5/e=C, Space=OSD"
    ;;
  megacd-menacer|segacd-menacer)
    set_pair_profile "MegaCD" "RA_MegaCD" "menacer"
    echo "MegaCD Menacer: trigger=A, mouse2=B, mouse3=reserved reload/offscreen, BTN_START=Start, 5/e=C, Space=OSD"
    ;;
  s32x)
    set_pair_profile "S32X" "RA_S32X" "lightgun"
    echo "S32X: trigger=A, mouse2=B, mouse3=reserved reload/offscreen, BTN_START=Start, 5/e=C, Space=OSD"
    ;;
  sms|sms-phaser)
    set_pair_profile "SMS" "RA_SMS" "phaser"
    echo "SMS Phaser: trigger=Fire 1, mouse3=reserved reload/offscreen"
    ;;
  atari7800|xg1)
    set_pair_profile "Atari7800" "RA_Atari7800" "xg1"
    echo "Atari 7800 XG-1: trigger=Fire 1, mouse3=reserved reload/offscreen"
    ;;
  arcade|colt|nycaptor|bronx|opwolf|lghost|ptblank2|gunbarl)
    show_arcade_profile
    ;;
  *)
    echo "Unknown profile: $profile"
    echo "Run without arguments for the menu."
    exit 1
    ;;
esac

sync

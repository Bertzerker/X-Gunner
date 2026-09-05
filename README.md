# X-GUNNER on MiSTer FPGA

This is a public test package for using the X-GUNNER LCD lightgun on MiSTer FPGA.

The included Main_MiSTer patch adds native detection for the X-GUNNER USB IDs and treats the gun's absolute mouse interface as a MiSTer lightgun. The package also includes map files and helper scripts for the cores that have been mapped so far.

Build instructions are in `BUILD.md`. Python helper requirements are in `REQUIREMENTS.txt`. Console lightgun profile notes are in `LIGHTGUN_CORES.md`.

## Status

Implemented and packaged:

- Native Main_MiSTer lightgun detection patch for X-GUNNER P1-P4 USB IDs.
- A current patched Main_MiSTer binary for testers: `Main_MiSTer/binaries/MiSTer-xgunner-startfix-20260904`.
- A current patched RetroAchievements Main_MiSTer binary for testers: `Main_MiSTer/binaries/MiSTer_RA-xgunner-v1.12.1-20260905`.
- A temporary uinput shim for testing on stock Main_MiSTer.
- PSX GunCon and Justifier input maps.
- PSX unstable `.rbf` file used during testing.
- Saturn Virtua Gun input maps.
- Saturn `.rbf` and `.CFG` files used during testing.
- NES Zapper configs and input maps for normal and RetroAchievements cores.
- SNES Super Scope and Justifier configs and input maps for normal and RetroAchievements cores.
- Genesis/Mega Drive, MegaCD/Sega CD, and S32X lightgun configs and input maps for normal and RetroAchievements cores.
- SMS Phaser configs and input maps for normal and RetroAchievements cores.
- Atari 7800 XG-1 configs and input maps for normal and RetroAchievements cores.

Not included:

- The separate input control mapper script. That tool is still experimental and is not part of this repository.
- RetroAchievements core `.rbf` files other than specific test binaries documented below. The config and map files target the RA core names, but users should install RA cores from their normal RA source.

## X-GUNNER Device IDs

The X-GUNNER manual lists one USB product ID per player:

- P1: `1209:0001`
- P2: `1209:0002`
- P3: `1209:0003`
- P4: `1209:0004`

The tested P1 gun appeared as these Linux input interfaces:

- `HONGWEIHUA XGUNNER-P1 Keyboard`
- `HONGWEIHUA XGUNNER-P1 Mouse`
- `HONGWEIHUA XGUNNER-P1`

The important interface is the `Mouse` device. It reports absolute `ABS_X` and `ABS_Y` coordinates from `0` to `32767`, plus mouse button events.

## How The Main_MiSTer Patch Works

The patch is in `Main_MiSTer/patches/Main_MiSTer-xgunner-lightgun.patch`.

It changes `input.cpp` and `menu.cpp` in Main_MiSTer:

- Adds `input_is_xgunner()` to recognize VID `1209` with PID `0001` through `0004`.
- Requires the device name or ID string to contain `XGUNNER`, so the patch does not match every `1209:*` device blindly.
- Adds `input_xgunner_setup()` to mark the device as `QUIRK_LIGHTGUN_MOUSE`.
- Marks the device as a MiSTer lightgun and assigns the player number from the product ID.
- Sets the default calibration range to X/Y `0` through `32767`, matching the observed absolute axis range.
- Calls the X-GUNNER setup both during normal input detection and after MiSTer merges related input interfaces.
- Converts X-GUNNER `KEY_5` into `BTN_START`, because the gun exposes some controls through its keyboard interface.
- Stops raw X-GUNNER absolute-axis events from advancing the lightgun calibration menu before a button press.
- Adds a calibration debounce timer: 750 ms when entering calibration, then 350 ms after each accepted calibration edge.

The debounce matters because the gun can report tracking and button transitions immediately when the calibration screen appears. Without the delay, MiSTer can skip through calibration points too quickly.

## Current Test Binary

Use this binary for the latest packaged native test:

```sh
Main_MiSTer/binaries/MiSTer-xgunner-startfix-20260904
```

SHA-256:

```sh
867ffc1f2c297612a0f6ceab9cb7f93f2c903c0cb42bb20fe8d2169dda86e231
```

Older binaries are kept in the repository only as build history while testing:

- `Main_MiSTer/binaries/MiSTer-xgunner-20260903`
- `Main_MiSTer/binaries/MiSTer-xgunner-debounce-20260903`
- `Main_MiSTer/binaries/MiSTer-xgunner-p1assign-20260903`
- `Main_MiSTer/binaries/MiSTer-xgunner-splitfix-20260904`
- `Main_MiSTer/binaries/MiSTer-xgunner-analogfix-20260904`

RetroAchievements Main_MiSTer test binary:

```sh
Main_MiSTer/binaries/MiSTer_RA-xgunner-v1.12.1-20260905
```

SHA-256:

```sh
32e8e3c32c47ddfd63e88bd8aa9a7e5c58ae86e3bf2fed81e669890a7f59fef3
```

## Tested And Mapped Cores

PSX and Saturn have direct local testing notes below. The additional NES, SNES, Genesis/Mega Drive, MegaCD/Sega CD, S32X, SMS, and Atari 7800 profiles are configured from MiSTer's published lightgun documentation and core option strings, and need wider testing on real games.

### PSX

Mapped profiles:

- `config/inputs/PSX_input_1209_0001_v3.guncon.map`
- `config/inputs/PSX_input_1209_0001_v3.justifier.map`
- `config/inputs/RA_PSX_input_1209_0001_v3.guncon.map`
- `config/inputs/RA_PSX_input_1209_0001_v3.justifier.map`

Active/default map in the package:

- `config/inputs/PSX_input_1209_0001_v3.map`
- `config/inputs/RA_PSX_input_1209_0001_v3.map`

RetroAchievements PSX config profiles:

- `config/RA_PSX.guncon.CFG`
- `config/RA_PSX.justifier.CFG`
- `config/RA_PSX.CFG`

Helper scripts:

```sh
sh /media/fat/Scripts/xgunner_psx_guncon_map.sh
sh /media/fat/Scripts/xgunner_psx_justifier_map.sh
```

GunCon profile:

- Trigger: `Circle` / shoot
- Right button: `Start` / Gun A
- Middle button: `X` / Gun B

Justifier profile:

- Trigger: `Circle` / shoot
- Right button: `X` / special
- Middle button: `Triangle` / reload
- Keyboard-side other button: `Start`

In the PSX core OSD, set `Pad1` to `GunCon` or `Justifier` to match the game, then use the matching helper script or copy the matching `.map` file into place.

Included PSX core file:

- `_Console/PSX_unstable_20260821_19f225.rbf`

### Saturn

Mapped profile:

- `config/inputs/Saturn_input_1209_0001_v3.virtua_gun.map`

Active/default maps in the package:

- `config/inputs/Saturn_input_1209_0001_v3.map`
- `config/inputs/RA_Saturn_input_1209_0001_v3.map`
- `config/inputs/A0CD-Saturn_input_1209_0001_v3.map`

Helper script:

```sh
sh /media/fat/Scripts/xgunner_saturn_virtua_gun_map.sh
```

Virtua Gun profile:

- Trigger: `A` / shoot
- Front button: `Start`
- Right button: `B`
- Middle button: `C`

Included Saturn core files:

- `_Console/Saturn_20251003.rbf`
- `_Console/Saturn_20260713.rbf`
- `config/Saturn.CFG`
- `config/RA_Saturn.CFG`
- `config/A0CD-Saturn.CFG`
- `config/Saturn_20260713.CFG`

RetroAchievements Saturn note:

- The RA Saturn `poc` core needs the upstream lightgun reset fix from MiSTer-devel/Saturn_MiSTer commit `526332d4c06291e4b402ace3c753a4baf08f5074`.
- The local source patch is `RA_Saturn_lightgun_reset_fix.patch`.
- Without a rebuilt RA Saturn `.rbf`, maps and Main_MiSTer changes alone are not enough to fix the missing crosshair/trigger behavior.

### Additional Console Lightgun Profiles

See `LIGHTGUN_CORES.md` for the full profile matrix, OSD settings, and button mappings.

New mapped/configured profiles:

- NES Zapper: `NES` and `RA_NES`.
- SNES Super Scope: `SNES` and `RA_SNES`.
- SNES Justifier: `SNES` and `RA_SNES`.
- Genesis / Mega Drive lightgun mode: normal `Genesis` and RA `RA_MegaDrive`.
- MegaCD / Sega CD Justifier: `MegaCD` and `RA_MegaCD`.
- MegaCD / Sega CD Menacer: `MegaCD` and `RA_MegaCD`.
- S32X lightgun mode: `S32X` and `RA_S32X`.
- SMS Phaser: `SMS` and `RA_SMS`.
- Atari 7800 XG-1: `Atari7800` and `RA_Atari7800`.

Helper scripts:

```sh
sh /media/fat/Scripts/xgunner_nes_zapper_map.sh
sh /media/fat/Scripts/xgunner_snes_super_scope_map.sh
sh /media/fat/Scripts/xgunner_snes_justifier_map.sh
sh /media/fat/Scripts/xgunner_genesis_lightgun_map.sh
sh /media/fat/Scripts/xgunner_megacd_justifier_map.sh
sh /media/fat/Scripts/xgunner_megacd_menacer_map.sh
sh /media/fat/Scripts/xgunner_s32x_lightgun_map.sh
sh /media/fat/Scripts/xgunner_sms_phaser_map.sh
sh /media/fat/Scripts/xgunner_atari7800_xg1_map.sh
```

Mega Jet and Mega Gun are not included as separate named profiles because they were not exposed as current MiSTer gun-mode choices in the documentation or core option strings checked for this update.

## Temporary Shim For Stock Main_MiSTer

The shim is a fallback test path for users who have not replaced their Main_MiSTer binary yet.

Files:

```sh
Scripts/xgunner_lightgun.sh
Scripts/xgunner_lightgun_shim.py
```

On MiSTer, install them under `/media/fat/Scripts/`, then run:

```sh
sh /media/fat/Scripts/xgunner_lightgun.sh start
sh /media/fat/Scripts/xgunner_lightgun.sh stop
sh /media/fat/Scripts/xgunner_lightgun.sh status
```

The shim finds the X-GUNNER `Mouse` event device, grabs its absolute X/Y and mouse button events, and creates a virtual Retroshooter-style lightgun named `XGUNNER MiSTer Lightgun`.

The virtual device uses VID/PID `0483:5750` through `0483:5753`, depending on the X-GUNNER player ID. Stock Main_MiSTer already treats those IDs as mouse-style lightguns, so this can validate the lightgun input path before testing the native patch.

## Calibration Notes

Calibrate in this order:

1. Put the X-GUNNER in light gun mode.
2. Calibrate the X-GUNNER with its own five-point process.
3. Start the patched Main_MiSTer binary or the temporary shim.
4. Open the target MiSTer core.
5. Open the OSD and press `F10` to run MiSTer's lightgun calibration.

Useful X-GUNNER hotkeys from the manual:

- Calibration pause mode: `Space + Start`, then pull trigger once.
- Calibration sequence: center, up, down, left, right.
- Off-screen trigger as right-click on: `Space + 5 + S`.
- Off-screen trigger as right-click off: `Space + 5 + W`.
- Light gun mode: `Space + 5 + Joystick Up`, or COM command `G`.
- 4:3 mode: `Space + A`, or COM command `Q`.
- 16:9 mode: `Space + D`, or COM command `V`.

## Probe Tools

These scripts are included for testers who need to confirm how their gun is being detected:

- `Scripts/xgunner_probe.sh`
- `Scripts/xgunner_abs_probe.py`
- `Scripts/xgunner_event_probe.py`

Do not post full probe reports publicly without reviewing them first. Probe reports can include connected USB device names and unique device strings.

## References

- X-GUNNER official site: https://hwhxg.com/
- MiSTer controller and lightgun docs: https://mister-devel.github.io/MkDocs_MiSTer/basics/input/
- Main_MiSTer source: https://github.com/MiSTer-devel/Main_MiSTer

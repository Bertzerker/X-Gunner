# X-GUNNER Console Lightgun Profiles

This file documents the MiSTer console cores that now have X-GUNNER profile files in this repository.

The PSX and Saturn profiles are based on direct local testing. The newer NES, SNES, Genesis, MegaCD, S32X, SMS, and Atari 7800 profiles are configured from the current MiSTer lightgun documentation and core option strings, and still need wider game testing.

## Verified Source Notes

MiSTer currently documents these console lightgun paths:

- PSX: GunCon and Justifier.
- Saturn: Virtua Gun.
- NES: Zapper.
- SNES: Super Scope and Justifier.
- Genesis and Sega CD: Menacer and Justifier.
- Master System: Phaser.
- Atari 7800: XG-1.

I did not add separate Mega Jet or Mega Gun profiles because those names do not appear as exposed gun-mode choices in the current MiSTer docs or the checked core option strings. The Sega profiles here follow the core options that are actually exposed: Menacer, Justifier, and Phaser.

## Included Profiles

| System | Normal core files | RetroAchievements files | Gun profile | Helper script |
| --- | --- | --- | --- | --- |
| PSX | `PSX.CFG`, `PSX_input_1209_0001_v3.map` | `RA_PSX.CFG`, `RA_PSX_input_1209_0001_v3.map` | GunCon default, Justifier optional | `Scripts/xgunner_map.sh psx-guncon`, `Scripts/xgunner_map.sh psx-justifier` |
| PSX 2X CPU | `PSX_2XCPU.CFG`, `PSX_2XCPU_input_1209_0001_v3.map`, `PSX2XCPU.CFG`, `PSX2XCPU_input_1209_0001_v3.map` | n/a | GunCon default, Justifier optional | `Scripts/xgunner_map.sh psx-guncon`, `Scripts/xgunner_map.sh psx-justifier` |
| Saturn | `Saturn.CFG`, `Saturn_input_1209_0001_v3.map`, `A0CD-Saturn.CFG`, `A0CD-Saturn_input_1209_0001_v3.map` | `RA_Saturn.CFG`, `RA_Saturn_input_1209_0001_v3.map` | Virtua Gun | `Scripts/xgunner_map.sh saturn` |
| NES | `NES.CFG`, `NES_input_1209_0001_v3.map` | `RA_NES.CFG`, `RA_NES_input_1209_0001_v3.map` | Zapper, Joy1 source default | `Scripts/xgunner_map.sh nes` |
| NES | `NES.zapper_joy2.CFG`, `NES_input_1209_0001_v3.zapper.map` | `RA_NES.zapper_joy2.CFG`, `RA_NES_input_1209_0001_v3.zapper.map` | Zapper, Joy2 source fallback | `Scripts/xgunner_map.sh nes-zapper-joy2` |
| SNES | `SNES.CFG`, `SNES_input_1209_0001_v3.map` | `RA_SNES.CFG`, `RA_SNES_input_1209_0001_v3.map` | Super Scope default | `Scripts/xgunner_map.sh snes-super-scope` |
| SNES | `SNES.justifier.CFG`, `SNES_input_1209_0001_v3.justifier.map` | `RA_SNES.justifier.CFG`, `RA_SNES_input_1209_0001_v3.justifier.map` | Justifier | `Scripts/xgunner_map.sh snes-justifier` |
| Genesis / Mega Drive | `Genesis.CFG`, `Genesis_input_1209_0001_v3.map` | `RA_MegaDrive.CFG`, `RA_MegaDrive_input_1209_0001_v3.map` | Core lightgun mode | `Scripts/xgunner_map.sh genesis` |
| MegaCD / Sega CD | `MegaCD.CFG`, `MegaCD_input_1209_0001_v3.map` | `RA_MegaCD.CFG`, `RA_MegaCD_input_1209_0001_v3.map` | Justifier default | `Scripts/xgunner_map.sh megacd-justifier` |
| MegaCD / Sega CD | `MegaCD.menacer.CFG`, `MegaCD_input_1209_0001_v3.menacer.map` | `RA_MegaCD.menacer.CFG`, `RA_MegaCD_input_1209_0001_v3.menacer.map` | Menacer | `Scripts/xgunner_map.sh megacd-menacer` |
| S32X | `S32X.CFG`, `S32X_input_1209_0001_v3.map` | `RA_S32X.CFG`, `RA_S32X_input_1209_0001_v3.map` | Core lightgun mode | `Scripts/xgunner_map.sh s32x` |
| SMS | `SMS.CFG`, `SMS_input_1209_0001_v3.map` | `RA_SMS.CFG`, `RA_SMS_input_1209_0001_v3.map` | Phaser | `Scripts/xgunner_map.sh sms` |
| Atari 7800 | `Atari7800.CFG`, `Atari7800_input_1209_0001_v3.map` | `RA_Atari7800.CFG`, `RA_Atari7800_input_1209_0001_v3.map` | XG-1 | `Scripts/xgunner_map.sh atari7800` |

## Arcade Profiles

These arcade MRAs on the test MiSTer explicitly declare lightgun support and now have X-GUNNER map files installed under `/media/fat/config/inputs/`:

| Arcade setname | Game |
| --- | --- |
| `lghost` | Laser Ghost (World) |
| `lghostj` | Laser Ghost (Japan) |
| `lghostu` | Laser Ghost (US) |
| `nycaptor` | N.Y. Captor |
| `colt` | Colt, bootleg of N.Y. Captor |
| `bronx` | Bronx, bootleg of Cycle Shooting |
| `opwolf` | Operation Wolf (World, set 1) |
| `opwolfa` | Operation Wolf (World, set 2) |
| `opwolfu` | Operation Wolf (US) |
| `opwolfj` | Operation Wolf (Japan) |
| `opwolfjsc` | Operation Wolf (Japan, SC) |
| `opwolfp` | Operation Wolf (Japan, prototype) |
| `ptblank2a` | Point Blank 2 (World, GNB2/VER.A) |
| `ptblank2b` | Point Blank 2 (World, GNB2/VER.A alt) |
| `ptblank2c` | Point Blank 2 (World, unknown version) |
| `ptblank2ua` | Point Blank 2 (US, GNB3/VER.A) |
| `gunbarla` | Gunbarl (Japan, GNB1/VER.A) |

Arcade mapping:

- Trigger: `A`, the main gun/fire input.
- Mouse 2: `B`, the secondary input, such as grenade or special weapon.
- Mouse 3: reserved for reload/offscreen shot.
- Bind `Start` through MiSTer's normal input remap flow or through a harmless key assigned in the X-GUNNER GUI.
- `5`/`e`: third game button where the core exposes one.
- `s`: `Coin` / `Select`.
- `w`: `Pause` where the core exposes one.

Point Blank 2 / SYSTEM11 notes:

- The installed Point Blank 2 MRA uses setname `ptblank2a` and core `SYSTEM11`.
- The SYSTEM11 profile keeps trigger/start/coin available and reserves mouse3 for the X-GUNNER reload/offscreen slot.
- The included `ptblank2*.CFG` and `gunbarla.CFG` files enable the core crosshair.
- User testing confirmed the core reacts to X-GUNNER aim, but Point Blank 2 does not work correctly in absolute lightgun mode. This appears to be a SYSTEM11 core issue, not an input map issue. A draft report is in `SYSTEM11_Point_Blank_absolute_lightgun_issue.md`.

Arcade test notes:

- Operation Wolf works correctly with X-GUNNER.
- Bronx is a vertical game and currently has its aiming axes rotated +90 degrees. Buttons work, so this appears to be vertical lightgun rotation handling in the core.
- Laser Ghost starts and the crosshair moves, but the game itself did not work correctly during testing. This appears to be game/core behavior rather than missing X-GUNNER input.
- A convenience folder was created on the test MiSTer at `_Arcade/X-GUNNER Lightgun/` with direct launchers for Point Blank 2, Gunbarl, Operation Wolf, N.Y. Captor, Colt, Bronx, and Laser Ghost.

`Oh! Bakyuuun` was found in the arcade list, but its MRA explicitly says light gun is not supported yet. It is not a mapping problem.

Profile-specific files are included beside the active/default files. For example, SNES includes both `SNES.super_scope.CFG` and `SNES.justifier.CFG`, and the unified helper script copies the requested profile over `SNES.CFG` and the active map name.

## Core OSD Settings

These settings are already encoded in the included `.CFG` files where the core exposes them:

- PSX GunCon: `Pad1` set to `GunCon` and crosshair enabled where available.
- PSX Justifier: `Pad1` set to `Justifier` and crosshair enabled where available.
- Saturn Virtua Gun: `Pad 1` set to `Virt LGun`, XY control set to joystick/lightgun source, buttons set to joystick, and crosshair enabled.
- NES default: `Peripheral` set to `Zapper (Joy1)` and `Zapper Trigger` set to `Joystick`.
- NES fallback: `Peripheral` set to `Zapper (Joy2)` and `Zapper Trigger` set to `Joystick` for users who assign the X-GUNNER as MiSTer player 2.
- SNES Super Scope: `Super Scope` set to `Joy2`, `Super Scope Btn` set to `Joy`, and `Gun Type` set to `Super Scope`.
- SNES Justifier: `Super Scope` set to `Joy2`, `Super Scope Btn` set to `Joy`, and `Gun Type` set to `Justifier`.
- Genesis / Mega Drive: `Gun Control` set to `Joy2` and `Gun Fire` set to `Joy`.
- MegaCD / Sega CD: `Gun Control` set to `Joy2`, `Gun Fire` set to `Joy`, and `Gun Type` set to `Justifier` or `Menacer`.
- S32X: `Gun Control` set to `Joy2` and `Gun Fire` set to `Joy`.
- SMS: `Gun Control` set to `Joy1`, `Gun Fire` set to `Joy`, and `Gun Port` set to `Port1`.
- Atari 7800: `Port1 Input` set to `Lightgun`, `Gun Control` set to `Joy1`, `Gun Fire` set to `Joy`, and `Show Overscan` set to `Yes`.

## X-GUNNER Default Control Table

The map files use the X-GUNNER P1 USB ID `1209:0001`.

| X-GUNNER control | OSD | Game |
| --- | --- | --- |
| Mouse 1 | Accept | Trigger |
| Mouse 2 | Decline | A / secondary button |
| Mouse 3 | Not mapped | Reserved for reload/offscreen shot |
| Space | User-bound OSD menu key | Not mapped |
| `1` / `q` | Not mapped | A / secondary button |
| `5` / `e` | Not mapped | B button |
| Enter | Not mapped | Not mapped |
| `w` | Ignored | Pause |
| `a` | Ignored | Not mapped |
| `s` | Ignored | Coin |
| `d` | Ignored | Not mapped |
| Arrow keys | Direction | Not mapped |

Profile-specific files assign that default table to each core's button order:

| Profile | Trigger | Mouse 2 / A | Mouse 3 | Space | Start | `5`/`e` | `s` | `w` |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| PSX GunCon | Circle / shoot | GunCon A | Reserved reload/offscreen | OSD menu | Not mapped | GunCon B | Not mapped | Not mapped |
| PSX Justifier | Circle / shoot | X / special | Reserved reload/offscreen | OSD menu | Start | Not mapped | Not mapped | Not mapped |
| Saturn Virtua Gun | A / shoot | B | Reserved reload/offscreen | OSD menu | Start | C | Not mapped | Not mapped |
| NES Zapper | Zapper/Vaus button | Not mapped | Reserved reload/offscreen | OSD menu | Not mapped | Not mapped | Not mapped | Not mapped |
| SNES Super Scope | Fire | Cursor | Reserved reload/offscreen | OSD menu | Not mapped | Not mapped | Not mapped | Pause |
| SNES Justifier | Fire | Secondary | Reserved reload/offscreen | OSD menu | Not mapped | Not mapped | Not mapped | Not mapped |
| Genesis / MegaCD / S32X | A / trigger | B | Reserved reload/offscreen | OSD menu | Start | C | Not mapped | Not mapped |
| SMS Phaser | Fire 1 | Not mapped | Reserved reload/offscreen | OSD menu | Not mapped | Not mapped | Not mapped | Not mapped |
| Atari 7800 XG-1 | Fire 1 | Not mapped | Reserved reload/offscreen | OSD menu | Not mapped | Not mapped | Not mapped | Not mapped |
| Arcade gun games | A / trigger | B / secondary weapon | Reserved reload/offscreen | OSD menu | Start | Third button where exposed | Coin / Select | Pause where exposed |

Mouse3 reload/offscreen is reserved in the profile layout for profiles and cores where MiSTer can expose it cleanly.

## NES Test Note

The initial NES package used `Zapper(Joy2)`, matching the common documentation wording for systems that put the original lightgun on player 2. On the X-GUNNER P1 receiver, the MiSTer input source is player 1, so the NES core needs `Zapper(Joy1)` to receive the aiming coordinates.

This does not move the emulated Zapper to NES controller port 1. The NES core still reports Zapper light/trigger data to the game through the expected NES port; the setting selects the MiSTer-side source device.

## References

- MiSTer controller and lightgun documentation: https://mister-devel.github.io/MkDocs_MiSTer/basics/input/
- MiSTer config string documentation: https://mister-devel.github.io/MkDocs_MiSTer/developer/conf_str/
- MiSTer core source repositories: https://github.com/MiSTer-devel

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
| NES | `NES.CFG`, `NES_input_1209_0001_v3.map` | `RA_NES.CFG`, `RA_NES_input_1209_0001_v3.map` | Zapper, Joy1 source default | `Scripts/xgunner_nes_zapper_map.sh` |
| NES | `NES.zapper_joy2.CFG`, `NES_input_1209_0001_v3.zapper.map` | `RA_NES.zapper_joy2.CFG`, `RA_NES_input_1209_0001_v3.zapper.map` | Zapper, Joy2 source fallback | `Scripts/xgunner_nes_zapper_joy2_map.sh` |
| SNES | `SNES.CFG`, `SNES_input_1209_0001_v3.map` | `RA_SNES.CFG`, `RA_SNES_input_1209_0001_v3.map` | Super Scope default | `Scripts/xgunner_snes_super_scope_map.sh` |
| SNES | `SNES.justifier.CFG`, `SNES_input_1209_0001_v3.justifier.map` | `RA_SNES.justifier.CFG`, `RA_SNES_input_1209_0001_v3.justifier.map` | Justifier | `Scripts/xgunner_snes_justifier_map.sh` |
| Genesis / Mega Drive | `Genesis.CFG`, `Genesis_input_1209_0001_v3.map` | `RA_MegaDrive.CFG`, `RA_MegaDrive_input_1209_0001_v3.map` | Core lightgun mode | `Scripts/xgunner_genesis_lightgun_map.sh` |
| MegaCD / Sega CD | `MegaCD.CFG`, `MegaCD_input_1209_0001_v3.map` | `RA_MegaCD.CFG`, `RA_MegaCD_input_1209_0001_v3.map` | Justifier default | `Scripts/xgunner_megacd_justifier_map.sh` |
| MegaCD / Sega CD | `MegaCD.menacer.CFG`, `MegaCD_input_1209_0001_v3.menacer.map` | `RA_MegaCD.menacer.CFG`, `RA_MegaCD_input_1209_0001_v3.menacer.map` | Menacer | `Scripts/xgunner_megacd_menacer_map.sh` |
| S32X | `S32X.CFG`, `S32X_input_1209_0001_v3.map` | `RA_S32X.CFG`, `RA_S32X_input_1209_0001_v3.map` | Core lightgun mode | `Scripts/xgunner_s32x_lightgun_map.sh` |
| SMS | `SMS.CFG`, `SMS_input_1209_0001_v3.map` | `RA_SMS.CFG`, `RA_SMS_input_1209_0001_v3.map` | Phaser | `Scripts/xgunner_sms_phaser_map.sh` |
| Atari 7800 | `Atari7800.CFG`, `Atari7800_input_1209_0001_v3.map` | `RA_Atari7800.CFG`, `RA_Atari7800_input_1209_0001_v3.map` | XG-1 | `Scripts/xgunner_atari7800_xg1_map.sh` |

Profile-specific files are included beside the active/default files. For example, SNES includes both `SNES.super_scope.CFG` and `SNES.justifier.CFG`, and the helper scripts copy the requested profile over `SNES.CFG` and the active map name.

## Core OSD Settings

These settings are already encoded in the included `.CFG` files where the core exposes them:

- NES default: `Peripheral` set to `Zapper (Joy1)` and `Zapper Trigger` set to `Joystick`.
- NES fallback: `Peripheral` set to `Zapper (Joy2)` and `Zapper Trigger` set to `Joystick` for users who assign the X-GUNNER as MiSTer player 2.
- SNES Super Scope: `Super Scope` set to `Joy2`, `Super Scope Btn` set to `Joy`, and `Gun Type` set to `Super Scope`.
- SNES Justifier: `Super Scope` set to `Joy2`, `Super Scope Btn` set to `Joy`, and `Gun Type` set to `Justifier`.
- Genesis / Mega Drive: `Gun Control` set to `Joy2` and `Gun Fire` set to `Joy`.
- MegaCD / Sega CD: `Gun Control` set to `Joy2`, `Gun Fire` set to `Joy`, and `Gun Type` set to `Justifier` or `Menacer`.
- S32X: `Gun Control` set to `Joy2` and `Gun Fire` set to `Joy`.
- SMS: `Gun Control` set to `Joy1`, `Gun Fire` set to `Joy`, and `Gun Port` set to `Port1`.
- Atari 7800: `Port1 Input` set to `Lightgun`, `Gun Control` set to `Joy1`, `Gun Fire` set to `Joy`, and `Show Overscan` set to `Yes`.

## X-GUNNER Button Maps

The map files use the X-GUNNER P1 USB ID `1209:0001`.

| Profile | Trigger | Right button | Middle button | Front/side button |
| --- | --- | --- | --- | --- |
| NES Zapper | Zapper/Vaus button | Not mapped | Not mapped | Not mapped |
| SNES Super Scope | Fire | Cursor | Pause | Not mapped |
| SNES Justifier | Fire | Start | Not mapped | Not mapped |
| Genesis / MegaCD / S32X | A / trigger | B | C | Start |
| SMS Phaser | Fire 1 | Not mapped | Not mapped | Not mapped |
| Atari 7800 XG-1 | Fire 1 | Not mapped | Not mapped | Not mapped |

These maps are intentionally conservative. Extra X-GUNNER buttons can be added later if testing shows that a specific game needs a better reload, pause, or secondary-button layout.

## NES Test Note

The initial NES package used `Zapper(Joy2)`, matching the common documentation wording for systems that put the original lightgun on player 2. On the X-GUNNER P1 receiver, the MiSTer input source is player 1, so the NES core needs `Zapper(Joy1)` to receive the aiming coordinates.

This does not move the emulated Zapper to NES controller port 1. The NES core still reports Zapper light/trigger data to the game through the expected NES port; the setting selects the MiSTer-side source device.

## References

- MiSTer controller and lightgun documentation: https://mister-devel.github.io/MkDocs_MiSTer/basics/input/
- MiSTer config string documentation: https://mister-devel.github.io/MkDocs_MiSTer/developer/conf_str/
- MiSTer core source repositories: https://github.com/MiSTer-devel

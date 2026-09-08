# Point Blank 2 reacts to lightgun aim, but absolute lightgun mode does not work correctly

## Summary

On MiSTer with an X-GUNNER absolute-position LCD lightgun, `Point Blank 2 (World, GNB2/VER.A)` reacts to aiming/crosshair movement, but does not work correctly in absolute lightgun mode. Other MiSTer cores using the same X-GUNNER Main_MiSTer input patch and the same button mapping style work.

This looks core-side rather than a MiSTer input map problem.

## Hardware / Input

- MiSTer FPGA
- X-GUNNER P1 LCD lightgun
- USB VID/PID: `1209:0001`
- Patched Main_MiSTer detects X-GUNNER as a native MiSTer lightgun with absolute X/Y coordinates.
- Trigger and extra buttons are mapped as normal joystick buttons for the core.

## Tested Results

Working with the same gun/input patch:

- PSX GunCon
- PSX Justifier
- RA PSX GunCon / Justifier
- Saturn Virtua Gun with the older working Saturn core
- Operation Wolf arcade MRA
- Other console lightgun cores tested by the user

SYSTEM11 result:

- `Point Blank 2 (World, GNB2/VER.A)` / setname `ptblank2a`
- Core: `SYSTEM11`
- Crosshair/aim reacts
- Absolute lightgun behavior is not correct in-game
- Button mapping is present:
  - Trigger -> Button 1
  - Mouse2 -> Button 2
  - Mouse3 -> Button 3
  - X-GUNNER front/start button -> Start

## Local MRA / Config Notes

The installed MRA is:

```xml
<name>Point Blank 2 (World, GNB2/VER.A)</name>
<setname>ptblank2a</setname>
<rbf>SYSTEM11</rbf>
```

The SYSTEM11 core exposes:

```text
J1,Button1,Button2,Button3,Button4,Button5,Button6,Start,Coin,Pause
```

The local config enables the crosshair via status bit 100.

## Request

Could you check whether SYSTEM11's Point Blank 2 lightgun path supports MiSTer absolute lightgun coordinates correctly, rather than only relative/mouse-style movement?

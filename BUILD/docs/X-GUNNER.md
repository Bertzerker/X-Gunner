XGUNNER Light Gun User Manual



1. Before You Start

1.1 Connection


PC USB ← Receiver ← Wireless ← Light Gun

• Plug the receiver into a USB port on your PC (Windows recognizes it as a serial port, e.g. XGUNNER-P1).• Power on the light gun. After pairing with the receiver, it is ready to use.• Multiplayer: connect one receiver per player (P1–P4), each paired with its own gun.
1.2 Button Layout (on the gun)

Button          |  Default function
------------------------------------------
Trigger         |  Mouse left button
A               |  Mouse right button
B               |  Mouse middle button
Start           |  Up arrow
5               |  Down arrow
Reload (Space)  |  Space
Pedal           |  Pedal key (for combos)
Select          |  Select key (for combos)


You can remap these in XgunnerGUI. The trigger is always left click and cannot be changed.



2. IR LED Installation

The positioning LEDs (infrared) help the gun camera track the cursor. Installation tips:

Placement

• Install 2 LEDs along the top edge of the screen and 2 along the bottom edge.• Keep the LEDs left-right symmetrical with moderate spacing; a square layout is best.• Point the LED faces toward the light gun and keep them unobstructed.
Notes

• Install LEDs before calibration, or aim will be off.• In the GUI, open LED Install for the recommended layout diagram.• After installation, use IR Test to verify the signal (light spots appear on screen).• If the cursor drifts or tracking is unstable, adjust the distance between the gun and the screen.


3. Basic Usage

3.1 Plug and Play

With the receiver connected and the gun powered on, the gun works as a mouse + keyboard with no extra driver (USB VID 1209).

3.2 XgunnerGUI

Feature           |  Description
------------------------------------------------------------------------------------------------
Button mapping    |  Remap gun buttons to keyboard/mouse
Calibrate         |  Full-screen 5-point calibration
Firmware upgrade  |  Update gun or receiver firmware
Vibration         |  Adjust solenoid/motor feedback
Rapid Fire        |  Toggle auto rapid fire, set left-click speed / clicks per pull / auto right click
IR test           |  Check IR tracking
Gamepad test      |  Test stick and buttons


3.3 Calibration (recommended on first use)

Method 1: GUI (recommended)

• Open XgunnerGUI and click Calibrate.• Turn off rapid-fire mode if enabled.• Aim at each on-screen point and pull the trigger as prompted.
Method 2: Gun combo keys

• Press Space + Start + Enter together to enter pause mode.• Pull the trigger to start 5-point calibration: center, top, bottom, left, right.• Calibration saves automatically when finished.
During calibration, turn off rapid-fire, hold the gun steady, and aim at the cursor before pulling the trigger.



4. Combo Keys

Hold all listed buttons at the same time. Items marked saved are stored in memory; others reset after power off unless noted.

Basic

Combo                    |  Function
--------------------------------------------------------
Quick **5 + Space**      |  Send Esc
**Space + Start**        |  Enter pause/calibration mode
**Space** in pause mode  |  Exit pause, return to normal


Aspect ratio

Combo          |  Function
--------------------------------
**Space + A**  |  Switch to 4:3
**Space + D**  |  Switch to 16:9


Off-screen trigger (saved)

Combo              |  Function
------------------------------------------------------------
**Space + S + 5**  |  Off-screen trigger acts as right click
**Space + W + 5**  |  Disable off-screen right click


IR layout mode (saved)

Combo              |  Function
------------------------------------------
**Pedal + Q + A**  |  Diamond 4-point mode
**Pedal + Q + D**  |  Square 4-corner mode


Rapid fire mode (configurable in the GUI "Rapid Fire" settings; not saved, resets to defaults after power off)

Combo                  |  Function
--------------------------------------------
**Pedal + Q + Space**  |  Enable rapid fire
**Pedal + Q + 5**      |  Disable rapid fire


The actual behavior is controlled by the Rapid Fire settings on the GUI main page:

Setting                         |  Description                                                                                                                                                                                                                                               |  Range/Default
------------------------------------------------------------------------------------------------
Enable auto rapid fire          |  Master switch; the combo keys above also toggle it                                                                                                                                                                                                        |  on by default
Left-click speed                |  Auto left clicks per second                                                                                                                                                                                                                               |  1–15/sec, default 10
Left clicks per trigger pull    |  0 (default) = keep clicking while the trigger is held, stop on release; any other number N = one pull completes N left clicks at the set speed then stops (a quick tap still finishes them all; release and pull again for the next round)                |  0–99, default 0
Enable auto right click         |  When checked: after the left clicks finish (count shared with the setting above), one right click is fired automatically after the set delay; when the count is 0 (hold-to-click mode), releasing the trigger also fires one right click before stopping  |  off by default
Delay before right click        |  Wait this many milliseconds after the left clicks before the right click                                                                                                                                                                                  |  0–5000 ms, default 50
Motor vibration on right click  |  When checked, the motor vibrates once on each right click (duration follows "Motor vibration duration")                                                                                                                                                   |  on by default
Loop / Delay before next loop   |  When Loop is checked: after one round of "left clicks + one right click" completes with the trigger still held, the next round starts automatically after the set delay; if unchecked, release and pull the trigger again for the next round              |  off by default; interval 0–5000 ms, default 50


Click Apply Settings to write to the gun. The settings take effect immediately but are not saved: after the gun is powered off and back on, they reset to the defaults in the table above. Read current values reads back the gun's current settings.

Auto rapid left click (resets to off after power off)

Combo                       |  Function
------------------------------------------------------
**Space + Select + Pedal**  |  Enable auto rapid left
**Space + Select + Q**      |  Disable auto rapid left


Vibration (saved)

Combo                 |  Function
-------------------------------------------------------
**Pedal + Q + Up**    |  Solenoid pulse +1 ms (0–30 ms)
**Pedal + Q + Down**  |  Solenoid pulse −1 ms


5. COM Serial Commands

The receiver appears as a USB serial port (e.g. COM1, COM2). Send commands from a terminal or tools like MameHook.

Most commands need no line ending; GUI X commands usually end with ; or a newline.

5.1 Game vibration sync (MameHook)

For arcade recoil/rumble sync. Send S6 first to enter sync mode.

Command  |  Description
-------------------------------------
`S6`     |  Enter vibration sync mode
`F0`     |  Solenoid pulse (recoil)
`F1`     |  Motor rumble once
`E`      |  Exit sync mode


Typical flow:


Game start → send S6
While playing → send F0 (recoil) or F1 (hit rumble)
Game end → send E

Dual gun example (MameHook):


cmo 1 baud=9600_parity=N_data=8_stop=1    ← open P1 port
cmo 2 baud=9600_parity=N_data=8_stop=1    ← open P2 port
cmw 1 S6                                  ← P1 enter sync
cmw 2 S6                                  ← P2 enter sync
cmw 1 F0                                  ← P1 recoil
cmw 2 F0                                  ← P2 recoil
cmw 1 E                                   ← P1 exit sync
cmw 2 E                                   ← P2 exit sync

P1 = COM1, P2 = COM2. Confirm actual port numbers in Device Manager.

5.2 System commands

Command  |  Description
----------------------------------------------
`RST`    |  Reboot device
`CD`     |  Enter pause/calibration mode
`J`      |  Left stick mode (gamepad test)
`B`      |  Right stick mode (gamepad test)
`G`      |  Light gun mode (exit gamepad test)
`Q`      |  4:3 aspect ratio
`V`      |  16:9 aspect ratio
`IR`     |  Enter IR test (38400 baud)
`TC`     |  Exit IR test


5.3 GUI vibration commands (X series)

Sent via GUI or serial; receiver forwards to the gun.

Command                                        |  Description                                   |  Parameters
------------------------------------------------------------------------------------------------
`XS:n,f,l,r,swap;`                             |  Save vibration settings and reboot            |  see table
`XT1:n;`                                       |  Test solenoid interval (5 pulses)             |  n = interval ms
`XT2:f,n;`                                     |  Test solenoid on-time                         |  f = on-time, n = interval
`XT3:l;`                                       |  Test trigger hold threshold                   |  l = threshold ms
`XT4:r;`                                       |  Test motor duration                           |  r = duration ms
`XQ;`                                          |  Query current vibration settings              |  —
`XR;`                                          |  Factory reset and reboot                      |  —
`XL:en,hz,burst,ren,rdelay,loop,ldelay,rvib;`  |  Rapid fire settings (immediate, not saved)    |  see table
`XLQ;`                                         |  Query rapid fire settings, replies `XLV:...`  |  —


XL rapid-fire parameters:

Param   |  Meaning                                                                                                                                               |  Default  |  Range
------------------------------------------------------------------------------------------------
en      |  Rapid fire on/off                                                                                                                                     |  1        |  0=off, 1=on
hz      |  Left-click speed (clicks/sec)                                                                                                                         |  10       |  1–15
burst   |  Left clicks per trigger pull (0 = continuous while held, stop on release; >0 = complete N clicks then stop)                                           |  0        |  0–99
ren     |  Auto right click on/off (one right click after the left clicks, count shared with burst; with burst=0 it is also fired when the trigger is released)  |  0        |  0=off, 1=on
rdelay  |  Delay before the right click (ms)                                                                                                                     |  50       |  0–5000
loop    |  Loop on/off (next round starts automatically after ldelay while the trigger is held)                                                                  |  0        |  0=off, 1=on
ldelay  |  Loop interval (ms)                                                                                                                                    |  50       |  0–5000
rvib    |  Motor vibration on right click                                                                                                                        |  1        |  0=off, 1=on


Example: XL:1,10,3,1,50,1,50,1; enables rapid fire at 10 clicks/sec; one pull fires 3 left clicks, then 1 right click after 50 ms (with motor vibration), and the next round loops automatically after 50 ms.

XS vibration parameters:

Param  |  Meaning                       |  Default  |  Range
------------------------------------------------------------------
n      |  Solenoid pulse interval       |  35 ms    |  —
f      |  Solenoid on-time              |  30 ms    |  0–30 ms
l      |  Trigger long-press threshold  |  400 ms   |  —
r      |  Motor rumble duration         |  200 ms   |  —
swap   |  Swap solenoid/motor pins      |  0        |  0=no, 1=yes


Example: XS:35,30,400,200,0; saves default vibration settings.

5.4 Cursor adjustment (XCA / XCS)

Command                  |  Description
-----------------------------------------------------------
`XCA:sx,sy,l,r,t,b,tp;`  |  Live cursor preview (not saved)
`XCS:sx,sy,l,r,t,b,tp;`  |  Save cursor settings and reboot


Param          |  Meaning                       |  Default
----------------------------------------------------------
sx / sy        |  X/Y scale (×1000)             |  1000
l / r / t / b  |  Edge compensation (×100)      |  0
tp             |  Trapezoid correction (×1000)  |  0


5.5 Other commands

Command     |  Description
-----------------------------------------------------
`XF:n;`     |  Set wireless channel (0–127, standard)
`XFQ;`      |  Query channel
`XK:1;`     |  Enable gun calibration shortcut
`XK:0;`     |  Disable gun calibration shortcut
`XA:1;`     |  Enable auto rapid left
`XA:0;`     |  Disable auto rapid left
`XN:name;`  |  Rename receiver (Pro)




6. FAQ

Issue                   |  What to do
------------------------------------------------------------------------------
PC does not detect gun  |  Check USB, power, try another port
Poor aim                |  Recalibrate; turn off rapid-fire
Vibration out of sync   |  Confirm `S6` was sent; check COM port
P2 no rumble            |  Confirm P2 receiver COM port (e.g. COM2)
Mapping fails           |  Power cycle and retry; remap in GUI
No IR signal            |  Check the LED USB power supply; use a 5V 2A adapter




7. Firmware Upgrade

Wired upgrade (gun)

• Power off the gun.• Hold Upgrade, plug in USB, then release the button.• When RPI-RP2 appears, drag the matching P1–P4.uf2 onto the drive.• The gun reboots when done.
Receiver upgrade

• Hold receiver Upgrade, plug in USB, release the button.• Drag Receiver/P1–P4.uf2 onto RPI-RP2.
Wireless upgrade (Pro)

• Receiver on PC, gun powered on.• In the GUI upgrade screen, pick a version and click Start upgrade — no cable needed.


XGUNNER Light Gun · User Manual · V1.0

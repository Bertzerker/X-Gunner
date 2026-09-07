#!/usr/bin/env python3

import os
import struct
import sys

SLOTS = [
    "RIGHT", "LEFT", "DOWN", "UP",
    "A", "B", "X", "Y", "L", "R", "SELECT", "START",
    "MOUSE_RIGHT", "MOUSE_LEFT", "MOUSE_DOWN", "MOUSE_UP",
    "MOUSE_BTN_L", "MOUSE_BTN_R", "MOUSE_BTN_M", "MOUSE_EMU",
    "OSD_TOGGLE_KBD", "OSD_TOGGLE_PAD1", "OSD_TOGGLE_PAD2",
    "MENU_OK_BACK",
    "AXIS1_X", "AXIS1_Y", "AXIS2_X", "AXIS2_Y",
    "AXIS_X", "AXIS_Y", "AXIS_MOUSE_X", "AXIS_MOUSE_Y",
]

CODE_NAMES = {
    0x0000: "-",
    0x0001: "KEY_ESC",
    0x0002: "KEY_1",
    0x0003: "KEY_2",
    0x0004: "KEY_3",
    0x0005: "KEY_4",
    0x0006: "KEY_5",
    0x0007: "KEY_6",
    0x0008: "KEY_7",
    0x0009: "KEY_8",
    0x000a: "KEY_9",
    0x000b: "KEY_0",
    0x0010: "KEY_Q",
    0x0011: "KEY_W",
    0x0012: "KEY_E",
    0x0013: "KEY_R",
    0x0014: "KEY_T",
    0x0015: "KEY_Y",
    0x0016: "KEY_U",
    0x0017: "KEY_I",
    0x0018: "KEY_O",
    0x0019: "KEY_P",
    0x001c: "KEY_ENTER",
    0x001e: "KEY_A",
    0x001f: "KEY_S",
    0x0020: "KEY_D",
    0x0021: "KEY_F",
    0x0022: "KEY_G",
    0x0023: "KEY_H",
    0x0024: "KEY_J",
    0x0025: "KEY_K",
    0x0026: "KEY_L",
    0x0039: "KEY_SPACE",
    0x002c: "KEY_Z",
    0x002d: "KEY_X",
    0x002e: "KEY_C",
    0x002f: "KEY_V",
    0x0030: "KEY_B",
    0x0031: "KEY_N",
    0x0032: "KEY_M",
    0x0058: "KEY_F12",
    0x0067: "KEY_UP",
    0x0069: "KEY_LEFT",
    0x006a: "KEY_RIGHT",
    0x006c: "KEY_DOWN",
    0x0110: "BTN_LEFT / Mouse1",
    0x0111: "BTN_RIGHT / Mouse2",
    0x0112: "BTN_MIDDLE / Mouse3",
    0x0113: "BTN_SIDE",
    0x0114: "BTN_EXTRA",
    0x0120: "BTN_TRIGGER",
    0x0121: "BTN_THUMB",
    0x0122: "BTN_THUMB2",
    0x0123: "BTN_TOP",
    0x0124: "BTN_TOP2",
    0x0125: "BTN_PINKIE",
    0x0126: "BTN_BASE",
    0x0127: "BTN_BASE2",
    0x0128: "BTN_BASE3",
    0x0129: "BTN_BASE4",
    0x012a: "BTN_BASE5",
    0x012b: "BTN_BASE6",
    0x0130: "BTN_A",
    0x0131: "BTN_B",
    0x0132: "BTN_C",
    0x0133: "BTN_X",
    0x0134: "BTN_Y",
    0x0135: "BTN_Z",
    0x0136: "BTN_TL",
    0x0137: "BTN_TR",
    0x0138: "BTN_TL2",
    0x0139: "BTN_TR2",
    0x013a: "BTN_SELECT",
    0x013b: "BTN_START",
    0x013c: "BTN_MODE",
    0x0320: "KEY_EMU_AXIS0_NEG",
    0x0321: "KEY_EMU_AXIS0_POS",
    0x0322: "KEY_EMU_AXIS1_NEG",
    0x0323: "KEY_EMU_AXIS1_POS",
}

ABS_NAMES = {
    0: "ABS_X",
    1: "ABS_Y",
    2: "ABS_Z",
    3: "ABS_RX",
    4: "ABS_RY",
    5: "ABS_RZ",
    16: "ABS_HAT0X",
    17: "ABS_HAT0Y",
}

KEY_NAMES = {
    1: "KEY_ESC",
    2: "KEY_1",
    3: "KEY_2",
    4: "KEY_3",
    5: "KEY_4",
    6: "KEY_5",
    7: "KEY_6",
    8: "KEY_7",
    9: "KEY_8",
    10: "KEY_9",
    11: "KEY_0",
    16: "KEY_Q",
    17: "KEY_W",
    18: "KEY_E",
    19: "KEY_R",
    20: "KEY_T",
    21: "KEY_Y",
    22: "KEY_U",
    23: "KEY_I",
    24: "KEY_O",
    25: "KEY_P",
    28: "KEY_ENTER",
    30: "KEY_A",
    31: "KEY_S",
    32: "KEY_D",
    33: "KEY_F",
    34: "KEY_G",
    35: "KEY_H",
    36: "KEY_J",
    37: "KEY_K",
    38: "KEY_L",
    44: "KEY_Z",
    45: "KEY_X",
    46: "KEY_C",
    47: "KEY_V",
    48: "KEY_B",
    49: "KEY_N",
    50: "KEY_M",
    57: "KEY_SPACE",
    88: "KEY_F12",
    103: "KEY_UP",
    105: "KEY_LEFT",
    106: "KEY_RIGHT",
    108: "KEY_DOWN",
}


def code_name(code, slot=None):
    if not code:
        return "-"
    low = code & 0xFFFF
    high = code >> 16
    if slot is not None and slot >= 24 and high == 2:
        return ABS_NAMES.get(low, f"ABS_{low}")
    low_name = CODE_NAMES.get(low, f"0x{low:04x}")
    if not high:
        return low_name
    high_name = CODE_NAMES.get(high, f"0x{high:04x}")
    return f"{low_name} + {high_name}"


def decode_input_map(path):
    data = open(path, "rb").read()
    if len(data) != 128:
        print(f"{path}: expected 128 bytes for input map, got {len(data)}")
        return
    print(path)
    values = struct.unpack("<32I", data)
    for index, value in enumerate(values):
        if value:
            print(f"  {index:02d} {SLOTS[index]:<16} {code_name(value, index)}")


def decode_keyboard_map(path):
    data = open(path, "rb").read()
    if len(data) != 256:
        print(f"{path}: expected 256 bytes for keyboard map, got {len(data)}")
        return
    print(path)
    for src, dst in enumerate(data):
        if dst:
            src_name = KEY_NAMES.get(src, f"KEY_{src}")
            dst_name = KEY_NAMES.get(dst, f"KEY_{dst}")
            print(f"  {src_name} -> {dst_name}")


def main():
    if len(sys.argv) < 2:
        raise SystemExit("usage: decode_mister_input.py FILE.map [FILE.map ...]")

    for path in sys.argv[1:]:
        if not os.path.exists(path):
            print(f"{path}: not found")
            continue
        name = os.path.basename(path)
        if name.startswith("kbd_"):
            decode_keyboard_map(path)
        else:
            decode_input_map(path)


if __name__ == "__main__":
    main()

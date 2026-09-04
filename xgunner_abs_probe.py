#!/usr/bin/env python3

import array
import fcntl
import glob
import os
import struct

EVIOCGABS_BASE = 0x80184540
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


def read_text(path):
    try:
        with open(path, "r", encoding="utf-8") as handle:
            return handle.read().strip()
    except OSError:
        return ""


def test_bit(hex_words, bit):
    words = [int(part, 16) for part in hex_words.split()]
    word = bit // 32
    off = bit % 32
    if word >= len(words):
        return False
    return bool(words[word] & (1 << off))


def abs_info(event_path, axis):
    with open(event_path, "rb", buffering=0) as handle:
        buf = array.array("i", [0, 0, 0, 0, 0, 0])
        fcntl.ioctl(handle.fileno(), EVIOCGABS_BASE + axis, buf, True)
        value, minimum, maximum, fuzz, flat, resolution = buf.tolist()
        return value, minimum, maximum, fuzz, flat, resolution


for event_path in sorted(glob.glob("/sys/class/input/event*")):
    device_path = os.path.join(event_path, "device")
    name = read_text(os.path.join(device_path, "name"))
    vendor = read_text(os.path.join(device_path, "id/vendor"))
    product = read_text(os.path.join(device_path, "id/product"))
    if (vendor, product) not in {("1209", "0001"), ("1209", "0002"), ("1209", "0003"), ("1209", "0004")}:
        continue

    event_name = os.path.basename(event_path)
    devnode = f"/dev/input/{event_name}"
    abs_caps = read_text(os.path.join(device_path, "capabilities/abs"))

    print(f"{devnode} {vendor}:{product} {name}")
    if not abs_caps or abs_caps == "0":
        print("  no absolute axes")
        continue

    for axis, axis_name in ABS_NAMES.items():
        if not test_bit(abs_caps, axis):
            continue
        try:
            value, minimum, maximum, fuzz, flat, resolution = abs_info(devnode, axis)
        except OSError as exc:
            print(f"  {axis_name}: unreadable: {exc}")
            continue
        print(
            f"  {axis_name}: value={value} min={minimum} max={maximum} "
            f"fuzz={fuzz} flat={flat} resolution={resolution}"
        )

#!/usr/bin/env python3

import glob
import os
import select
import struct
import time

EVENT_FMT = "llHHl"
EVENT_SIZE = struct.calcsize(EVENT_FMT)

TYPE_NAMES = {0: "SYN", 1: "KEY", 2: "REL", 3: "ABS", 4: "MSC"}
KEY_NAMES = {
    1: "ESC",
    28: "ENTER",
    57: "SPACE",
    59: "F1",
    68: "F10",
    103: "UP",
    105: "LEFT",
    106: "RIGHT",
    108: "DOWN",
    272: "BTN_LEFT",
    273: "BTN_RIGHT",
    274: "BTN_MIDDLE",
    275: "BTN_SIDE",
    276: "BTN_EXTRA",
    288: "BTN_TRIGGER",
    289: "BTN_THUMB",
    290: "BTN_THUMB2",
    291: "BTN_TOP",
    292: "BTN_TOP2",
    293: "BTN_PINKIE",
    294: "BTN_BASE",
    295: "BTN_BASE2",
    296: "BTN_BASE3",
    297: "BTN_BASE4",
    298: "BTN_BASE5",
    299: "BTN_BASE6",
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


def read_text(path):
    try:
        with open(path, "r", encoding="utf-8") as handle:
            return handle.read().strip()
    except OSError:
        return ""


def event_label(event_type, code):
    if event_type == 1:
        return KEY_NAMES.get(code, f"KEY_{code}")
    if event_type == 3:
        return ABS_NAMES.get(code, f"ABS_{code}")
    return str(code)


def find_devices():
    devices = []
    for event_path in sorted(glob.glob("/sys/class/input/event*")):
        device_path = os.path.join(event_path, "device")
        name = read_text(os.path.join(device_path, "name"))
        vendor = read_text(os.path.join(device_path, "id/vendor"))
        product = read_text(os.path.join(device_path, "id/product"))
        if vendor == "1209" and product in {"0001", "0002", "0003", "0004"}:
            devices.append((f"/dev/input/{os.path.basename(event_path)}", name))
    return devices


def main():
    devices = find_devices()
    if not devices:
        raise SystemExit("No X-GUNNER input devices found")

    opened = []
    for path, name in devices:
        fd = os.open(path, os.O_RDONLY | os.O_NONBLOCK)
        opened.append((fd, path, name))
        print(f"Watching {path}: {name}", flush=True)

    print("Aim and press/release the gun controls now. Capturing for 15 seconds.", flush=True)
    stop = time.time() + 15
    last_abs = {}

    try:
        while time.time() < stop:
            readable, _, _ = select.select([fd for fd, _, _ in opened], [], [], 0.25)
            for fd in readable:
                path, name = next((p, n) for ofd, p, n in opened if ofd == fd)
                while True:
                    try:
                        data = os.read(fd, EVENT_SIZE)
                    except BlockingIOError:
                        break
                    if len(data) != EVENT_SIZE:
                        break
                    _sec, _usec, event_type, code, value = struct.unpack(EVENT_FMT, data)
                    if event_type == 0:
                        continue
                    if event_type == 3:
                        key = (path, code)
                        old = last_abs.get(key)
                        if old is not None and abs(old - value) < 256:
                            continue
                        last_abs[key] = value
                    type_name = TYPE_NAMES.get(event_type, str(event_type))
                    label = event_label(event_type, code)
                    print(f"{path} {name}: {type_name} {label} value={value}", flush=True)
    finally:
        for fd, _, _ in opened:
            os.close(fd)


if __name__ == "__main__":
    main()

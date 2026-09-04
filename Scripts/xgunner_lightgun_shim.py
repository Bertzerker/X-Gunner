#!/usr/bin/env python3

import array
import fcntl
import glob
import os
import signal
import struct
import sys
import time

BUS_USB = 0x03

EV_SYN = 0x00
EV_KEY = 0x01
EV_ABS = 0x03

SYN_REPORT = 0

BTN_LEFT = 0x110
BTN_RIGHT = 0x111
BTN_MIDDLE = 0x112
BTN_SIDE = 0x113
BTN_EXTRA = 0x114

ABS_X = 0x00
ABS_Y = 0x01

EVIOCGABS_BASE = 0x80184540
EVIOCGRAB = 0x40044590

UI_DEV_CREATE = 0x5501
UI_DEV_DESTROY = 0x5502
UI_SET_EVBIT = 0x40045564
UI_SET_KEYBIT = 0x40045565
UI_SET_ABSBIT = 0x40045567

UINPUT_PATH = "/dev/uinput"
EVENT_FMT = "llHHl"
EVENT_SIZE = struct.calcsize(EVENT_FMT)


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
    return word < len(words) and bool(words[word] & (1 << off))


def find_xgunner_mouse():
    for event_path in sorted(glob.glob("/sys/class/input/event*")):
        device_path = os.path.join(event_path, "device")
        name = read_text(os.path.join(device_path, "name"))
        vendor = read_text(os.path.join(device_path, "id/vendor"))
        product = read_text(os.path.join(device_path, "id/product"))
        abs_caps = read_text(os.path.join(device_path, "capabilities/abs"))
        if vendor != "1209" or product not in {"0001", "0002", "0003", "0004"}:
            continue
        if "XGUNNER" not in name or "Mouse" not in name:
            continue
        if not (test_bit(abs_caps, ABS_X) and test_bit(abs_caps, ABS_Y)):
            continue
        return f"/dev/input/{os.path.basename(event_path)}", name, int(product, 16)
    raise RuntimeError("X-GUNNER Mouse event device not found")


def abs_info(fd, axis):
    buf = array.array("i", [0, 0, 0, 0, 0, 0])
    fcntl.ioctl(fd, EVIOCGABS_BASE + axis, buf, True)
    return buf.tolist()


def emit(uinput, event_type, code, value):
    now = time.time()
    sec = int(now)
    usec = int((now - sec) * 1_000_000)
    os.write(uinput, struct.pack(EVENT_FMT, sec, usec, event_type, code, value))


def create_virtual_lightgun(source_fd, player_pid):
    uinput = os.open(UINPUT_PATH, os.O_WRONLY | os.O_NONBLOCK)
    for event_type in (EV_KEY, EV_ABS):
        fcntl.ioctl(uinput, UI_SET_EVBIT, event_type)
    for key in (BTN_LEFT, BTN_RIGHT, BTN_MIDDLE, BTN_SIDE, BTN_EXTRA):
        fcntl.ioctl(uinput, UI_SET_KEYBIT, key)
    for axis in (ABS_X, ABS_Y):
        fcntl.ioctl(uinput, UI_SET_ABSBIT, axis)

    _, min_x, max_x, fuzz_x, flat_x, res_x = abs_info(source_fd, ABS_X)
    _, min_y, max_y, fuzz_y, flat_y, res_y = abs_info(source_fd, ABS_Y)

    name = b"XGUNNER MiSTer Lightgun"
    user_dev = bytearray(80 + 8 + 4 + (64 * 4 * 4))
    user_dev[0:len(name)] = name

    # Pretend to be a Retroshooter P1-P4 device. Stock Main_MiSTer already
    # treats 0483:5750-5753 as QUIRK_LIGHTGUN_MOUSE.
    virtual_pid = 0x5750 + max(0, min(player_pid - 1, 3))
    struct.pack_into("HHHH", user_dev, 80, BUS_USB, 0x0483, virtual_pid, 0x0111)

    absmax_offset = 80 + 8 + 4
    absmin_offset = absmax_offset + 64 * 4
    absfuzz_offset = absmin_offset + 64 * 4
    absflat_offset = absfuzz_offset + 64 * 4

    struct.pack_into("i", user_dev, absmax_offset + ABS_X * 4, max_x)
    struct.pack_into("i", user_dev, absmax_offset + ABS_Y * 4, max_y)
    struct.pack_into("i", user_dev, absmin_offset + ABS_X * 4, min_x)
    struct.pack_into("i", user_dev, absmin_offset + ABS_Y * 4, min_y)
    struct.pack_into("i", user_dev, absfuzz_offset + ABS_X * 4, fuzz_x)
    struct.pack_into("i", user_dev, absfuzz_offset + ABS_Y * 4, fuzz_y)
    struct.pack_into("i", user_dev, absflat_offset + ABS_X * 4, flat_x)
    struct.pack_into("i", user_dev, absflat_offset + ABS_Y * 4, flat_y)

    os.write(uinput, user_dev)
    fcntl.ioctl(uinput, UI_DEV_CREATE)
    time.sleep(1)
    return uinput, virtual_pid


def main():
    source_path, source_name, player_pid = find_xgunner_mouse()
    print(f"Using {source_path}: {source_name}", flush=True)
    source_fd = os.open(source_path, os.O_RDONLY | os.O_NONBLOCK)
    grabbed_source = False
    try:
        fcntl.ioctl(source_fd, EVIOCGRAB, 1)
        grabbed_source = True
        print("Grabbed source device", flush=True)
    except OSError as exc:
        print(f"Could not grab source device, continuing without grab: {exc}", flush=True)

    uinput, virtual_pid = create_virtual_lightgun(source_fd, player_pid)
    print(f"Created virtual Retroshooter lightgun 0483:{virtual_pid:04x}", flush=True)

    running = True

    def stop(_signum, _frame):
        nonlocal running
        running = False

    signal.signal(signal.SIGTERM, stop)
    signal.signal(signal.SIGINT, stop)

    try:
        while running:
            try:
                data = os.read(source_fd, EVENT_SIZE)
            except BlockingIOError:
                time.sleep(0.002)
                continue
            if len(data) != EVENT_SIZE:
                continue
            _sec, _usec, event_type, code, value = struct.unpack(EVENT_FMT, data)
            if event_type == EV_ABS and code in (ABS_X, ABS_Y):
                emit(uinput, event_type, code, value)
                emit(uinput, EV_SYN, SYN_REPORT, 0)
            elif event_type == EV_KEY and code in (BTN_LEFT, BTN_RIGHT, BTN_MIDDLE, BTN_SIDE, BTN_EXTRA):
                emit(uinput, event_type, code, value)
                emit(uinput, EV_SYN, SYN_REPORT, 0)
    finally:
        try:
            if grabbed_source:
                fcntl.ioctl(source_fd, EVIOCGRAB, 0)
        except OSError:
            pass
        try:
            fcntl.ioctl(uinput, UI_DEV_DESTROY)
        except OSError:
            pass
        os.close(source_fd)
        os.close(uinput)


if __name__ == "__main__":
    try:
        main()
    except Exception as exc:
        print(f"xgunner_lightgun_shim.py: {exc}", file=sys.stderr)
        sys.exit(1)

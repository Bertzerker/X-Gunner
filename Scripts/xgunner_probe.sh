#!/bin/sh

# X-GUNNER probe for MiSTer.
# Run on the MiSTer while the X-GUNNER dongle/gun is connected.

choose_report_dir() {
  for dir in /media/fat/Scripts /media/fat/config /media/fat "$(pwd)"; do
    [ -d "$dir" ] || continue
    [ -w "$dir" ] || continue
    printf '%s' "$dir"
    return
  done
  printf '%s' "."
}

REPORT_DIR="${XGUNNER_REPORT_DIR:-$(choose_report_dir)}"
OUT="${1:-$REPORT_DIR/xgunner_probe_$(date +%Y%m%d-%H%M%S).txt}"

say() {
  printf '%s\n' "$*" | tee -a "$OUT"
}

section() {
  say ""
  say "== $* =="
}

if ! : > "$OUT" 2>/dev/null; then
  OUT="./xgunner_probe_$(date +%Y%m%d-%H%M%S).txt"
  : > "$OUT"
fi

section "System"
say "Report path: $OUT"
say "Date: $(date)"
say "Kernel: $(uname -a)"

section "USB Devices"
if command -v lsusb >/dev/null 2>&1; then
  lsusb | tee -a "$OUT"
else
  say "lsusb not available"
fi

section "Linux Input Devices"
cat /proc/bus/input/devices | tee -a "$OUT"

section "X-GUNNER Candidate Event Devices"
found=0
for ev in /sys/class/input/event*; do
  [ -e "$ev" ] || continue
  dev="$ev/device"
  vendor="$(cat "$dev/id/vendor" 2>/dev/null)"
  product="$(cat "$dev/id/product" 2>/dev/null)"
  name="$(cat "$dev/name" 2>/dev/null)"
  handlers="$(grep -A6 "Name=\"$name\"" /proc/bus/input/devices 2>/dev/null | grep Handlers | head -n 1)"
  case "$vendor:$product" in
    1209:0001|1209:0002|1209:0003|1209:0004)
      found=1
      say "$(basename "$ev") vendor=$vendor product=$product name=$name"
      say "$handlers"
      ;;
  esac
done

if [ "$found" -eq 0 ]; then
  say "No 1209:0001-0004 input device found. Check power, receiver pairing, and mode."
fi

section "Live Event Hints"
say "If evtest is installed, run:"
say "  evtest /dev/input/eventX"
say "For MiSTer lightgun support, the important signs are ABS_X and ABS_Y movement plus mouse/trigger buttons."
say ""
say "Report written to $OUT"

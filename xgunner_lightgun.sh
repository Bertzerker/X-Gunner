#!/bin/sh

SCRIPT="/media/fat/Scripts/xgunner_lightgun_shim.py"
PIDFILE="/tmp/xgunner_lightgun_shim.pid"
LOG="/media/fat/Scripts/xgunner_lightgun_shim.log"

start_shim() {
  if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    echo "X-GUNNER lightgun shim is already running: PID $(cat "$PIDFILE")"
    return 0
  fi

  if [ ! -e /dev/uinput ]; then
    echo "/dev/uinput not found. Cannot create virtual lightgun."
    return 1
  fi

  nohup python3 "$SCRIPT" >> "$LOG" 2>&1 &
  echo $! > "$PIDFILE"
  sleep 2

  if kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    echo "X-GUNNER lightgun shim started: PID $(cat "$PIDFILE")"
    echo "Log: $LOG"
  else
    echo "X-GUNNER lightgun shim failed to start. Log:"
    tail -n 20 "$LOG"
    rm -f "$PIDFILE"
    return 1
  fi
}

stop_shim() {
  if [ ! -f "$PIDFILE" ]; then
    echo "X-GUNNER lightgun shim is not running."
    return 0
  fi

  pid="$(cat "$PIDFILE")"
  kill "$pid" 2>/dev/null
  sleep 1
  if kill -0 "$pid" 2>/dev/null; then
    kill -9 "$pid" 2>/dev/null
  fi
  rm -f "$PIDFILE"
  echo "X-GUNNER lightgun shim stopped."
}

status_shim() {
  if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    echo "X-GUNNER lightgun shim is running: PID $(cat "$PIDFILE")"
  else
    echo "X-GUNNER lightgun shim is not running."
  fi
  [ -f "$LOG" ] && tail -n 10 "$LOG"
}

case "$1" in
  start|"") start_shim ;;
  stop) stop_shim ;;
  restart) stop_shim; start_shim ;;
  status) status_shim ;;
  *) echo "Usage: xgunner_lightgun.sh [start|stop|restart|status]"; exit 1 ;;
esac

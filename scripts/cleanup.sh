#!/usr/bin/env bash
set -euo pipefail
TARGET_DIR="${1:-/var/log}"
DAYS="${2:-7}"
find "$TARGET_DIR" -type f -name "*.log" -mtime +"$DAYS" -print -delete
echo "OK: cleaned *.log older than ${DAYS}d in $TARGET_DIR"

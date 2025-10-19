#!/usr/bin/env bash
set -euo pipefail
SRC_DIR="${1:-$HOME}"
DEST_DIR="/tmp/backups"
STAMP="$(date +%Y%m%d_%H%M%S)"
ARCHIVE="${DEST_DIR}/backup_$(basename "$SRC_DIR")_${STAMP}.tar.gz"
mkdir -p "$DEST_DIR"
tar -C "$(dirname "$SRC_DIR")" -czf "$ARCHIVE" "$(basename "$SRC_DIR")"
echo "OK: $ARCHIVE"

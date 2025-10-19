#!/usr/bin/env bash
set -euo pipefail

DISK_THRESH="${DISK_THRESH:-85}"   # percent
LOAD_THRESH="${LOAD_THRESH:-2.0}"  # 1-min load average

disk_used="$(df -P / | awk 'NR==2{gsub(/%/,"",$5); print $5}')"
load_1m="$(awk '{print $1}' /proc/loadavg)"

status=0
msg="OK"

# disk check
if (( disk_used > DISK_THRESH )); then
  msg="WARN: disk ${disk_used}% > ${DISK_THRESH}%"
  status=1
fi

# cpu/load check (returns 0 if OK, 1 if high)
if awk -v l="$load_1m" -v t="$LOAD_THRESH" 'BEGIN{exit (l>t)?1:0}'; then
  :  # do nothing, load is OK
else
  msg="${msg}; CPU load ${load_1m} > ${LOAD_THRESH}"
  status=1
fi

echo "$msg | disk=${disk_used}% load1=${load_1m}"
exit $status

#!/usr/bin/env bash
set -euo pipefail
OUTDIR="${1:-/var/log/procmon}"
mkdir -p "$OUTDIR"
STAMP=$(date +'%F_%H-%M-%S')
{
  echo "===== TOP CPU ($STAMP) ====="
  ps -eo pid,ppid,comm,%cpu,%mem --sort=-%cpu | head -n 10
  echo
  echo "===== TOP MEM ($STAMP) ====="
  ps -eo pid,ppid,comm,%mem,%cpu --sort=-%mem | head -n 10
  echo
  echo "===== VMSTAT (1x1) ====="
  vmstat 1 1
  echo
  echo "===== IOSTAT (1x1) ====="
  iostat 1 1
} >> "$OUTDIR/snapshots.log"
echo "Snapshot written to $OUTDIR/snapshots.log"

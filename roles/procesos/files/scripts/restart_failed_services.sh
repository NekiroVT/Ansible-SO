#!/usr/bin/env bash
set -euo pipefail
FAILED=$(systemctl --failed --no-legend | awk '{print $1}')
if [ -z "$FAILED" ]; then
  echo "No failed units."
  exit 0
fi
echo "Restarting failed units..."
for s in $FAILED; do
  systemctl restart "$s" || true
done
echo "Restarted: $FAILED"

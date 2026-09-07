#!/usr/bin/env bash
set -euo pipefail

COUNTRY="${1:-US}"
OUTER_PROTO="${2:-awg}"
INNER_PROTO="${3:-wg}"

mkdir -p work configs
if [ ! -f work/warpscout-account.json ]; then
  warpscout register
fi

OUTER="$(warpscout scan -p "$OUTER_PROTO" -country "$COUNTRY" -P -best -no-report | tail -n1)"
echo "Outer: $OUTER"

warpscout scan \
  -p "$OUTER_PROTO" \
  -inner-proto "$INNER_PROTO" \
  -through "$OUTER" \
  -P \
  -best \
  -no-report \
  -conf configs/warp-in-warp.yaml \
  -conf-type mihomo

cp configs/warp-in-warp.yaml configs/warp-in-warp.txt
echo "Generated configs/warp-in-warp.yaml"

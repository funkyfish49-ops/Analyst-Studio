#!/usr/bin/env bash
# Refreshes the Forecast Lab's daily close snapshots (5y, one row per trading day).
# Written by the Entropic Forecast Lab publish pipeline; run from anywhere —
# output always lands next to this script.
# Sources: Yahoo Finance chart API (browser User-Agent required, else 429).
set -euo pipefail

UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"
SYMBOLS="SPY QQQ AAPL NVDA TSLA GLD"
OUT_DIR="$(cd "$(dirname "$0")" && pwd)"
FILTER='.chart.result[0] as $r | "date,close", ([range(0; ($r.timestamp|length)) as $i | select($r.indicators.quote[0].close[$i] != null) | ($r.timestamp[$i]|todate|.[0:10]) + "," + ($r.indicators.quote[0].close[$i]|tostring)] | .[])'

for SYM in $SYMBOLS; do
  for HOST in query2 query1; do
    if curl -sS --fail --retry 3 --retry-delay 10 --retry-all-errors \
         -H "User-Agent: $UA" -H "Accept: application/json" \
         "https://${HOST}.finance.yahoo.com/v8/finance/chart/${SYM}?range=5y&interval=1d" \
         -o /tmp/efl-${SYM}.json; then
      jq -r "$FILTER" /tmp/efl-${SYM}.json > "${OUT_DIR}/${SYM}.csv"
      echo "${SYM}: $(wc -l < "${OUT_DIR}/${SYM}.csv") rows -> ${OUT_DIR}/${SYM}.csv (last: $(tail -1 "${OUT_DIR}/${SYM}.csv"))"
      break
    fi
    sleep 5
  done
done
rm -f /tmp/efl-*.json
echo "Done."

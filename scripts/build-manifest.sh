#!/usr/bin/env bash
# build-manifest.sh — produces manifest.json listing every .md file under
# space-marines/, tyranids/, schema/ with its SHA-256 content hash.
# Consumed by Command Auspex's runtime HTTPS sync.
set -euo pipefail
cd "$(dirname "$0")/.."

OUT=manifest.json
TMP="$(mktemp)"

printf '{\n  "generated": "%s",\n  "files": {\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" > "$TMP"

FIRST=1
find space-marines tyranids schema -type f -name '*.md' -print0 2>/dev/null \
| LC_ALL=C sort -z \
| while IFS= read -r -d '' f; do
    HASH=$(shasum -a 256 "$f" | cut -d' ' -f1)
    if [ "$FIRST" -eq 1 ]; then
        FIRST=0
    else
        printf ',\n' >> "$TMP"
    fi
    printf '    "%s": "%s"' "$f" "$HASH" >> "$TMP"
done

printf '\n  }\n}\n' >> "$TMP"
mv "$TMP" "$OUT"
echo "manifest: wrote $OUT ($(grep -c ':' "$OUT") entries)"

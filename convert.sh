#!/usr/bin/env bash
# Rebuild tiff/ from raw/: darktable default development, 8-bit RGB TIFF, deflate.
# Existing frames are skipped, so an interrupted run can be restarted.
set -euo pipefail
cd "$(dirname "$0")"
cfg=$(mktemp -d); trap 'rm -rf "$cfg"' EXIT
mkdir -p tiff
for f in raw/*.CR3; do
  out=tiff/$(basename "$f" .CR3).tif
  if [ ! -e "$out" ]; then
    darktable-cli "$f" "$out" --apply-custom-presets false --core \
      --configdir "$cfg" --library :memory: \
      --conf plugins/imageio/format/tiff/bpp=8 \
      --conf plugins/imageio/format/tiff/compress=2 >/dev/null
  fi
done

#!/usr/bin/env bash
# Download the first N frames of the stack from Hugging Face.
# Usage: ./download.sh 10|100|500|999 [raw]
set -euo pipefail
dir=tiff ext=tif
if [ "${2:-}" = raw ]; then dir=raw ext=CR3; fi
case "${1:-}" in
  10)  g='frame_00?' ;;
  100) g='frame_0??' ;;
  500) g='frame_[0-4]??' ;;
  999) g='frame_*' ;;
  *) echo "usage: $0 10|100|500|999 [raw]" >&2; exit 1 ;;
esac
hf download jjjsood/focus-stack-sample --repo-type dataset --local-dir . \
  --include "$dir/$g.$ext"

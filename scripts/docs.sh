#!/usr/bin/env bash
set -euo pipefail
exec "${GOOSE:-goose}" run "${GOOSE_DOC:-../goose-doc/main.goose}" -- \
  --title "goose-raylib API" --symbols api.txt --require-docs \
  --output "${DOC_OUTPUT:-API.md}" "$@" raylib.goose
